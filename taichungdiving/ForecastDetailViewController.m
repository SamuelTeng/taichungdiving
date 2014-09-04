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
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x-80, self.view.center.y, 140, 100)];
    timeLabel.text = annotation.time;
    [self.view addSubview:timeLabel];
    
    waveTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x-80, self.view.center.y+80, 100, 100)];
    waveTypeLabel.text = annotation.wave_type;
    [self.view addSubview:waveTypeLabel];
    // Do any additional setup after loading the view.
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
