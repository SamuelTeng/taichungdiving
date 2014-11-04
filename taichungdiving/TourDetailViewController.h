//
//  TourDetailViewController.h
//  taichungdiving
//
//  Created by Samuel Teng on 2014/11/4.
//  Copyright (c) 2014年 SamuelTeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TourDetailViewController : UIViewController<UIWebViewDelegate>

@property(nonatomic,strong)UIWebView *webView;
@property(nonatomic,strong)NSDictionary *pageData;



@end
