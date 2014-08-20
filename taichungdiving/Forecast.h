//
//  Forecast.h
//  taichungdiving
//
//  Created by Samuel Teng on 2014/8/20.
//  Copyright (c) 2014年 SamuelTeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Forecast : NSManagedObject

@property (nonatomic, retain) NSString * area;
@property (nonatomic, retain) NSString * time;
@property (nonatomic, retain) NSString * weather_description;
@property (nonatomic, retain) NSString * wind_dir;
@property (nonatomic, retain) NSString * wind_speed;
@property (nonatomic, retain) NSString * wave_height;
@property (nonatomic, retain) NSString * wave_type;

@end
