//
//  MianViewController.m
//  taichungdiving
//
//  Created by Samuel Teng on 2014/8/18.
//  Copyright (c) 2014年 SamuelTeng. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"
#import "LogBookTableViewController.h"
#import "ForecastViewController.h"

@interface MainViewController (){
    
    AppDelegate *delegate;
    LogBookTableViewController *logBook;
    ForecastViewController *forecastView;
}

@end

@implementation MainViewController

-(void)loadView
{
    [super loadView];
    
    delegate = [[UIApplication sharedApplication] delegate];
    logBook = [[LogBookTableViewController alloc] init];
    forecastView = [[ForecastViewController alloc] init];
    
    UIButton *logBookButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [logBookButton setTitle:@"潛水日誌" forState:UIControlStateNormal];
    [logBookButton setFrame:CGRectMake(self.view.center.x-84, self.view.center.y-200,180, 60)];
    [logBookButton addTarget:self action:@selector(fowardToLogBook:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logBookButton];
    
    UIButton *weatherButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [weatherButton setTitle:@"海面天氣" forState:UIControlStateNormal];
    [weatherButton setFrame:CGRectMake(self.view.center.x-84, self.view.center.y-120, 180, 60)];
    [weatherButton addTarget:self action:@selector(fowardToForecast:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:weatherButton];
    
    UIButton *announcementButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [announcementButton setTitle:@"公告" forState:UIControlStateNormal];
    [announcementButton setFrame:CGRectMake(self.view.center.x-84, self.view.center.y-40, 180, 60)];
    [self.view addSubview:announcementButton];
    
    self.navigationItem.hidesBackButton = YES;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *backToHome = [[UIBarButtonItem alloc] init];
    backToHome.title = @"首頁";
    self.navigationItem.backBarButtonItem = backToHome;
}

-(void)fowardToLogBook:(id)sender
{
    [delegate.navi pushViewController:logBook animated:NO];
}

-(void)fowardToForecast:(id)sender
{
    [delegate.navi pushViewController:forecastView animated:NO];
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
