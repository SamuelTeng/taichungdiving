//
//  SitePick.h
//  taichungdiving
//
//  Created by Samuel Teng on 2014/10/8.
//  Copyright (c) 2014年 SamuelTeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "LogViewController.h"

@interface SitePick : NSObject<CLLocationManagerDelegate,UIAlertViewDelegate>

@property (nonatomic,strong) CLLocationManager *locationManager;

@property (nonatomic,strong) CLCircularRegion *redWoods;

@property (nonatomic,strong) LogViewController *logViewController;

-(id)init;
-(void)monitorRegions;
-(void)ceaseMonitorRegions;
//@property (nonatomic,strong) CLLocation *siteLocation;

@end
