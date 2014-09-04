//
//  ForecastAnnotation.m
//  taichungdiving
//
//  Created by Samuel Teng on 2014/8/28.
//  Copyright (c) 2014年 SamuelTeng. All rights reserved.
//

#import "ForecastAnnotation.h"

@implementation ForecastAnnotation

@synthesize area,time,weather_description,wave_height,wave_type,wind_dir,wind_speed,_coordinate,time2,time3,weather_description2,weather_description3,wave_height2,wave_height3,wave_type2,wave_type3,wind_dir2,wind_dir3,wind_speed2,wind_speed3,subtitleTime;

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
    return subtitleTime;
}

@end
