//
//  ForecastViewController.m
//  taichungdiving
//
//  Created by Samuel Teng on 2014/8/20.
//  Copyright (c) 2014年 SamuelTeng. All rights reserved.
//

#import "ForecastViewController.h"
#import "Record.h"
#import "AppDelegate.h"

static NSString *linkPosition=@"http://opendata.cwb.gov.tw/opendata/MFC/F-A0012-001.xml";
static NSString *kAreaForecastData = @"AreaForecastData";
static NSString *kTime = @"Time";
static NSString *kDescription = @"Description";
static NSString *kDir = @"Dir";
static NSString *kSpeed = @"Speed";
static NSString *kHeight = @"Height";
static NSString *kType = @"Type";

@interface ForecastViewController ()

/*parse the data receiving from gov open data*/
-(void)parseXML:(NSData *)theData;
-(NSString *)realTime:(NSString *)date;

@end

@implementation ForecastViewController{
    
    NSURLConnection *conn;
    NSMutableData *receiveData;
    NSString *openData;
    NSXMLParser *parser;
    NSArray *tagNames;
    BOOL readable;
    NSString *tempString;
    NSMutableArray *records;
    Record *record;
    AppDelegate *delegate;
}

//@synthesize forecast;
//@synthesize managedObjectContext;
@synthesize map,annotation,latitude,lontitude,annotations;

-(void)loadView
{
    [super loadView];
    delegate = [[UIApplication sharedApplication] delegate];
    
    map = [[MKMapView alloc] initWithFrame:delegate.window.frame];
    [self.view addSubview: map];
    
    latitude = [[NSArray alloc] initWithObjects:@"25.7088968", nil];
    lontitude = [[NSArray alloc] initWithObjects:@"123.4515834", nil];
    
    /*cease the usage of core data in this class*/
    /*never forget declare NSManagedObjectContext
    managedObjectContext = [delegate managedObjectContext];
    */
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"更新" style:UIBarButtonItemStyleBordered target:self action:@selector(reload_data)];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([records count] != 0){
        
        [self addAnnotations];
        
    }
}

-(void)loadData
{
    NSURL *url=[NSURL URLWithString:linkPosition];
    conn=[NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:url] delegate:self];
}

-(void)reload_data
{
    [self loadData];
    
}
//NSURLConnectionDataDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    receiveData=[NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receiveData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    openData = [[NSString alloc]initWithBytes:[receiveData bytes] length:[receiveData length] encoding:NSUTF8StringEncoding];
    [self parseXML:receiveData];
}

/*paring process*/
-(void)parseXML:(NSData *)theData
{
    parser=[[NSXMLParser alloc]initWithData:theData];
    parser.delegate=self;
    [parser parse];
    
}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    records = [NSMutableArray array];
    tagNames = [NSArray arrayWithObjects:kAreaForecastData,kTime,kDir,kDescription,kSpeed,kType,kHeight, nil];
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:kAreaForecastData]) {
        record = [[Record alloc] init];
        record.area_ForecastData = [attributeDict objectForKey:@"area"];
        return;
    }
    readable = [tagNames containsObject:elementName];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (readable) {
        tempString=string;
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    if (readable) {
        if ([elementName isEqualToString:kTime]) {
            NSString *_tempString = [tempString stringByReplacingOccurrencesOfString:@"T" withString:@" "];
            NSString *tempString_ = [_tempString stringByReplacingOccurrencesOfString:@"+08:00" withString:@""];
            record.ti_me = [self realTime:tempString_];
        }else if ([elementName isEqualToString:kDescription]){
            record.descrip_tion = tempString;
        }else if ([elementName isEqualToString:kDir]){
            record.direc_tion = tempString;
        }else if ([elementName isEqualToString:kSpeed]){
            record.spe_ed = tempString;
        }else if ([elementName isEqualToString:kHeight]){
            record.hei_ght = tempString;
        }else if ([elementName isEqualToString:kType]){
            record.ty_pe = tempString;
        }
        
    }
    
    if ([elementName isEqualToString:kAreaForecastData]) {
        [records addObject:record];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    
     for (int i=0; i<[records count]; i++) {
         
         Record *theRecord = [records objectAtIndex:i];
         
         /* too complicated for daily updating forecast
          
         forecast = (Forecast *)[NSEntityDescription insertNewObjectForEntityForName:@"Forecast" inManagedObjectContext:managedObjectContext];
         
         forecast.area = theRecord.area_ForecastData;
         forecast.time = theRecord.ti_me;
         forecast.weather_description = theRecord.descrip_tion;
         forecast.wind_dir = theRecord.direc_tion;
         forecast.wind_speed = theRecord.spe_ed;
         forecast.wave_height = theRecord.hei_ght;
         forecast.wave_type = theRecord.ty_pe;
         
         NSError *error;
         if (![managedObjectContext save:&error]) {
             NSLog(@"error:%@", [error localizedFailureReason]);
         }
         */
         
     }
    
}



-(NSString *)realTime:(NSString *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *parsedDate = [dateFormatter dateFromString:date];
    //NSLog(@"%@",parsedDate);
    int timeToMinus = -1;
    NSDate *actualDate = [parsedDate dateByAddingTimeInterval:60*60*24*timeToMinus];
    NSString *forcastStartedDate = [dateFormatter stringFromDate:actualDate];
    return forcastStartedDate;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    
}

-(void)addAnnotations
{
    CLLocationCoordinate2D forecastCoordinate;
    annotation = [[ForecastAnnotation alloc] init];
    
    CLLocationDegrees _latitude = [[latitude objectAtIndex:0]doubleValue];
    CLLocationDegrees _lontitude = [[lontitude objectAtIndex:0]doubleValue];
    
    forecastCoordinate.latitude = _latitude;
    forecastCoordinate.longitude = _lontitude;
    
    annotation._coordinate = forecastCoordinate;
    
    if ([records count] != 0) {
        NSArray *recordArr = [records copy];
        Record *rEcOrD = recordArr[0];
        annotation.area = rEcOrD.area_ForecastData;
        annotation.time = rEcOrD.ti_me;
    }
    
    
    [map addAnnotation:annotation];
    [annotations addObject:annotation];
    
    /*make all annotations visible when view load*/
    MKMapRect focus = MKMapRectNull;
    for ( annotation in annotations) {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
        
        if (MKMapRectIsNull(focus)) {
            focus = pointRect;
        }else{
            focus = MKMapRectUnion(focus, pointRect);
        }
    }
    
    map.visibleMapRect = focus;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id < MKAnnotation >)aAnnotation
{
    if ([aAnnotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    if ([aAnnotation isKindOfClass:[ForecastAnnotation class]]) {
        static NSString *forecastIdentifier = @"forecastIdentifier";
        MKPinAnnotationView *forecastPin = (MKPinAnnotationView *)[map dequeueReusableAnnotationViewWithIdentifier:forecastIdentifier];
        
        if (forecastPin == nil) {
            MKPinAnnotationView *customView = [[MKPinAnnotationView alloc] initWithAnnotation:aAnnotation reuseIdentifier:forecastIdentifier];
            customView.pinColor = MKPinAnnotationColorPurple;
            customView.animatesDrop = NO;
            customView.canShowCallout = YES;
            
            UIButton *showLog = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            
            customView.rightCalloutAccessoryView = showLog;
            return customView;
            
        }else{
            
            forecastPin.annotation = aAnnotation;
        }
        
        return forecastPin;
    }
    
    return nil;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
