//
//  SitePick.h
//  taichungdiving
//
//  Created by Samuel Teng on 2014/10/8.
//  Copyright (c) 2014年 SamuelTeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface SitePick : NSObject<CLLocationManagerDelegate,UIAlertViewDelegate>

@property (nonatomic,strong) CLLocationManager *locationManager;

@property (nonatomic,strong) CLCircularRegion *redWoods;


-(void)monitorRegions;

//@property (nonatomic,strong) CLLocation *siteLocation;

@end
