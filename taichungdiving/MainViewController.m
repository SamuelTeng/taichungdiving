//
//  MianViewController.m
//  taichungdiving
//
//  Created by Samuel Teng on 2014/8/18.
//  Copyright (c) 2014年 SamuelTeng. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"

@interface MainViewController ()

@end

@implementation MainViewController

-(void)loadView
{
    [super loadView];
    
    
    UIButton *logBookButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [logBookButton setTitle:@"潛水日誌" forState:UIControlStateNormal];
    [logBookButton setFrame:CGRectMake(self.view.center.x-84, self.view.center.y-200,180, 60)];
    [self.view addSubview:logBookButton];
    
    UIButton *weatherButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [weatherButton setTitle:@"海面天氣" forState:UIControlStateNormal];
    [weatherButton setFrame:CGRectMake(self.view.center.x-84, self.view.center.y-120, 180, 60)];
    [self.view addSubview:weatherButton];
    
    UIButton *announcementButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [announcementButton setTitle:@"公告" forState:UIControlStateNormal];
    [announcementButton setFrame:CGRectMake(self.view.center.x-84, self.view.center.y-40, 180, 60)];
    [self.view addSubview:announcementButton];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
