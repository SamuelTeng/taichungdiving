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
    //self.dataSource = modelController;
    
    logDatabase = [LogDatabase new];
    
    //self.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, 1100);
    //[self.view setFrame:CGRectMake(0, 0, self.view.bounds.size.width, 1100)];
    logShowViewController = [[LogShowViewController alloc] init];
    
    logShowViewController.contenPath = [NSIndexPath indexPathForRow:self.startPage inSection:self._section];
    
    
    /*set "animated" to "NO" to prevent "UIWindow" issue from happening*/
    [self setViewControllers:[NSArray arrayWithObjects:logShowViewController, nil] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    NSLog(@"%@",NSStringFromCGRect(self.view.frame));
    
}
/*
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    logShowViewController = [[LogShowViewController alloc] init];
    
    logShowViewController.contenPath = [NSIndexPath indexPathForRow:self.startPage inSection:self._section];
    
    

    
    set "animated" to "NO" to prevent "UIWindow" issue from happening

    [self setViewControllers:[NSArray arrayWithObjects:logShowViewController, nil] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];

}
*/
- (void)pageViewController:(UIPageViewController *)bPageViewController
willTransitionToViewControllers:(NSArray *)pendingViewControllers
{
    NSLog(@"during the transition frame:%@",NSStringFromCGRect(bPageViewController.view.frame));
    //[self.view setFrame:CGRectMake(10, 10, self.view.bounds.size.width, 1100)];
}

- (void)pageViewController:(UIPageViewController *)aPageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray *)previousViewControllers
       transitionCompleted:(BOOL)completed
{
    if (finished) {
        //aPageViewController.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, 1100);
        NSLog(@"finish animation");
        if (completed) {
            NSLog(@"%@",NSStringFromCGRect(aPageViewController.view.frame));
            //aPageViewController.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, 1100);
        }
    }
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
