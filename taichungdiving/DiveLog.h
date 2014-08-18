//
//  DiveLog.h
//  taichungdiving
//
//  Created by Samuel Teng on 2014/8/18.
//  Copyright (c) 2014年 SamuelTeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DiveLog : NSManagedObject

@property (nonatomic, retain) NSString * current;
@property (nonatomic, retain) NSString * date;
@property (nonatomic, retain) NSNumber * dive_time;
@property (nonatomic, retain) NSString * end_pressure;
@property (nonatomic, retain) NSString * gas_type;
@property (nonatomic, retain) NSString * max_depth;
@property (nonatomic, retain) NSString * site;
@property (nonatomic, retain) NSString * start_pressure;
@property (nonatomic, retain) NSString * temperture;
@property (nonatomic, retain) NSString * visibility;
@property (nonatomic, retain) NSString * waves;

@end
