//
//  LogShowViewController.h
//  taichungdiving
//
//  Created by Samuel Teng on 2014/9/19.
//  Copyright (c) 2014年 SamuelTeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogShowViewController : UIViewController

@property (nonatomic,strong) NSString *date;
@property (nonatomic,strong) NSString *site;
@property (nonatomic,strong) NSString *time;
@property (nonatomic,strong) NSString *airType;
@property (nonatomic,strong) NSString *preSta;
@property (nonatomic,strong) NSString *preEnd;
@property (nonatomic,strong) NSString *maxDep;
@property (nonatomic,strong) NSString *temp;
@property (nonatomic,strong) NSString *visib;
@property (nonatomic,strong) NSString *waves;
@property (nonatomic,strong) NSString *current;
@property (nonatomic,strong) UIScrollView *logShowView;

@property (nonatomic,strong) NSIndexPath *contenPath;


@end
