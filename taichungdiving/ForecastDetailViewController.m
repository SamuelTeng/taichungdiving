//
//  ForecastDetailViewController.m
//  taichungdiving
//
//  Created by Samuel Teng on 2014/9/3.
//  Copyright (c) 2014年 SamuelTeng. All rights reserved.
//

#import "ForecastDetailViewController.h"

@interface ForecastDetailViewController ()

@end

@implementation ForecastDetailViewController

@synthesize annotation,timeLabel,waveTypeLabel,timeLabel2,timeLabel3,waveHeight,waveHeight2,waveHeight3,waveTypeLabel2,waveTypeLabel3,weatherDescription,weatherDescription2,weatherDescription3,windDir,windDir2,windDir3,windSpeed,windSpeed2,windSpeed3;
@synthesize forecast,forecast2,forecast3;

-(id)initWithAnnoation:(ForecastAnnotation *)a_Annotation
{
    self = [super init];
    
    if (self) {
        self.annotation = a_Annotation;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x-80, self.view.center.y, 140, 100)];
    timeLabel.text = annotation.time;
    [self.view addSubview:timeLabel];
    
    waveTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x-80, self.view.center.y+80, 100, 100)];
    waveTypeLabel.text = annotation.wave_type;
    [self.view addSubview:waveTypeLabel];
     */
    // Do any additional setup after loading the view.
    UIBarButtonItem *backwardButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(backWard)];
    self.navigationItem.leftBarButtonItem = backwardButton;
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString *location = annotation.area;
    self.navigationItem.title =location;
    
    forecast = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    NSString *contentOfForecast = [NSString stringWithFormat:@" 日期:%@ \n 天氣概況:%@ \n 風速:%@ \n 風向:%@ \n 浪況:%@ \n 浪高:%@\n\n 日期:%@ \n 天氣概況:%@ \n 風速:%@ \n 風向:%@ \n 浪況:%@ \n 浪高:%@\n\n 日期:%@ \n 天氣概況:%@ \n 風速:%@ \n 風向:%@ \n 浪況:%@ \n 浪高:%@" , annotation.time,annotation.weather_description,annotation.wind_speed,annotation.wind_dir,annotation.wave_type,annotation.wave_height,annotation.time2,annotation.weather_description2,annotation.wind_speed2,annotation.wind_dir2,annotation.wave_type2,annotation.wave_height2,annotation.time3,annotation.weather_description3,annotation.wind_speed3,annotation.wind_dir3,annotation.wave_type3,annotation.wave_height3];
    forecast.text = contentOfForecast;
    forecast.editable = NO;
    [self.view addSubview:forecast];
}

-(void)backWard
{
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
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
