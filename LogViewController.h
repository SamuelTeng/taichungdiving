//
//  LogViewController.h
//  taichungdiving
//
//  Created by Samuel Teng on 2014/9/19.
//  Copyright (c) 2014年 SamuelTeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogViewController : UIViewController<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@property (readonly , strong ,nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UILabel *dateLabel;
@property (nonatomic,strong) UILabel *siteLabel;
@property (nonatomic,strong) UILabel *wavesLabel;
@property (nonatomic,strong) UILabel *currentLabel;
@property (nonatomic,strong) UILabel *maxDepLabel;
@property (nonatomic,strong) UILabel *gasLabel;
@property (nonatomic,strong) UILabel *divetimeLabel;
@property (nonatomic,strong) UILabel *visiLabel;
@property (nonatomic,strong) UILabel *temperLabel;
@property (nonatomic,strong) UILabel *staPrelabel;
@property (nonatomic,strong) UILabel *endPreLabel;
@property (nonatomic,strong) UILabel *otherLabel;
@property (nonatomic,strong) UITextField *dateField;
@property (nonatomic,strong) UITextField *siteField;
@property (nonatomic,strong) UITextField *wavesField;
@property (nonatomic,strong) UITextField *currentField;
@property (nonatomic,strong) UITextField *maxDepField;
@property (nonatomic,strong) UITextField *gasField;
@property (nonatomic,strong) UITextField *divetimeField;
@property (nonatomic,strong) UITextField *visiField;
@property (nonatomic,strong) UITextField *temperField;
@property (nonatomic,strong) UITextField *staPreField;
@property (nonatomic,strong) UITextField *endPreField;
@property (nonatomic,strong) UITextField *otherField;

@property (nonatomic,strong) NSString *selectedRow;
@property (nonatomic,strong) NSArray *gasArr;
@property (nonatomic,strong) NSArray *firstRow;
@property (nonatomic,strong) NSArray *secondRow;
@property (nonatomic,strong) NSArray *thirdRow;
@property (nonatomic,strong) NSArray *forthRow;
@property (nonatomic,strong) NSArray *mAndf;
@property (nonatomic,strong) NSArray *cAndf;
@property (nonatomic,strong) NSArray *wavesArr;
@property (nonatomic,strong) NSArray *currentArr;


@property (nonatomic,strong) NSString *dateFromData;
@property (nonatomic,strong) NSString *wavesFromData;
@property (nonatomic,strong) NSString *currentFromData;
@property (nonatomic,strong) NSString *timeFromData;

@property(nonatomic,strong) UIButton *siteButton;


@end
