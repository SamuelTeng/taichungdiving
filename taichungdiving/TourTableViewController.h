//
//  TourTableViewController.h
//  taichungdiving
//
//  Created by Samuel Teng on 2014/11/4.
//  Copyright (c) 2014年 SamuelTeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TourTableViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) NSMutableArray * domesticTour;
@property(nonatomic,strong) NSMutableArray *foreignTour;

@end
