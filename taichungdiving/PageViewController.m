//
//  PageViewController.m
//  taichungdiving
//
//  Created by Samuel Teng on 2014/9/19.
//  Copyright (c) 2014年 SamuelTeng. All rights reserved.
//

#import "PageViewController.h"
#import "ModelControler.h"
#import "LogShowViewController.h"
#import "LogDatabase.h"

@interface PageViewController (){
    
    ModelControler *modelController;
    LogDatabase *logDatabase;
    LogShowViewController *logShowViewController;

}

@end

@implementation PageViewController
@synthesize startPage,_section;



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    
    modelController = [[ModelControler alloc] init];
    self.dataSource = modelController;
    
    logDatabase = [LogDatabase new];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    logShowViewController = [[LogShowViewController alloc] init];
    
    logShowViewController.contenPath = [NSIndexPath indexPathForRow:self.startPage inSection:self._section];
    
    

    
    /*set "animated" to "NO" to prevent "UIWindow" issue from happening*/
    [self setViewControllers:[NSArray arrayWithObjects:logShowViewController, nil] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    logDatabase = nil;
    logShowViewController = nil;
    modelController = nil;

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
