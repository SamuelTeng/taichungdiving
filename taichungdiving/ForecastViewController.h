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
#import "Record.h"





@interface ForecastViewController : UIViewController<NSXMLParserDelegate,NSURLConnectionDataDelegate,MKMapViewDelegate,UIAlertViewDelegate>

@property (nonatomic,strong)MKMapView *map;
@property (nonatomic,strong)ForecastAnnotation *annotation;
@property (nonatomic,strong)NSMutableArray *annotations;

@property (nonatomic,strong) NSArray *latitude;
@property (nonatomic,strong) NSArray *lontitude;

@property (nonatomic,strong) Record *fishingPlatform1;
@property (nonatomic,strong) Record *fishingPlatform2;
@property (nonatomic,strong) Record *fishingPlatform3;

@property (nonatomic,strong) Record *keelung1;
@property (nonatomic,strong) Record *keelung2;
@property (nonatomic,strong) Record *keelung3;

@property (nonatomic,strong) Record *yilan1;
@property (nonatomic,strong) Record *yilan2;
@property (nonatomic,strong) Record *yilan3;

@property (nonatomic,strong) Record *hsinchu1;
@property (nonatomic,strong) Record *hsinchu2;
@property (nonatomic,strong) Record *hsinchu3;

@property (nonatomic,strong) Record *penhu1;
@property (nonatomic,strong) Record *penhu2;
@property (nonatomic,strong) Record *penhu3;

@property (nonatomic,strong) Record *lukang1;
@property (nonatomic,strong) Record *lukang2;
@property (nonatomic,strong) Record *lukang3;

@property (nonatomic,strong) Record *dongshih1;
@property (nonatomic,strong) Record *dongshih2;
@property (nonatomic,strong) Record *dongshih3;

@property (nonatomic,strong) Record *anping1;
@property (nonatomic,strong) Record *anping2;
@property (nonatomic,strong) Record *anping3;

@property (nonatomic,strong) Record *kaohsiung1;
@property (nonatomic,strong) Record *kaohsiung2;
@property (nonatomic,strong) Record *kaohsiung3;

@property (nonatomic,strong) Record *fangliao1;
@property (nonatomic,strong) Record *fangliao2;
@property (nonatomic,strong) Record *fangliao3;

@property (nonatomic,strong) Record *gooseNose1;
@property (nonatomic,strong) Record *gooseNose2;
@property (nonatomic,strong) Record *gooseNose3;

@property (nonatomic,strong) Record *success1;
@property (nonatomic,strong) Record *success2;
@property (nonatomic,strong) Record *success3;

@property (nonatomic,strong) Record *taitung1;
@property (nonatomic,strong) Record *taitung2;
@property (nonatomic,strong) Record *taitung3;

@property (nonatomic,strong) Record *greenIsland1;
@property (nonatomic,strong) Record *greenIsland2;
@property (nonatomic,strong) Record *greenIsland3;

@property (nonatomic,strong) Record *huallen1;
@property (nonatomic,strong) Record *huallen2;
@property (nonatomic,strong) Record *huallen3;

//@property (nonatomic,strong) Forecast *forecast;

//@property (readonly , strong ,nonatomic) NSManagedObjectContext *managedObjectContext;


@end
