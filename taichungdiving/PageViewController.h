//
//  PageViewController.h
//  taichungdiving
//
//  Created by Samuel Teng on 2014/9/19.
//  Copyright (c) 2014年 SamuelTeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageViewController : UIPageViewController<UIPageViewControllerDelegate>

@property (nonatomic) int startPage;
@property (nonatomic) int _section;


@end
