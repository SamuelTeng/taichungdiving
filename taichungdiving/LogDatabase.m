//
//  LogDatabase.m
//  taichungdiving
//
//  Created by Samuel Teng on 2014/9/19.
//  Copyright (c) 2014年 SamuelTeng. All rights reserved.
//

#import "LogDatabase.h"
#import "LogBookTableViewController.h"
#import "AppDelegate.h"
#import "DiveLog.h"

@interface LogDatabase() {
    
    AppDelegate *delegate;
    DiveLog *divelog;
    LogBookTableViewController *logBookTableView;
}

@end

@implementation LogDatabase

@synthesize resultController,_managedObject;
@synthesize logDate,logEndPressure,logStartPressure,logTemperature,logVisibility,logGas,logDepth,logTime,logSite,logCurrent,logWaves;
@synthesize pages;

-(void)fetchData
{
    delegate = [[UIApplication sharedApplication] delegate];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"DiveLog" inManagedObjectContext:delegate.managedObjectContext]];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObject:sortDescriptor];
    [request setSortDescriptors:descriptors];
    
    NSError *error;
    resultController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:delegate.managedObjectContext sectionNameKeyPath:@"date" cacheName:nil];
    resultController.delegate = self;
    if (![resultController performFetch:&error]) {
        NSLog(@"error : %@", [error localizedFailureReason]);
    }
    
}


-(int)numberOfPages
{
    [self fetchData];
    pages = resultController.fetchedObjects.count;
    return pages;
}


-(NSString *)date:(NSIndexPath *)indexpath
{
    [self fetchData];
    NSManagedObject *managedObject = [resultController objectAtIndexPath:indexpath];
    logDate = [managedObject valueForKey:@"date"];
    return logDate;
}

-(NSString *)site:(NSIndexPath *)indexpath
{
    [self fetchData];
    NSManagedObject *managedObject = [resultController objectAtIndexPath:indexpath];
    logSite = [managedObject valueForKey:@"site"];
    return logSite;
}

-(NSString *)time:(NSIndexPath *)indexpath
{
    [self fetchData];
    NSManagedObject *managedObject = [resultController objectAtIndexPath:indexpath];
    logTime = [managedObject valueForKey:@"dive_time"];
    return logTime;
}

-(NSString *)depth:(NSIndexPath *)indexpath
{
    [self fetchData];
    NSManagedObject *managedObject = [resultController objectAtIndexPath:indexpath];
    logDepth = [managedObject valueForKey:@"max_depth"];
    return logDepth;
}

-(NSString *)gas:(NSIndexPath *)indexpath
{
    [self fetchData];
    NSManagedObject *managedObject = [resultController objectAtIndexPath:indexpath];
    logGas = [managedObject valueForKey:@"gas_type"];
    return logGas;
}

-(NSString *)visibility:(NSIndexPath *)indexpath
{
    [self fetchData];
    NSManagedObject *managedObject = [resultController objectAtIndexPath:indexpath];
    logVisibility = [managedObject valueForKey:@"visibility"];
    return logVisibility;
}

-(NSString *)temprature:(NSIndexPath *)indexpath
{
    [self fetchData];
    NSManagedObject *managedObject = [resultController objectAtIndexPath:indexpath];
    logTemperature = [managedObject valueForKey:@"temperture"];
    return logTemperature;
}

-(NSString *)startPressure:(NSIndexPath *)indexpath
{
    [self fetchData];
    NSManagedObject *managedObject = [resultController objectAtIndexPath:indexpath];
    logStartPressure = [managedObject valueForKey:@"start_pressure"];
    return logStartPressure;
}

-(NSString *)endPressure:(NSIndexPath *)indexpath
{
    [self fetchData];
    NSManagedObject *managedObject = [resultController objectAtIndexPath:indexpath];
    logEndPressure = [managedObject valueForKey:@"end_pressure"];
    return logEndPressure;
}



-(NSString *)waves:(NSIndexPath *)indexpath
{
    [self fetchData];
    NSManagedObject *managedObject = [resultController objectAtIndexPath:indexpath];
    logWaves = [managedObject valueForKey:@"waves"];
    return logWaves;
}

-(NSString *)current:(NSIndexPath *)indexpath
{
    NSManagedObject *managedObject = [resultController objectAtIndexPath:indexpath];
    logCurrent = [managedObject valueForKey:@"current"];
    return logCurrent;
}


@end
