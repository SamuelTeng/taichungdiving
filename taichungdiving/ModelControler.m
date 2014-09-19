//
//  ModelControler.m
//  taichungdiving
//
//  Created by Samuel Teng on 2014/9/19.
//  Copyright (c) 2014年 SamuelTeng. All rights reserved.
//

#import "ModelControler.h"
#import "LogShowViewController.h"
#import "PageViewController.h"
#import "LogDatabase.h"
#import "AppDelegate.h"

@interface ModelControler (){
    
    AppDelegate *delegate;
    LogShowViewController *contentPage;
    
}

@end

@implementation ModelControler

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    contentPage = (LogShowViewController *)viewController;
    int currentPage = contentPage.contenPath.row;
    int currentSection = contentPage.contenPath.section;
    
    
    /*the section from tableview start with 0*/
    if (currentSection <1) {
        return nil;
    }else{
        
        int page = currentPage;
        int pageSection = contentPage.contenPath.section-1;
        
        contentPage = [[LogShowViewController alloc] init];
        contentPage.contenPath = [NSIndexPath indexPathForRow:page inSection:pageSection];
        
        return contentPage;
        
    }
    
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    contentPage = (LogShowViewController *)viewController;
    int currentPage = contentPage.contenPath.row;
    int currentSection = contentPage.contenPath.section;
    
    LogDatabase *logDatabase = [LogDatabase new];
    int total = [logDatabase numberOfPages];
    
   
    
    if (currentSection >= total-1) {
        return nil;
    }else{
        
        int page = currentPage;
        int pageSection = contentPage.contenPath.section+1;
        contentPage = [[LogShowViewController alloc] init];
        contentPage.contenPath = [NSIndexPath indexPathForRow:page inSection:pageSection];
        return contentPage;
        
    }
    
}



@end
