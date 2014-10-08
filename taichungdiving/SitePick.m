//
//  SitePick.m
//  taichungdiving
//
//  Created by Samuel Teng on 2014/10/8.
//  Copyright (c) 2014年 SamuelTeng. All rights reserved.
//

#import "SitePick.h"

@implementation SitePick

@synthesize locationManager,siteLocation;

-(void)distanceBetweenLocations
{
    locationManager = [[CLLocationManager alloc] init];
    [locationManager setDelegate:self];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locationManager startUpdatingLocation];
    
    NSLog(@"現在位置:%@", [locationManager location]);
    
    CLLocation *redWoodsSouth = [[CLLocation alloc] initWithLatitude:21.9721199 longitude:120.712141];
    NSString *distance = [NSString stringWithFormat:@"距離紅柴坑:%0.2fkm",[[locationManager location]distanceFromLocation:redWoodsSouth]/1000];
    NSLog(@"%@",distance);
    
}


@end
