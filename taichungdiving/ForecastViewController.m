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
#import "ForecastDetailViewController.h"

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
@synthesize map,annotation,latitude,lontitude,annotations,fishingPlatform1,fishingPlatform2,fishingPlatform3,keelung1,keelung2,keelung3,yilan1,yilan2,yilan3,hsinchu1,hsinchu2,hsinchu3,penhu1,penhu2,penhu3,lukang1,lukang2,lukang3,dongshih1,dongshih2,dongshih3,anping1,anping2,anping3,kaohsiung1,kaohsiung2,kaohsiung3,fangliao1,fangliao2,fangliao3,gooseNose1,gooseNose2,gooseNose3,success1,success2,success3,taitung1,taitung2,taitung3,greenIsland1,greenIsland2,greenIsland3,huallen1,huallen2,huallen3;

-(void)loadView
{
    [super loadView];
    delegate = [[UIApplication sharedApplication] delegate];
    
    map = [[MKMapView alloc] initWithFrame:delegate.window.frame];
    [self.view addSubview: map];
    map.delegate = self;
    /*坐標依序：釣魚台海面,彭佳嶼基隆海面,宜蘭蘇澳沿海,新竹鹿港沿海,澎湖海面,鹿港東石沿海,東石安平沿海,安平高雄沿海,高雄枋寮沿海,枋寮恆春沿海,鵝鑾鼻沿海,成功臺東沿海,臺東大武沿海,綠島蘭嶼海面,花蓮沿海*/
    latitude = [NSArray arrayWithObjects:@"25.7088968",@"25.6294957",@"24.7528147",@"24.660962",@"23.486661",@"23.855258",@"23.105262",@"22.681195",@"22.472674",@"22.2799039",@"21.932397",@"22.833059",@"22.696872",@"22.364651",@"23.972974", nil];
    lontitude = [NSArray arrayWithObjects:@"123.4515834",@"122.0713482",@"122.0063745",@"120.536266",@"119.592472",@"120.155985",@"120.018149",@"120.200045",@"120.354712",@"120.593212",@"120.790623",@"121.227040",@"121.094564",@"121.521400",@"121.636070", nil];
    
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
    
    [self reload_data];
    
    if ([records count] != 0){
        
        [self addAnnotations];
        
    }
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self reload_data];
    
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
    [self dataSorting];
    
    if ([records count] != 0){
        
        [self addAnnotations];
        
    }

    /*
     for (int i=0; i<[records count]; i++) {
         
         Record *theRecord = [records objectAtIndex:i];
         
          too complicated for daily updating forecast
          
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
     
         
     }
     */
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
    ForecastDetailViewController *detail = [[ForecastDetailViewController alloc] initWithAnnoation:view.annotation];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:detail];
    nav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:nav animated:YES completion:^{}];
}

-(void)addAnnotations
{
    CLLocationCoordinate2D forecastCoordinate;
    
    
    for (int i = 0; i<latitude.count; i++) {
        annotation = [[ForecastAnnotation alloc] init];
        CLLocationDegrees _latitude = [[latitude objectAtIndex:i]doubleValue];
        CLLocationDegrees _lontitude = [[lontitude objectAtIndex:i]doubleValue];
        
        forecastCoordinate.latitude = _latitude;
        forecastCoordinate.longitude = _lontitude;
        
        annotation._coordinate = forecastCoordinate;
        
        switch (i) {
            case 0:
                annotation.area = fishingPlatform1.area_ForecastData;
                annotation.subtitleTime = [NSString stringWithFormat:@"%@~%@",fishingPlatform1.ti_me,fishingPlatform3.ti_me];
                
                annotation.time = fishingPlatform1.ti_me;
                annotation.wave_type = fishingPlatform1.ty_pe;
                annotation.wave_height = fishingPlatform1.hei_ght;
                annotation.weather_description = fishingPlatform1.descrip_tion;
                annotation.wind_dir = fishingPlatform1.direc_tion;
                annotation.wind_speed = fishingPlatform1.spe_ed;
                
                annotation.time2 = fishingPlatform2.ti_me;
                annotation.wave_type2 = fishingPlatform2.ty_pe;
                annotation.wave_height2 = fishingPlatform2.hei_ght;
                annotation.weather_description2 = fishingPlatform2.descrip_tion;
                annotation.wind_dir2 = fishingPlatform2.direc_tion;
                annotation.wind_speed2 = fishingPlatform2.spe_ed;
                
                annotation.time3 = fishingPlatform3.ti_me;
                annotation.wave_type3 = fishingPlatform3.ty_pe;
                annotation.wave_height3 = fishingPlatform3.hei_ght;
                annotation.weather_description3 = fishingPlatform3.descrip_tion;
                annotation.wind_dir3 = fishingPlatform3.direc_tion;
                annotation.wind_speed3 = fishingPlatform3.spe_ed;
                
                break;
            case 1:
                annotation.area = keelung1.area_ForecastData;
                annotation.subtitleTime = [NSString stringWithFormat:@"%@~%@",keelung1.ti_me,keelung3.ti_me];
                
                annotation.time = keelung1.ti_me;
                annotation.wave_type = keelung1.ty_pe;
                annotation.wave_height = keelung1.hei_ght;
                annotation.weather_description = keelung1.descrip_tion;
                annotation.wind_dir = keelung1.direc_tion;
                annotation.wind_speed = keelung1.spe_ed;
                
                annotation.time2 = keelung2.ti_me;
                annotation.wave_type2 = keelung2.ty_pe;
                annotation.wave_height2 = keelung2.hei_ght;
                annotation.weather_description2 = keelung2.descrip_tion;
                annotation.wind_dir2 = keelung2.direc_tion;
                annotation.wind_speed2 = keelung2.spe_ed;
                
                annotation.time3 = keelung3.ti_me;
                annotation.wave_type3 = keelung3.ty_pe;
                annotation.wave_height3 = keelung3.hei_ght;
                annotation.weather_description3 = keelung3.descrip_tion;
                annotation.wind_dir3 = keelung3.direc_tion;
                annotation.wind_speed3 = keelung3.spe_ed;
                
                break;
            case 2:
                annotation.area = yilan1.area_ForecastData;
                annotation.subtitleTime = [NSString stringWithFormat:@"%@~%@",yilan1.ti_me,yilan3.ti_me];
                
                annotation.time = yilan1.ti_me;
                annotation.wave_type = yilan1.ty_pe;
                annotation.wave_height = yilan1.hei_ght;
                annotation.weather_description = yilan1.descrip_tion;
                annotation.wind_dir = yilan1.direc_tion;
                annotation.wind_speed = yilan1.spe_ed;
                
                annotation.time2 = yilan2.ti_me;
                annotation.wave_type2 = yilan2.ty_pe;
                annotation.wave_height2 = yilan2.hei_ght;
                annotation.weather_description2 = yilan2.descrip_tion;
                annotation.wind_dir2 = yilan2.direc_tion;
                annotation.wind_speed2 = yilan2.spe_ed;
                
                annotation.time3 = yilan3.ti_me;
                annotation.wave_type3 = yilan3.ty_pe;
                annotation.wave_height3 = yilan3.hei_ght;
                annotation.weather_description3 = yilan3.descrip_tion;
                annotation.wind_dir3 = yilan3.direc_tion;
                annotation.wind_speed3 = yilan3.spe_ed;
                
                break;
            case 3:
                annotation.area = hsinchu1.area_ForecastData;
                annotation.subtitleTime = [NSString stringWithFormat:@"%@~%@",hsinchu1.ti_me,hsinchu3.ti_me];
                
                annotation.time = hsinchu1.ti_me;
                annotation.wave_type = hsinchu1.ty_pe;
                annotation.wave_height = hsinchu1.hei_ght;
                annotation.weather_description = hsinchu1.descrip_tion;
                annotation.wind_dir = hsinchu1.direc_tion;
                annotation.wind_speed = hsinchu1.spe_ed;
                
                annotation.time2 = hsinchu2.ti_me;
                annotation.wave_type2 = hsinchu2.ty_pe;
                annotation.wave_height2 = hsinchu2.hei_ght;
                annotation.weather_description2 = hsinchu2.descrip_tion;
                annotation.wind_dir2 = hsinchu2.direc_tion;
                annotation.wind_speed2 = hsinchu2.spe_ed;
                
                annotation.time3 = hsinchu3.ti_me;
                annotation.wave_type3 = hsinchu3.ty_pe;
                annotation.wave_height3 = hsinchu3.hei_ght;
                annotation.weather_description3 = hsinchu3.descrip_tion;
                annotation.wind_dir3 = hsinchu3.direc_tion;
                annotation.wind_speed3 = hsinchu3.spe_ed;
                
                break;
            case 4:
                annotation.area = penhu1.area_ForecastData;
                annotation.subtitleTime = [NSString stringWithFormat:@"%@~%@",penhu1.ti_me,penhu3.ti_me];
                
                annotation.time = penhu1.ti_me;
                annotation.wave_type = penhu1.ty_pe;
                annotation.wave_height = penhu1.hei_ght;
                annotation.weather_description = penhu1.descrip_tion;
                annotation.wind_dir = penhu1.direc_tion;
                annotation.wind_speed = penhu1.spe_ed;
                
                annotation.time2 = penhu2.ti_me;
                annotation.wave_type2 = penhu2.ty_pe;
                annotation.wave_height2 = penhu2.hei_ght;
                annotation.weather_description2 = penhu2.descrip_tion;
                annotation.wind_dir2 = penhu2.direc_tion;
                annotation.wind_speed2 = penhu2.spe_ed;
                
                annotation.time3 = penhu3.ti_me;
                annotation.wave_type3 = penhu3.ty_pe;
                annotation.wave_height3 = penhu3.hei_ght;
                annotation.weather_description3 = penhu3.descrip_tion;
                annotation.wind_dir3 = penhu3.direc_tion;
                annotation.wind_speed3 = penhu3.spe_ed;
                
                break;
            case 5:
                annotation.area = lukang1.area_ForecastData;
                annotation.subtitleTime = [NSString stringWithFormat:@"%@~%@",lukang1.ti_me,lukang3.ti_me];
                
                annotation.time = lukang1.ti_me;
                annotation.wave_type = lukang1.ty_pe;
                annotation.wave_height = lukang1.hei_ght;
                annotation.weather_description = lukang1.descrip_tion;
                annotation.wind_dir = lukang1.direc_tion;
                annotation.wind_speed = lukang1.spe_ed;
                
                annotation.time2 = lukang2.ti_me;
                annotation.wave_type2 = lukang2.ty_pe;
                annotation.wave_height2 = lukang2.hei_ght;
                annotation.weather_description2 = lukang2.descrip_tion;
                annotation.wind_dir2 = lukang2.direc_tion;
                annotation.wind_speed2 = lukang2.spe_ed;
                
                annotation.time3 = lukang3.ti_me;
                annotation.wave_type3 = lukang3.ty_pe;
                annotation.wave_height3 = lukang3.hei_ght;
                annotation.weather_description3 = lukang3.descrip_tion;
                annotation.wind_dir3 = lukang3.direc_tion;
                annotation.wind_speed3 = lukang3.spe_ed;
                
                break;
            case 6:
                annotation.area = dongshih1.area_ForecastData;
                annotation.subtitleTime = [NSString stringWithFormat:@"%@~%@",dongshih1.ti_me,dongshih3.ti_me];
                
                annotation.time = dongshih1.ti_me;
                annotation.wave_type = dongshih1.ty_pe;
                annotation.wave_height = dongshih1.hei_ght;
                annotation.weather_description = dongshih1.descrip_tion;
                annotation.wind_dir = dongshih1.direc_tion;
                annotation.wind_speed = dongshih1.spe_ed;
                
                annotation.time2 = dongshih2.ti_me;
                annotation.wave_type2 = dongshih2.ty_pe;
                annotation.wave_height2 = dongshih2.hei_ght;
                annotation.weather_description2 = dongshih2.descrip_tion;
                annotation.wind_dir2 = dongshih2.direc_tion;
                annotation.wind_speed2 = dongshih2.spe_ed;
                
                annotation.time3 = dongshih3.ti_me;
                annotation.wave_type3 = dongshih3.ty_pe;
                annotation.wave_height3 = dongshih3.hei_ght;
                annotation.weather_description3 = dongshih3.descrip_tion;
                annotation.wind_dir3 = dongshih3.direc_tion;
                annotation.wind_speed3 = dongshih3.spe_ed;
                
                break;
            case 7:
                annotation.area = anping1.area_ForecastData;
                annotation.subtitleTime = [NSString stringWithFormat:@"%@~%@",anping1.ti_me,anping3.ti_me];
                
                annotation.time = anping1.ti_me;
                annotation.wave_type = anping1.ty_pe;
                annotation.wave_height = anping1.hei_ght;
                annotation.weather_description = anping1.descrip_tion;
                annotation.wind_dir = anping1.direc_tion;
                annotation.wind_speed = anping1.spe_ed;
                
                annotation.time2 = anping2.ti_me;
                annotation.wave_type2 = anping2.ty_pe;
                annotation.wave_height2 = anping2.hei_ght;
                annotation.weather_description2 = anping2.descrip_tion;
                annotation.wind_dir2 = anping2.direc_tion;
                annotation.wind_speed2 = anping2.spe_ed;
                
                annotation.time3 = anping3.ti_me;
                annotation.wave_type3 = anping3.ty_pe;
                annotation.wave_height3 = anping3.hei_ght;
                annotation.weather_description3 = anping3.descrip_tion;
                annotation.wind_dir3 = anping3.direc_tion;
                annotation.wind_speed3 = anping3.spe_ed;
                
                break;
            case 8:
                annotation.area = kaohsiung1.area_ForecastData;
                annotation.subtitleTime = [NSString stringWithFormat:@"%@~%@",kaohsiung1.ti_me,kaohsiung3.ti_me];
                
                annotation.time = kaohsiung1.ti_me;
                annotation.wave_type = kaohsiung1.ty_pe;
                annotation.wave_height = kaohsiung1.hei_ght;
                annotation.weather_description = kaohsiung1.descrip_tion;
                annotation.wind_dir = kaohsiung1.direc_tion;
                annotation.wind_speed = kaohsiung1.spe_ed;
                
                annotation.time2 = kaohsiung2.ti_me;
                annotation.wave_type2 = kaohsiung2.ty_pe;
                annotation.wave_height2 = kaohsiung2.hei_ght;
                annotation.weather_description2 = kaohsiung2.descrip_tion;
                annotation.wind_dir2 = kaohsiung2.direc_tion;
                annotation.wind_speed2 = kaohsiung2.spe_ed;
                
                annotation.time3 = kaohsiung3.ti_me;
                annotation.wave_type3 = kaohsiung3.ty_pe;
                annotation.wave_height3 = kaohsiung3.hei_ght;
                annotation.weather_description3 = kaohsiung3.descrip_tion;
                annotation.wind_dir3 = kaohsiung3.direc_tion;
                annotation.wind_speed3 = kaohsiung3.spe_ed;
                
                break;
            case 9:
                annotation.area = fangliao1.area_ForecastData;
                annotation.subtitleTime = [NSString stringWithFormat:@"%@~%@",fangliao1.ti_me,fangliao3.ti_me];
                
                annotation.time = fangliao1.ti_me;
                annotation.wave_type = fangliao1.ty_pe;
                annotation.wave_height = fangliao1.hei_ght;
                annotation.weather_description = fangliao1.descrip_tion;
                annotation.wind_dir = fangliao1.direc_tion;
                annotation.wind_speed = fangliao1.spe_ed;
                
                annotation.time2 = fangliao2.ti_me;
                annotation.wave_type2 = fangliao2.ty_pe;
                annotation.wave_height2 = fangliao2.hei_ght;
                annotation.weather_description2 = fangliao2.descrip_tion;
                annotation.wind_dir2 = fangliao2.direc_tion;
                annotation.wind_speed2 = fangliao2.spe_ed;
                
                annotation.time3 = fangliao3.ti_me;
                annotation.wave_type3 = fangliao3.ty_pe;
                annotation.wave_height3 = fangliao3.hei_ght;
                annotation.weather_description3 = fangliao3.descrip_tion;
                annotation.wind_dir3 = fangliao3.direc_tion;
                annotation.wind_speed3 = fangliao3.spe_ed;
                
                break;
            case 10:
                annotation.area = gooseNose1.area_ForecastData;
                annotation.subtitleTime = [NSString stringWithFormat:@"%@~%@",gooseNose1.ti_me,gooseNose3.ti_me];
                
                annotation.time = gooseNose1.ti_me;
                annotation.wave_type = gooseNose1.ty_pe;
                annotation.wave_height = gooseNose1.hei_ght;
                annotation.weather_description = gooseNose1.descrip_tion;
                annotation.wind_dir = gooseNose1.direc_tion;
                annotation.wind_speed = gooseNose1.spe_ed;
                
                annotation.time2 = gooseNose2.ti_me;
                annotation.wave_type2 = gooseNose2.ty_pe;
                annotation.wave_height2 = gooseNose2.hei_ght;
                annotation.weather_description2 = gooseNose2.descrip_tion;
                annotation.wind_dir2 = gooseNose2.direc_tion;
                annotation.wind_speed2 = gooseNose2.spe_ed;
                
                annotation.time3 = gooseNose3.ti_me;
                annotation.wave_type3 = gooseNose3.ty_pe;
                annotation.wave_height3 = gooseNose3.hei_ght;
                annotation.weather_description3 = gooseNose3.descrip_tion;
                annotation.wind_dir3 = gooseNose3.direc_tion;
                annotation.wind_speed3 = gooseNose3.spe_ed;
                
                break;
            case 11:
                annotation.area = success1.area_ForecastData;
                annotation.subtitleTime = [NSString stringWithFormat:@"%@~%@",success1.ti_me,success3.ti_me];
                
                annotation.time = success1.ti_me;
                annotation.wave_type = success1.ty_pe;
                annotation.wave_height = success1.hei_ght;
                annotation.weather_description = success1.descrip_tion;
                annotation.wind_dir = success1.direc_tion;
                annotation.wind_speed = success1.spe_ed;
                
                annotation.time2 = success2.ti_me;
                annotation.wave_type2 = success2.ty_pe;
                annotation.wave_height2 = success2.hei_ght;
                annotation.weather_description2 = success2.descrip_tion;
                annotation.wind_dir2 = success2.direc_tion;
                annotation.wind_speed2 = success2.spe_ed;
                
                annotation.time3 = success3.ti_me;
                annotation.wave_type3 = success3.ty_pe;
                annotation.wave_height3 = success3.hei_ght;
                annotation.weather_description3 = success3.descrip_tion;
                annotation.wind_dir3 = success3.direc_tion;
                annotation.wind_speed3 = success3.spe_ed;
                
                break;
            case 12:
                annotation.area = taitung1.area_ForecastData;
                annotation.subtitleTime = [NSString stringWithFormat:@"%@~%@",taitung1.ti_me,taitung3.ti_me];
                
                annotation.time = taitung1.ti_me;
                annotation.wave_type = taitung1.ty_pe;
                annotation.wave_height = taitung1.hei_ght;
                annotation.weather_description = taitung1.descrip_tion;
                annotation.wind_dir = taitung1.direc_tion;
                annotation.wind_speed = taitung1.spe_ed;
                
                annotation.time2 = taitung2.ti_me;
                annotation.wave_type2 = taitung2.ty_pe;
                annotation.wave_height2 = taitung2.hei_ght;
                annotation.weather_description2 = taitung2.descrip_tion;
                annotation.wind_dir2 = taitung2.direc_tion;
                annotation.wind_speed2 = taitung2.spe_ed;
                
                annotation.time3 = taitung3.ti_me;
                annotation.wave_type3 = taitung3.ty_pe;
                annotation.wave_height3 = taitung3.hei_ght;
                annotation.weather_description3 = taitung3.descrip_tion;
                annotation.wind_dir3 = taitung3.direc_tion;
                annotation.wind_speed3 = taitung3.spe_ed;
                break;
            case 13:
                annotation.area = greenIsland1.area_ForecastData;
                annotation.subtitleTime = [NSString stringWithFormat:@"%@~%@",greenIsland1.ti_me,greenIsland3.ti_me];
                
                annotation.time = greenIsland1.ti_me;
                annotation.wave_type = greenIsland1.ty_pe;
                annotation.wave_height = greenIsland1.hei_ght;
                annotation.weather_description = greenIsland1.descrip_tion;
                annotation.wind_dir = greenIsland1.direc_tion;
                annotation.wind_speed = greenIsland1.spe_ed;
                
                annotation.time2 = greenIsland2.ti_me;
                annotation.wave_type2 = greenIsland2.ty_pe;
                annotation.wave_height2 = greenIsland2.hei_ght;
                annotation.weather_description2 = greenIsland2.descrip_tion;
                annotation.wind_dir2 = greenIsland2.direc_tion;
                annotation.wind_speed2 = greenIsland2.spe_ed;
                
                annotation.time3 = greenIsland3.ti_me;
                annotation.wave_type3 = greenIsland3.ty_pe;
                annotation.wave_height3 = greenIsland3.hei_ght;
                annotation.weather_description3 = greenIsland3.descrip_tion;
                annotation.wind_dir3 = greenIsland3.direc_tion;
                annotation.wind_speed3 = greenIsland3.spe_ed;
                
                break;
            case 14:
                annotation.area = huallen1.area_ForecastData;
                annotation.subtitleTime = [NSString stringWithFormat:@"%@~%@",huallen1.ti_me,huallen3.ti_me];
                
                annotation.time = huallen1.ti_me;
                annotation.wave_type = huallen1.ty_pe;
                annotation.wave_height = huallen1.hei_ght;
                annotation.weather_description = huallen1.descrip_tion;
                annotation.wind_dir = huallen1.direc_tion;
                annotation.wind_speed = huallen1.spe_ed;
                
                annotation.time2 = huallen2.ti_me;
                annotation.wave_type2 = huallen2.ty_pe;
                annotation.wave_height2 = huallen2.hei_ght;
                annotation.weather_description2 = huallen2.descrip_tion;
                annotation.wind_dir2 = huallen2.direc_tion;
                annotation.wind_speed2 = huallen2.spe_ed;
                
                annotation.time3 = huallen3.ti_me;
                annotation.wave_type3 = huallen3.ty_pe;
                annotation.wave_height3 = huallen3.hei_ght;
                annotation.weather_description3 = huallen3.descrip_tion;
                annotation.wind_dir3 = huallen3.direc_tion;
                annotation.wind_speed3 = huallen3.spe_ed;
                break;
        
            default:
                break;
        }
        
        [map addAnnotation:annotation];
        [annotations addObject:annotation];
    }
    
    
    /*
    if ([records count] != 0) {
        NSArray *recordArr = [records copy];
        Record *rEcOrD = recordArr[0];
        annotation.area = rEcOrD.area_ForecastData;
        annotation.time = rEcOrD.ti_me;
    }
    */
    
    
    
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

-(void)dataSorting
{
    fishingPlatform1 = [records objectAtIndex:0];
    fishingPlatform2 = [records objectAtIndex:1];
    fishingPlatform3 = [records objectAtIndex:2];
    
    keelung1 = [records objectAtIndex:3];
    keelung2 = [records objectAtIndex:4];
    keelung3 = [records objectAtIndex:5];
    
    yilan1 = [records objectAtIndex:6];
    yilan2 = [records objectAtIndex:7];
    yilan3 = [records objectAtIndex:8];
    
    hsinchu1 = [records objectAtIndex:9];
    hsinchu2 = [records objectAtIndex:10];
    hsinchu3 = [records objectAtIndex:11];
    
    penhu1 = [records objectAtIndex:12];
    penhu2 = [records objectAtIndex:13];
    penhu3 = [records objectAtIndex:14];
    
    lukang1 = [records objectAtIndex:15];
    lukang2 = [records objectAtIndex:16];
    lukang3 = [records objectAtIndex:17];
    
    dongshih1 = [records objectAtIndex:18];
    dongshih2 = [records objectAtIndex:19];
    dongshih3 = [records objectAtIndex:20];
    
    anping1 = [records objectAtIndex:21];
    anping2 = [records objectAtIndex:22];
    anping3 = [records objectAtIndex:23];
    
    kaohsiung1 = [records objectAtIndex:24];
    kaohsiung2 = [records objectAtIndex:25];
    kaohsiung3 = [records objectAtIndex:26];
    
    fangliao1 = [records objectAtIndex:27];
    fangliao2 = [records objectAtIndex:28];
    fangliao3 = [records objectAtIndex:29];
    
    gooseNose1 = [records objectAtIndex:30];
    gooseNose2 = [records objectAtIndex:31];
    gooseNose3 = [records objectAtIndex:32];
    
    success1 = [records objectAtIndex:33];
    success2 = [records objectAtIndex:34];
    success3 = [records objectAtIndex:35];
    
    taitung1 = [records objectAtIndex:36];
    taitung2 = [records objectAtIndex:37];
    taitung3 = [records objectAtIndex:38];
    
    greenIsland1 = [records objectAtIndex:39];
    greenIsland2 = [records objectAtIndex:40];
    greenIsland3 = [records objectAtIndex:41];
    
    huallen1 = [records objectAtIndex:42];
    huallen2 = [records objectAtIndex:43];
    huallen3 = [records objectAtIndex:44];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
annotations = nil;annotation = nil;record = nil;records = nil;latitude = nil;lontitude = nil;
fishingPlatform1 = nil;fishingPlatform2 = nil;fishingPlatform3 = nil;keelung1 = nil;keelung2 = nil;
    keelung3 = nil;yilan1 = nil;yilan2 = nil;yilan3 = nil;hsinchu1 = nil;hsinchu2 = nil;hsinchu3 = nil;penhu1 = nil;penhu2 = nil;penhu3 = nil;lukang1 = nil;lukang2 = nil;lukang3=nil;dongshih1=nil;dongshih2=nil;dongshih3=nil;anping1=nil;anping2=nil;anping3=nil;kaohsiung1=nil;kaohsiung2=nil;kaohsiung3=nil;fangliao1 = nil;fangliao2=nil;fangliao3=nil;gooseNose1=nil;gooseNose2=nil;gooseNose3=nil;success1=nil;success2=nil;success3=nil;greenIsland1=nil;greenIsland2=nil;greenIsland3=nil;huallen1=nil;huallen2=nil;huallen3=nil;tagNames=nil;

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
