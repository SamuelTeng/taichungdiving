//
//  ForecastDetailViewController.h
//  taichungdiving
//
//  Created by Samuel Teng on 2014/9/3.
//  Copyright (c) 2014年 SamuelTeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ForecastAnnotation.h"

@interface ForecastDetailViewController : UIViewController

@property (nonatomic,strong) ForecastAnnotation *annotation;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *timeLabel2;
@property (nonatomic,strong) UILabel *timeLabel3;

@property (nonatomic,strong) UILabel *waveTypeLabel;
@property (nonatomic,strong) UILabel *waveTypeLabel2;
@property (nonatomic,strong) UILabel *waveTypeLabel3;

@property (nonatomic,strong) UILabel *weatherDescription;
@property (nonatomic,strong) UILabel *weatherDescription2;
@property (nonatomic,strong) UILabel *weatherDescription3;

@property (nonatomic,strong) UILabel *windDir;
@property (nonatomic,strong) UILabel *windDir2;
@property (nonatomic,strong) UILabel *windDir3;

@property (nonatomic,strong) UILabel *windSpeed;
@property (nonatomic,strong) UILabel *windSpeed2;
@property (nonatomic,strong) UILabel *windSpeed3;

@property (nonatomic,strong) UILabel *waveHeight;
@property (nonatomic,strong) UILabel *waveHeight2;
@property (nonatomic,strong) UILabel *waveHeight3;

-(id)initWithAnnoation:(ForecastAnnotation *)a_Annotation;

@end
