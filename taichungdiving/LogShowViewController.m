//
//  LogShowViewController.m
//  taichungdiving
//
//  Created by Samuel Teng on 2014/9/19.
//  Copyright (c) 2014年 SamuelTeng. All rights reserved.
//

#import "LogShowViewController.h"
#import "AppDelegate.h"
#import "LogBookTableViewController.h"
#import "LogDatabase.h"

@interface LogShowViewController (){
    
    AppDelegate *delegate;
    LogBookTableViewController *logTableview;
    LogDatabase *logDatabase;
}
@property (nonatomic,strong) UITextView *log;
@end

@implementation LogShowViewController
@synthesize  date,site,time,airType,preSta,preEnd,maxDep,temp,visib,logShowView,waves,current;
@synthesize contenPath,log;

-(void)toLogRecord:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}

-(void)lodeLog
{
    date = [logDatabase date:contenPath];
    
    site = [logDatabase site:contenPath];
    
    time = [logDatabase time:contenPath];
    
    airType = [logDatabase gas:contenPath];
    
    preSta = [logDatabase startPressure:contenPath];
    
    preEnd = [logDatabase endPressure:contenPath];
    
    maxDep = [logDatabase depth:contenPath];
    
    temp = [logDatabase temprature:contenPath];
    
    visib = [logDatabase visibility:contenPath];
    
    
    waves = [logDatabase waves:contenPath];
    
    current = [logDatabase current:contenPath];
    
    
        NSString *_log = [NSString stringWithFormat:@" 日期: %@ \n\n 潛點: %@ \n\n 潛水時間: %@ minutes \n\n 氣源: %@ \n\n Start pressure: %@ bar\n\n End pressure: %@ bar\n\n 最大深度: %@ \n\n 水溫: %@ \n\n 能見度: %@", date,site,time,airType,preSta,preEnd,maxDep,temp,visib];
        
        log = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 1100)];
        [log setText:_log];
        log.textColor = [UIColor blackColor];
        [log setFont:[UIFont systemFontOfSize:20.0]];
        log.editable = NO;
        [logShowView addSubview:log];
        
    
        self.view.backgroundColor = [UIColor grayColor];
        
        
}

-(void)loadView
{
    [super loadView];
    delegate = [[UIApplication sharedApplication] delegate];
    //logRecordViewController = [[LogRecordViewController alloc] init];
    logTableview = [[LogBookTableViewController alloc] init];
    
    logDatabase = [LogDatabase new];
    
    self.view.backgroundColor = [UIColor clearColor];
    

    logShowView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    logShowView.contentSize = CGSizeMake(self.view.bounds.size.width,
                                         1100//self.view.bounds.size.height+10
                                         );
    [self.view addSubview:logShowView];
    
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self lodeLog];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    date = nil;
    site = nil;
    time = nil;
    airType = nil;
    preSta = nil;
    preEnd = nil;
    maxDep = nil;
    temp = nil;
    visib = nil;

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    logDatabase = nil;
    date = nil;
    site = nil;
    time = nil;
    airType = nil;
    preSta = nil;
    preEnd = nil;
    maxDep = nil;
    temp = nil;
    visib = nil;
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