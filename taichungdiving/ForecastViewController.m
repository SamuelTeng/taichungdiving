//
//  ForecastViewController.m
//  taichungdiving
//
//  Created by Samuel Teng on 2014/8/20.
//  Copyright (c) 2014年 SamuelTeng. All rights reserved.
//

#import "ForecastViewController.h"
#import "Record.h"

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
}

@synthesize forecast;
@synthesize managedObjectContext;


-(void)loadView
{
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"更新" style:UIBarButtonItemStyleBordered target:self action:@selector(reload_data)];
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
         
         NSLog(@"地點：%@",theRecord.area_ForecastData);
         NSLog(@"時間：%@", theRecord.ti_me);
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
