//
//  SitePick.m
//  taichungdiving
//
//  Created by Samuel Teng on 2014/10/8.
//  Copyright (c) 2014年 SamuelTeng. All rights reserved.
//

#import "SitePick.h"

@implementation SitePick

@synthesize locationManager,redWoods;

-(id)init
{
    if (self = [super init]) {
        locationManager = [[CLLocationManager alloc] init];
        [locationManager setDelegate:self];
        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [locationManager startMonitoringSignificantLocationChanges];
        [locationManager startUpdatingLocation];
    }
    
    return self;
}

-(void)monitorRegions
{
    locationManager = [[CLLocationManager alloc] init];
    [locationManager setDelegate:self];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locationManager startMonitoringSignificantLocationChanges];
    [locationManager startUpdatingLocation];
    
    CLLocationCoordinate2D redwoodCenter;
    redwoodCenter.latitude =25.066427;
    //21.9721199;
    redwoodCenter.longitude =121.633734;
    //120.712141;
    
    redWoods = [[CLCircularRegion alloc] initWithCenter:redwoodCenter radius:800 identifier:@"red_woods"];
    [locationManager startMonitoringForRegion:redWoods];
    
    
    
       NSLog(@"現在位置:%@", [locationManager location]);
    /*     CLLocation *redWoodsSouth = [[CLLocation alloc] initWithLatitude:21.9721199 longitude:120.712141];
    NSString *distance = [NSString stringWithFormat:@"距離紅柴坑:%0.2fkm",[[locationManager location]distanceFromLocation:redWoodsSouth]/1000];
    NSLog(@"%@",distance);
    */
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    [[[UIAlertView alloc] initWithTitle:@"Test" message:@"測試進入區域監測功能" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil]show];
    if ([region.identifier isEqualToString:@"red_woods"]) {
        //temperField.text = @"紅柴坑";
    }
    
}


- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    
    NSLog(@"不再區域內");
    
}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
{
    NSLog(@"Now monitoring : %@",region.identifier);
}


@end
