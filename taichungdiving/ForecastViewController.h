//
//  ForecastViewController.h
//  taichungdiving
//
//  Created by Samuel Teng on 2014/8/20.
//  Copyright (c) 2014年 SamuelTeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Forecast.h"
#import "MainViewController.h"
#import "AppDelegate.h"




@interface ForecastViewController : UIViewController<NSXMLParserDelegate,NSURLConnectionDataDelegate>

@property (nonatomic,strong) Forecast *forecast;

@property (readonly , strong ,nonatomic) NSManagedObjectContext *managedObjectContext;


@end
