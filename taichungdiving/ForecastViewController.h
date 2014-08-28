//
//  ForecastViewController.h
//  taichungdiving
//
//  Created by Samuel Teng on 2014/8/20.
//  Copyright (c) 2014年 SamuelTeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
//#import "Forecast.h"
#import "MainViewController.h"
#import "AppDelegate.h"
#import "ForecastAnnotation.h"





@interface ForecastViewController : UIViewController<NSXMLParserDelegate,NSURLConnectionDataDelegate,MKMapViewDelegate>

@property (nonatomic,strong)MKMapView *map;
@property (nonatomic,strong)ForecastAnnotation *annotation;
@property (nonatomic,strong)NSMutableArray *annotations;

@property (nonatomic,strong) NSArray *latitude;
@property (nonatomic,strong) NSArray *lontitude;
//@property (nonatomic,strong) Forecast *forecast;

//@property (readonly , strong ,nonatomic) NSManagedObjectContext *managedObjectContext;


@end
