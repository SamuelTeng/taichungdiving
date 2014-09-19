//
//  LogDatabase.h
//  taichungdiving
//
//  Created by Samuel Teng on 2014/9/19.
//  Copyright (c) 2014年 SamuelTeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface LogDatabase : NSObject<NSFetchedResultsControllerDelegate>

@property (nonatomic,strong) NSFetchedResultsController *resultController;
@property (nonatomic,strong) NSManagedObject *_managedObject;

@property(nonatomic,strong) NSString *logDate;
@property(nonatomic,strong) NSString *logSite;
@property(nonatomic,strong) NSString *logTime;
@property(nonatomic,strong) NSString *logDepth;
@property(nonatomic,strong) NSString *logGas;
@property(nonatomic,strong) NSString *logVisibility;
@property(nonatomic,strong) NSString *logTemperature;
@property(nonatomic,strong) NSString *logStartPressure;
@property(nonatomic,strong) NSString *logEndPressure;
@property(nonatomic,strong) NSString *logWaves;
@property(nonatomic,strong) NSString *logCurrent;


@property (nonatomic)int pages;

-(void)fetchData;
-(int)numberOfPages;

-(NSString *)date:(NSIndexPath *)indexpath;
-(NSString *)site:(NSIndexPath *)indexpath;
-(NSString *)time:(NSIndexPath *)indexpath;
-(NSString *)depth:(NSIndexPath *)indexpath;
-(NSString *)gas:(NSIndexPath *)indexpath;
-(NSString *)visibility:(NSIndexPath *)indexpath;
-(NSString *)temprature:(NSIndexPath *)indexpath;
-(NSString *)startPressure:(NSIndexPath *)indexpath;
-(NSString *)endPressure:(NSIndexPath *)indexpath;
-(NSString *)waves:(NSIndexPath *)indexpath;
-(NSString *)current:(NSIndexPath *)indexpath;


@end
