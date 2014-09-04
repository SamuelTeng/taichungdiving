//
//  ForecastAnnotation.h
//  taichungdiving
//
//  Created by Samuel Teng on 2014/8/28.
//  Copyright (c) 2014年 SamuelTeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface ForecastAnnotation : NSObject<MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D _coordinate;
@property (nonatomic, retain) NSString * subtitleTime;
@property (nonatomic, retain) NSString * area;
@property (nonatomic, retain) NSString * time;
@property (nonatomic, retain) NSString * time2;
@property (nonatomic, retain) NSString * time3;
@property (nonatomic, retain) NSString * weather_description;
@property (nonatomic, retain) NSString * weather_description2;
@property (nonatomic, retain) NSString * weather_description3;
@property (nonatomic, retain) NSString * wind_dir;
@property (nonatomic, retain) NSString * wind_dir2;
@property (nonatomic, retain) NSString * wind_dir3;
@property (nonatomic, retain) NSString * wind_speed;
@property (nonatomic, retain) NSString * wind_speed2;
@property (nonatomic, retain) NSString * wind_speed3;
@property (nonatomic, retain) NSString * wave_height;
@property (nonatomic, retain) NSString * wave_height2;
@property (nonatomic, retain) NSString * wave_height3;
@property (nonatomic, retain) NSString * wave_type;
@property (nonatomic, retain) NSString * wave_type2;
@property (nonatomic, retain) NSString * wave_type3;

@end
