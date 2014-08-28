//
//  ForecastAnnotation.m
//  taichungdiving
//
//  Created by Samuel Teng on 2014/8/28.
//  Copyright (c) 2014年 SamuelTeng. All rights reserved.
//

#import "ForecastAnnotation.h"

@implementation ForecastAnnotation

@synthesize area,time,weather_description,wave_height,wave_type,wind_dir,wind_speed,_coordinate;

-(CLLocationCoordinate2D)coordinate
{
    return _coordinate;
}

-(NSString *)title
{
    return area;
}

-(NSString *)subtitle
{
    return time;
}

@end
