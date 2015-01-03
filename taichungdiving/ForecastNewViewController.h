//
//  ForecastNewViewController.h
//  taichungdiving
//
//  Created by Samuel Teng on 2015/1/3.
//  Copyright (c) 2015年 SamuelTeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForecastNewViewController : UIViewController<UIWebViewDelegate>

@property (nonatomic,strong)UIWebView *webView;

-(UIBarButtonItem*)refreshBarButton;
-(UIBarButtonItem *)stopBarButton;

@end
