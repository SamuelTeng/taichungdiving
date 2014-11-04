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
#import "TourTableViewController.h"



@interface MainViewController (){
    
    AppDelegate *delegate;
    LogBookTableViewController *logBook;
    ForecastViewController *forecastView;
    TourTableViewController *tourTableView;
}

@end

@implementation MainViewController

//@synthesize pick;

-(void)loadView
{
    [super loadView];
    
    delegate = [[UIApplication sharedApplication] delegate];
    logBook = [[LogBookTableViewController alloc] init];
    forecastView = [[ForecastViewController alloc] init];
    tourTableView = [[TourTableViewController alloc] init];
    
    UIButton *logBookButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [logBookButton setBackgroundImage:[UIImage imageNamed:@"ic_class_black_48dp.png"] forState:UIControlStateNormal];
    [logBookButton setTitle:@"潛水日誌" forState:UIControlStateNormal];
    [logBookButton setFrame:CGRectMake(self.view.center.x-20, self.view.center.y-150,48, 48)];
    [logBookButton addTarget:self action:@selector(fowardToLogBook:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logBookButton];
    
    UIButton *weatherButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [weatherButton setTitle:@"海面天氣" forState:UIControlStateNormal];
    [weatherButton setFrame:CGRectMake(self.view.center.x-84, self.view.center.y-90, 180, 60)];
    [weatherButton addTarget:self action:@selector(fowardToForecast:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:weatherButton];
    
    UIButton *tourButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [tourButton setTitle:@"旅遊行程" forState:UIControlStateNormal];
    [tourButton setFrame:CGRectMake(self.view.center.x-84, self.view.center.y-40, 180, 60)];
    [tourButton addTarget:self action:@selector(fowardToTourTable:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tourButton];
    
    self.navigationItem.hidesBackButton = YES;
    
    self.navigationItem.title = @"台中潛水";
  
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *backToHome = [[UIBarButtonItem alloc] init];
    backToHome.title = @"首頁";
    self.navigationItem.backBarButtonItem = backToHome;
    
    //pick = [SitePick new];
    
}

-(void)fowardToLogBook:(id)sender
{
    [delegate.navi pushViewController:logBook animated:NO];
    //[pick monitorRegions];

}

-(void)fowardToForecast:(id)sender
{
    [delegate.navi pushViewController:forecastView animated:NO];
}

-(void)fowardToTourTable:(id)sender
{
    [delegate.navi pushViewController:tourTableView animated:NO];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    //[pick ceaseMonitorRegions];
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
