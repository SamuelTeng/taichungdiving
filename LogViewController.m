//
//  LogViewController.m
//  taichungdiving
//
//  Created by Samuel Teng on 2014/9/19.
//  Copyright (c) 2014年 SamuelTeng. All rights reserved.
//

#import "LogViewController.h"
#import "DiveLog.h"
#import "AppDelegate.h"
#import "LogBookTableViewController.h"


@interface LogViewController (){
    
    AppDelegate *delegate;
    LogBookTableViewController *logBookTableView;

}

@end

@implementation LogViewController
@synthesize managedObjectContext,scrollView,secondRow,selectedRow,siteField,siteLabel,staPreField,staPrelabel,dateField,dateLabel,divetimeField,divetimeLabel,wavesField,wavesLabel,currentField,currentLabel,mAndf,maxDepField,maxDepLabel,temperField,temperLabel,thirdRow,visiField,visiLabel,otherField,otherLabel,gasArr,gasField,gasLabel,dateFromData,wavesFromData,currentFromData,timeFromData,wavesArr,currentArr,siteButton,locationManager,redWoods;


-(void)loadView
{
    [super loadView];
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 1500);
    scrollView.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"scroll_background.png"]];
    [self.view addSubview:scrollView];
    
    
    gasArr = [NSArray arrayWithObjects:@"一般空氣",@"高氧",@"循環水肺",@"岸上供氣", nil];
    _firstRow = [NSArray arrayWithObjects:@" ",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    secondRow = [NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    thirdRow = [NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    _forthRow = [NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    mAndf = [NSArray arrayWithObjects:@"m",@"ft", nil];
    _cAndf = [NSArray arrayWithObjects:@"°C",@"°F", nil];
    
    wavesArr = [NSArray arrayWithObjects:@"平",@"小",@"中",@"大", nil];
    currentArr = [NSArray arrayWithObjects:@"有",@"無", nil];
    
    
    UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveToData:)];
    self.navigationItem.rightBarButtonItem = save;
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    
    
    
    
    
    delegate = [[UIApplication sharedApplication] delegate];
    managedObjectContext = delegate.managedObjectContext;
    
    logBookTableView = [[LogBookTableViewController alloc] init];
    
    
    
    [self textAndLabel];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
}

-(void)saveToData:(id)sender
{
    
        NSString *dateStr = dateField.text;
        NSLog(@"%@",dateStr);
        
        
        NSString *site = siteField.text;
        
        
        
        NSString *waves = wavesField.text;
        
        
        NSString *current= currentField.text;
        
        
        
        NSString *maxDepth = maxDepField.text;
        
        
        NSString *gasType = gasField.text;
        
        
        NSString *diveTime = divetimeField.text;
        NSNumberFormatter *diveTimeFormatter = [[NSNumberFormatter alloc] init];
        [diveTimeFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber *_diveTime = [diveTimeFormatter numberFromString:diveTime];
        
        
        NSString *visibility = visiField.text;
        
        
        NSString *temperature = temperField.text;
        
        
        NSString *startPressure = staPreField.text;
        //    NSNumberFormatter *startPressureFormatter = [[NSNumberFormatter alloc] init];
        //    [startPressureFormatter setNumberStyle:NSNumberFormatterNoStyle];
        //    NSNumber *_startPressure = [startPressureFormatter numberFromString:startPressure];
        
        
        NSString *endPressure = _endPreField.text;
        //    NSNumberFormatter *endPressureFormatter = [[NSNumberFormatter alloc] init];
        //    [endPressureFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        //    NSNumber *_endPressure = [endPressureFormatter numberFromString:endPressure];
        dateField.text = nil;
        siteField.text = nil;
        wavesField.text = nil;
        currentField.text = nil;
        maxDepField.text = nil;
        gasField.text = nil;
        divetimeField.text = nil;
        visiField.text = nil;
        temperField.text = nil;
        staPreField.text = nil;
        _endPreField.text = nil;
        
        DiveLog *database = (DiveLog *)[NSEntityDescription insertNewObjectForEntityForName:@"DiveLog" inManagedObjectContext:managedObjectContext];
        
        database.date = dateStr;
        database.site = site;
        database.waves = waves;
        database.current = current;
        database.max_depth = maxDepth;
        database.gas_type = gasType;
        database.dive_time = _diveTime;
        database.visibility = visibility;
        database.temperture = temperature;
        database.start_pressure = startPressure;
        database.end_pressure = endPressure;
        
        
        
        NSError *error;
        if (![managedObjectContext save:&error]) {
            NSLog(@"error:%@", [error localizedFailureReason]);
        }
        
        
        
        
        [delegate.navi pushViewController:logBookTableView animated:YES];
        
        
    
}


-(NSString *)formatDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc ] init];
    //    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *formatData = [dateFormatter stringFromDate:date];
    return formatData;
    
}

-(void)updateDateField:(id)sender
{
    UIDatePicker *picker =(UIDatePicker *) dateField.inputView;
    dateField.text = [self formatDate:picker.date];
}

-(void)donePicking:(id)sender
{
    [self.view endEditing:YES];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)aPickerView
{
    if (aPickerView.tag == 201) {
        return 1;
    }else if (aPickerView.tag == 202){
        return 3;
    }else if (aPickerView.tag == 203){
        return 3;
    }else if (aPickerView.tag == 204){
        return 5;
    }else if (aPickerView.tag == 205){
        return 5;
    }else if (aPickerView.tag == 206){
        return 4;
    }else if (aPickerView.tag == 207){
        return 1;
    }else if (aPickerView.tag == 208){
        return 1;
    }
    
    return 0;
}

- (NSInteger)pickerView:(UIPickerView *)_pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (_pickerView.tag == 201) {
        return [gasArr count];
    }else if (_pickerView.tag == 202){
        if (component == 0) {
            return [_firstRow count];
        }else if (component == 1){
            return [secondRow count];
        }else if (component == 2){
            return [thirdRow count];
        }
    }else if (_pickerView.tag == 203){
        if (component == 0) {
            return [_firstRow count];
        }else if (component == 1){
            return [secondRow count];
        }else if (component == 2){
            return [thirdRow count];
        }
    }else if (_pickerView.tag == 204){
        if (component == 0) {
            return [_firstRow count];
        }else if (component == 1){
            return [secondRow count];
        }else if (component == 2){
            return [thirdRow count];
        }else if (component == 3){
            return [_forthRow count];
        }else if (component == 4){
            return [mAndf count];
        }
        
    }else if (_pickerView.tag == 205){
        if (component == 0) {
            return [_firstRow count];
        }else if (component == 1){
            return [secondRow count];
        }else if (component == 2){
            return [thirdRow count];
        }else if (component == 3){
            return [_forthRow count];
        }else if (component == 4){
            return [_cAndf count];
        }
    }else if (_pickerView.tag == 206){
        if (component == 0) {
            return [_firstRow count];
        }else if (component == 1){
            return [secondRow count];
        }else if (component == 2){
            return [thirdRow count];
        }else if (component == 3){
            return [mAndf count];
        }
        
    }else if (_pickerView.tag == 207){
        return [wavesArr count];
    }else if (_pickerView.tag == 208){
        return [currentArr count];
    }
    
    return 0;
}

- (UIView *)pickerView:(UIPickerView *)bPickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    if (bPickerView.tag == 207) {
        UILabel *waveLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
        waveLabel.text = [wavesArr objectAtIndex:row];
        waveLabel.adjustsFontSizeToFitWidth = YES;
        waveLabel.textAlignment = NSTextAlignmentCenter;
        waveLabel.font = [UIFont systemFontOfSize:20];
        return waveLabel;
    }else if (bPickerView.tag == 208){
        UILabel *current_Label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
        current_Label.text = [currentArr objectAtIndex:row];
        current_Label.adjustsFontSizeToFitWidth = YES;
        current_Label.textAlignment = NSTextAlignmentCenter;
        current_Label.font = [UIFont systemFontOfSize:20];
        return current_Label;
    }else if (bPickerView.tag == 201){
        UILabel *gas_Label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
        gas_Label.text = [gasArr objectAtIndex:row];
        gas_Label.adjustsFontSizeToFitWidth = YES;
        gas_Label.textAlignment = NSTextAlignmentCenter;
        gas_Label.font = [UIFont systemFontOfSize:20.0];
        return gas_Label;
    }else if (bPickerView.tag == 202){
        if (component == 0) {
            UILabel *first_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            first_row.text = [_firstRow objectAtIndex:row];
            first_row.adjustsFontSizeToFitWidth = YES;
            first_row.textAlignment = NSTextAlignmentCenter;
            first_row.font = [UIFont systemFontOfSize:20.0];
            return first_row;
            
        }else if (component == 1){
            UILabel *second_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            second_row.text = [secondRow objectAtIndex:row];
            second_row.adjustsFontSizeToFitWidth = YES;
            second_row.textAlignment = NSTextAlignmentCenter;
            second_row.font = [UIFont systemFontOfSize:20.0];
            return second_row;
        }else if (component == 2){
            UILabel *third_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            third_row.text = [thirdRow objectAtIndex:row];
            third_row.adjustsFontSizeToFitWidth = YES;
            third_row.textAlignment = NSTextAlignmentCenter;
            third_row.font = [UIFont systemFontOfSize:20.0];
            return third_row;
        }
        
    }else if (bPickerView.tag == 203){
        if (component == 0) {
            UILabel *first_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            first_row.text = [_firstRow objectAtIndex:row];
            first_row.adjustsFontSizeToFitWidth = YES;
            first_row.textAlignment = NSTextAlignmentCenter;
            first_row.font = [UIFont systemFontOfSize:20.0];
            return first_row;
            
        }else if (component == 1){
            UILabel *second_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            second_row.text = [secondRow objectAtIndex:row];
            second_row.adjustsFontSizeToFitWidth = YES;
            second_row.textAlignment = NSTextAlignmentCenter;
            second_row.font = [UIFont systemFontOfSize:20.0];
            return second_row;
        }else if (component == 2){
            UILabel *third_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            third_row.text = [thirdRow objectAtIndex:row];
            third_row.adjustsFontSizeToFitWidth = YES;
            third_row.textAlignment = NSTextAlignmentCenter;
            third_row.font = [UIFont systemFontOfSize:20.0];
            return third_row;
        }
    }else if (bPickerView.tag == 204){
        if (component == 0) {
            UILabel *first_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            first_row.text = [_firstRow objectAtIndex:row];
            first_row.adjustsFontSizeToFitWidth = YES;
            first_row.textAlignment = NSTextAlignmentCenter;
            first_row.font = [UIFont systemFontOfSize:20.0];
            return first_row;
            
        }else if (component == 1){
            UILabel *second_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            second_row.text = [secondRow objectAtIndex:row];
            second_row.adjustsFontSizeToFitWidth = YES;
            second_row.textAlignment = NSTextAlignmentCenter;
            second_row.font = [UIFont systemFontOfSize:20.0];
            return second_row;
        }else if (component == 2){
            UILabel *third_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            third_row.text = [thirdRow objectAtIndex:row];
            third_row.adjustsFontSizeToFitWidth = YES;
            third_row.textAlignment = NSTextAlignmentCenter;
            third_row.font = [UIFont systemFontOfSize:20.0];
            return third_row;
        }else if (component == 3){
            UILabel *forth_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            forth_row.text = [_forthRow objectAtIndex:row];
            forth_row.adjustsFontSizeToFitWidth = YES;
            forth_row.textAlignment = NSTextAlignmentCenter;
            forth_row.font = [UIFont systemFontOfSize:20.0];
            return forth_row;
        }else if (component == 4){
            UILabel *parameter = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            parameter.text = [mAndf objectAtIndex:row];
            parameter.adjustsFontSizeToFitWidth = YES;
            parameter.textAlignment = NSTextAlignmentCenter;
            parameter.font = [UIFont systemFontOfSize:20.0];
            return parameter;
        }
    }else if (bPickerView.tag == 205){
        if (component == 0) {
            UILabel *first_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            first_row.text = [_firstRow objectAtIndex:row];
            first_row.adjustsFontSizeToFitWidth = YES;
            first_row.textAlignment = NSTextAlignmentCenter;
            first_row.font = [UIFont systemFontOfSize:20.0];
            return first_row;
            
        }else if (component == 1){
            UILabel *second_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            second_row.text = [secondRow objectAtIndex:row];
            second_row.adjustsFontSizeToFitWidth = YES;
            second_row.textAlignment = NSTextAlignmentCenter;
            second_row.font = [UIFont systemFontOfSize:20.0];
            return second_row;
        }else if (component == 2){
            UILabel *third_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            third_row.text = [thirdRow objectAtIndex:row];
            third_row.adjustsFontSizeToFitWidth = YES;
            third_row.textAlignment = NSTextAlignmentCenter;
            third_row.font = [UIFont systemFontOfSize:20.0];
            return third_row;
        }else if (component == 3){
            UILabel *forth_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            forth_row.text = [_forthRow objectAtIndex:row];
            forth_row.adjustsFontSizeToFitWidth = YES;
            forth_row.textAlignment = NSTextAlignmentCenter;
            forth_row.font = [UIFont systemFontOfSize:20.0];
            return forth_row;
        }else if (component == 4){
            UILabel *temperture = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            temperture.text = [_cAndf objectAtIndex:row];
            temperture.adjustsFontSizeToFitWidth = YES;
            temperture.textAlignment = NSTextAlignmentCenter;
            temperture.font = [UIFont systemFontOfSize:20.0];
            return temperture;
        }
    }else if (bPickerView.tag == 206){
        if (component == 0) {
            UILabel *first_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            first_row.text = [_firstRow objectAtIndex:row];
            first_row.adjustsFontSizeToFitWidth = YES;
            first_row.textAlignment = NSTextAlignmentCenter;
            first_row.font = [UIFont systemFontOfSize:20.0];
            return first_row;
            
        }else if (component == 1){
            UILabel *second_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            second_row.text = [secondRow objectAtIndex:row];
            second_row.adjustsFontSizeToFitWidth = YES;
            second_row.textAlignment = NSTextAlignmentCenter;
            second_row.font = [UIFont systemFontOfSize:20.0];
            return second_row;
        }else if (component == 2){
            UILabel *third_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            third_row.text = [thirdRow objectAtIndex:row];
            third_row.adjustsFontSizeToFitWidth = YES;
            third_row.textAlignment = NSTextAlignmentCenter;
            third_row.font = [UIFont systemFontOfSize:20.0];
            return third_row;
        }else if (component == 3){
            UILabel *parameter = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            parameter.text = [mAndf objectAtIndex:row];
            parameter.adjustsFontSizeToFitWidth = YES;
            parameter.textAlignment = NSTextAlignmentCenter;
            parameter.font = [UIFont systemFontOfSize:20.0];
            return parameter;
        }
        
    }
    return NULL;
}


- (void)pickerView:(UIPickerView *)aPickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (aPickerView.tag == 201) {
        NSInteger row = [aPickerView selectedRowInComponent:0];
        selectedRow = [gasArr objectAtIndex:row];
        gasField.text = selectedRow;
    }else if (aPickerView.tag == 202){
        NSInteger row1 = [aPickerView selectedRowInComponent:0];
        NSInteger row2 = [aPickerView selectedRowInComponent:1];
        NSInteger row3 = [aPickerView selectedRowInComponent:2];
        staPreField.text = [NSString stringWithFormat:@"%@ %@ %@",[_firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3]];
    }else if (aPickerView.tag == 203){
        NSInteger row1 = [aPickerView selectedRowInComponent:0];
        NSInteger row2 = [aPickerView selectedRowInComponent:1];
        NSInteger row3 = [aPickerView selectedRowInComponent:2];
        _endPreField.text = [NSString stringWithFormat:@"%@ %@ %@",[_firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3]];
    }else if (aPickerView.tag == 204){
        NSInteger row1 = [aPickerView selectedRowInComponent:0];
        NSInteger row2 = [aPickerView selectedRowInComponent:1];
        NSInteger row3 = [aPickerView selectedRowInComponent:2];
        NSInteger row4 = [aPickerView selectedRowInComponent:3];
        NSInteger row5 = [aPickerView selectedRowInComponent:4];
        maxDepField.text = [NSString stringWithFormat:@"%@%@%@.%@ %@",[_firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3],[_forthRow objectAtIndex:row4],[mAndf objectAtIndex:row5]];
    }else if (aPickerView.tag == 205){
        NSInteger row1 = [aPickerView selectedRowInComponent:0];
        NSInteger row2 = [aPickerView selectedRowInComponent:1];
        NSInteger row3 = [aPickerView selectedRowInComponent:2];
        NSInteger row4 = [aPickerView selectedRowInComponent:3];
        NSInteger row5 = [aPickerView selectedRowInComponent:4];
        temperField.text = [NSString stringWithFormat:@"%@%@%@.%@ %@",[_firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3],[_forthRow objectAtIndex:row4],[_cAndf objectAtIndex:row5]];
    }else if (aPickerView.tag == 206){
        NSInteger row1 = [aPickerView selectedRowInComponent:0];
        NSInteger row2 = [aPickerView selectedRowInComponent:1];
        NSInteger row3 = [aPickerView selectedRowInComponent:2];
        NSInteger row4 = [aPickerView selectedRowInComponent:3];
        visiField.text = [NSString stringWithFormat:@"%@%@%@ %@",[_firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3],[mAndf objectAtIndex:row4]];
    }else if (aPickerView.tag == 207){
        NSInteger row = [aPickerView selectedRowInComponent:0];
        selectedRow = [wavesArr objectAtIndex:row];
        wavesField.text = selectedRow;
    }else if (aPickerView.tag == 208){
        NSInteger row = [aPickerView selectedRowInComponent:0];
        selectedRow = [currentArr objectAtIndex:row];
        currentField.text = selectedRow;
    }
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)aTextField
{
    if (aTextField.tag == 101) {
        UIDatePicker *datePicker = [[UIDatePicker alloc] init];
        datePicker.datePickerMode = UIDatePickerModeDate;
        datePicker.minimumDate = [NSDate dateWithTimeIntervalSince1970:-31536000];
        //[NSDate dateWithTimeIntervalSinceNow:-31536000];
        [datePicker setDate:[NSDate date]];
        [datePicker addTarget:self action:@selector(updateDateField:) forControlEvents:UIControlEventValueChanged];
        aTextField.inputView = datePicker;
        aTextField.text = [self formatDate:datePicker.date];
        
        
        UIToolbar *cancelBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePicking:)];
        cancelBar.items = [NSArray arrayWithObject:right];
        
        aTextField.inputAccessoryView = cancelBar;
    }else if (aTextField.tag == 102){
        
        aTextField.returnKeyType = UIReturnKeyDone;
        
    }else if (aTextField.tag == 103){
        
        UIPickerView *wavePicker = [[UIPickerView alloc] init];
        wavePicker.delegate = self;
        wavePicker.dataSource = self;
        wavePicker.showsSelectionIndicator = YES;
        [wavePicker setFrame:CGRectMake(0, 480, 320, 180)];
        
        [wavePicker setTag:207];
        
        aTextField.inputView = wavePicker;
        NSInteger row = [wavePicker selectedRowInComponent:0];
        aTextField.text = [wavesArr objectAtIndex:row];
        
        UIToolbar *cancelBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePicking:)];
        cancelBar.items = [NSArray arrayWithObject:right];
        aTextField.inputAccessoryView = cancelBar;
    }else if (aTextField.tag == 104){
        
        UIPickerView *currentPicker = [[UIPickerView alloc] init];
        currentPicker.delegate = self;
        currentPicker.dataSource = self;
        currentPicker.showsSelectionIndicator = YES;
        [currentPicker setFrame:CGRectMake(0, 480, 320, 180)];
        
        [currentPicker setTag:208];
        
        aTextField.inputView = currentPicker;
        NSInteger row = [currentPicker selectedRowInComponent:0];
        aTextField.text = [currentArr objectAtIndex:row];
        
        UIToolbar *cancelBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePicking:)];
        cancelBar.items = [NSArray arrayWithObject:right];
        aTextField.inputAccessoryView = cancelBar;
    }else if (aTextField.tag == 105){
        
        UIPickerView *gasPicker = [[UIPickerView alloc] init];
        gasPicker.delegate = self;
        gasPicker.dataSource = self;
        gasPicker.showsSelectionIndicator = YES;
        [gasPicker setFrame:CGRectMake(0, 480, 320, 180)];
        
        [gasPicker setTag:201];
        
        aTextField.inputView = gasPicker;
        NSInteger row = [gasPicker selectedRowInComponent:0];
        aTextField.text = [gasArr objectAtIndex:row];
        
        UIToolbar *cancelBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePicking:)];
        cancelBar.items = [NSArray arrayWithObject:right];
        aTextField.inputAccessoryView = cancelBar;
        
    }else if (aTextField.tag == 106){
        
        UIPickerView *staPre = [[UIPickerView alloc] init];
        staPre.delegate = self;
        staPre.dataSource = self;
        staPre.showsSelectionIndicator = YES;
        [staPre setFrame:CGRectMake(0, 480, 320, 180)];
        [staPre setTag:202];
        
        aTextField.inputView = staPre;
        NSInteger row1 = [staPre selectedRowInComponent:0];
        NSInteger row2 = [staPre selectedRowInComponent:1];
        NSInteger row3 = [staPre selectedRowInComponent:2];
        aTextField.text = [NSString stringWithFormat:@"%@ %@ %@",[_firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3]];
        
        UIToolbar *cancelBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePicking:)];
        cancelBar.items = [NSArray arrayWithObject:right];
        aTextField.inputAccessoryView = cancelBar;
        
    }else if (aTextField.tag == 107){
        
        UIPickerView *endPre = [[UIPickerView alloc] init];
        endPre.delegate = self;
        endPre.dataSource = self;
        endPre.showsSelectionIndicator = YES;
        [endPre setFrame:CGRectMake(0, 480, 320, 180)];
        [endPre setTag:203];
        
        aTextField.inputView = endPre;
        NSInteger row1 = [endPre selectedRowInComponent:0];
        NSInteger row2 = [endPre selectedRowInComponent:1];
        NSInteger row3 = [endPre selectedRowInComponent:2];
        aTextField.text = [NSString stringWithFormat:@"%@ %@ %@",[_firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3]];
        
        UIToolbar *cancelBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePicking:)];
        cancelBar.items = [NSArray arrayWithObject:right];
        aTextField.inputAccessoryView = cancelBar;
        
    }else if (aTextField.tag == 108){
        
        UIPickerView *maxD = [[UIPickerView alloc] init];
        maxD.delegate = self;
        maxD.dataSource = self;
        maxD.showsSelectionIndicator = YES;
        [maxD setFrame:CGRectMake(0, 480, 320, 180)];
        [maxD setTag:204];
        
        aTextField.inputView = maxD;
        NSInteger row1 = [maxD selectedRowInComponent:0];
        NSInteger row2 = [maxD selectedRowInComponent:1];
        NSInteger row3 = [maxD selectedRowInComponent:2];
        NSInteger row4 = [maxD selectedRowInComponent:3];
        NSInteger row5 = [maxD selectedRowInComponent:4];
        aTextField.text = [NSString stringWithFormat:@"%@%@%@.%@ %@",[_firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3],[_forthRow objectAtIndex:row4],[mAndf objectAtIndex:row5]];
        
        UIToolbar *cancelBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePicking:)];
        cancelBar.items = [NSArray arrayWithObject:right];
        aTextField.inputAccessoryView = cancelBar;
        
    }else if (aTextField.tag == 109){
        UIPickerView *temp = [[UIPickerView alloc] init];
        temp.delegate = self;
        temp.dataSource = self;
        temp.showsSelectionIndicator = YES;
        [temp setFrame:CGRectMake(0, 480, 320, 180)];
        [temp setTag:205];
        
        aTextField.inputView = temp;
        NSInteger row1 = [temp selectedRowInComponent:0];
        NSInteger row2 = [temp selectedRowInComponent:1];
        NSInteger row3 = [temp selectedRowInComponent:2];
        NSInteger row4 = [temp selectedRowInComponent:3];
        NSInteger row5 = [temp selectedRowInComponent:4];
        aTextField.text = [NSString stringWithFormat:@"%@%@%@.%@ %@",[_firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3],[_forthRow objectAtIndex:row4],[_cAndf objectAtIndex:row5]];
        
        UIToolbar *cancelBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePicking:)];
        cancelBar.items = [NSArray arrayWithObject:right];
        aTextField.inputAccessoryView = cancelBar;
        
    }else if (aTextField.tag == 110){
        UIPickerView *visi = [[UIPickerView alloc] init];
        visi.delegate = self;
        visi.dataSource = self;
        visi.showsSelectionIndicator = YES;
        [visi setFrame:CGRectMake(0, 480, 320, 180)];
        [visi setTag:206];
        
        aTextField.inputView = visi;
        NSInteger row1 = [visi selectedRowInComponent:0];
        NSInteger row2 = [visi selectedRowInComponent:1];
        NSInteger row3 = [visi selectedRowInComponent:2];
        NSInteger row4 = [visi selectedRowInComponent:3];
        aTextField.text = [NSString stringWithFormat:@"%@%@%@ %@",[_firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3],[mAndf objectAtIndex:row4]];
        
        UIToolbar *cancelBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePicking:)];
        cancelBar.items = [NSArray arrayWithObject:right];
        aTextField.inputAccessoryView = cancelBar;
        
    }else if (aTextField.tag == 111){
        
        aTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        aTextField.returnKeyType = UIReturnKeyDone;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ((dateField.text.length > 0) && (wavesField.text.length > 0) && (currentField.text.length > 0)
        && (gasField.text.length > 0) && (staPreField.text.length > 0) &&
        (_endPreField.text.length > 0) && (maxDepField.text.length > 0) && (divetimeField.text.length >0) && (temperField.text.length > 0) && (visiField.text.length > 0)) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
    else{
        
        self.navigationItem.rightBarButtonItem.enabled = NO;
        
    }
    
}


-(void)textAndLabel
{
    dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 88, 80, 21)];
    dateLabel.backgroundColor = [UIColor clearColor];
    [dateLabel setText:@"日期"];
    [scrollView addSubview:dateLabel];
    
    dateField = [[UITextField alloc] initWithFrame:CGRectMake(130, 85, 97, 30)];
    dateField.backgroundColor = [UIColor clearColor];
    [dateField setTag:101];
    dateField.delegate = self;
    dateField.placeholder = @"YYYY-mm-dd";
    dateField.borderStyle = UITextBorderStyleRoundedRect;
    dateField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:dateField];
    
    siteLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 154, 80, 21)];
    siteLabel.backgroundColor = [UIColor clearColor];
    [siteLabel setText:@"潛點"];
    [scrollView addSubview:siteLabel];
    
    siteField = [[UITextField alloc] initWithFrame:CGRectMake(130, 151, 97, 30)];
    siteField.backgroundColor = [UIColor clearColor];
    [siteField setTag:102];
    siteField.delegate = self;
    siteField.placeholder = @"Site Name";
    siteField.borderStyle = UITextBorderStyleRoundedRect;
    siteField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:siteField];
    
    siteButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [siteButton setTitle:@"Auto" forState:UIControlStateNormal];
    [siteButton setFrame:CGRectMake(210, 124, 80, 80)];
    [siteButton addTarget:self action:@selector(locateSite) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:siteButton];
    
    wavesLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 220, 100, 21)];
    wavesLabel.backgroundColor = [UIColor clearColor];
    [wavesLabel setText:@"浪況"];
    [scrollView addSubview:wavesLabel];
    
    wavesField = [[UITextField alloc] initWithFrame:CGRectMake(130, 217, 97, 30)];
    wavesField.backgroundColor = [UIColor clearColor];
    [wavesField setTag:103];
    wavesField.delegate = self;
    //wavesField.placeholder = @"25.061033";
    wavesField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:wavesField];
    
    currentLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 286, 100, 21)];
    currentLabel.backgroundColor = [UIColor clearColor];
    [currentLabel setText:@"水流"];
    [scrollView addSubview:currentLabel];
    
    currentField = [[UITextField alloc] initWithFrame:CGRectMake(130, 283, 97, 30)];
    currentField.backgroundColor = [UIColor clearColor];
    [currentField setTag:104];
    currentField.delegate = self;
    //currentField.placeholder = @"121.646056";
    currentField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:currentField];
    
    gasLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 352, 100, 21)];
    gasLabel.backgroundColor = [UIColor clearColor];
    [gasLabel setText:@"氣源"];
    [scrollView addSubview:gasLabel];
    
    gasField = [[UITextField alloc] initWithFrame:CGRectMake(130, 349, 97, 30)];
    [gasField setTag:105];
    gasField.delegate = self;
    //gasField.placeholder = @"氣源";
    gasField.borderStyle = UITextBorderStyleRoundedRect;
    gasField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:gasField];
    
    staPrelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 428, 200, 21)];
    staPrelabel.backgroundColor = [UIColor clearColor];
    [staPrelabel setText:@"Start Pressure"];
    [scrollView addSubview:staPrelabel];
    
    staPreField = [[UITextField alloc] initWithFrame:CGRectMake(130, 425, 97, 30)];
    staPreField.backgroundColor = [UIColor clearColor];
    [staPreField setTag:106];
    staPreField.delegate = self;
    staPreField.placeholder = @"200 bar";
    staPreField.borderStyle = UITextBorderStyleRoundedRect;
    staPreField.adjustsFontSizeToFitWidth = YES;
    staPreField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:staPreField];
    
    _endPreLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 494, 200, 21)];
    _endPreLabel.backgroundColor = [UIColor clearColor];
    [_endPreLabel setText:@"End Pressure"];
    [scrollView addSubview:_endPreLabel];
    
    _endPreField = [[UITextField alloc] initWithFrame:CGRectMake(130, 491, 97, 30)];
    _endPreField.backgroundColor = [UIColor clearColor];
    [_endPreField setTag:107];
    _endPreField.delegate = self;
    _endPreField.placeholder = @"60 bar";
    _endPreField.borderStyle = UITextBorderStyleRoundedRect;
    _endPreField.adjustsFontSizeToFitWidth = YES;
    _endPreField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:_endPreField];
    
    maxDepLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 560, 100, 21)];
    maxDepLabel.backgroundColor = [UIColor clearColor];
    [maxDepLabel setText:@"最大深度"];
    [scrollView addSubview:maxDepLabel];
    
    maxDepField = [[UITextField alloc] initWithFrame:CGRectMake(130, 557, 97, 30)];
    maxDepField.backgroundColor = [UIColor clearColor];
    [maxDepField setTag:108];
    maxDepField.delegate = self;
    maxDepField.placeholder = @"40 M";
    maxDepField.borderStyle = UITextBorderStyleRoundedRect;
    maxDepField.adjustsFontSizeToFitWidth = YES;
    maxDepField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:maxDepField];
    
    divetimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 626, 100, 21)];
    divetimeLabel.backgroundColor = [UIColor clearColor];
    [divetimeLabel setText:@"潛水時間"];
    [scrollView addSubview:divetimeLabel];
    
    divetimeField = [[UITextField alloc] initWithFrame:CGRectMake(130, 623, 97, 30)];
    divetimeField.backgroundColor = [UIColor clearColor];
    [divetimeField setTag:111];
    divetimeField.delegate = self;
    divetimeField.placeholder = @"in minutes";
    divetimeField.borderStyle = UITextBorderStyleRoundedRect;
    divetimeField.adjustsFontSizeToFitWidth = YES;
    divetimeField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:divetimeField];
    
    temperLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 692, 100, 21)];
    temperLabel.backgroundColor = [UIColor clearColor];
    [temperLabel setText:@"水溫"];
    [scrollView addSubview:temperLabel];
    
    temperField = [[UITextField alloc] initWithFrame:CGRectMake(130, 689, 97, 30)];
    temperField.backgroundColor = [UIColor clearColor];
    [temperField setTag:109];
    temperField.delegate = self;
    temperField.placeholder = @"";
    temperField.borderStyle = UITextBorderStyleRoundedRect;
    temperField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:temperField];
    
    visiLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 758, 100, 21)];
    visiLabel.backgroundColor = [UIColor clearColor];
    [visiLabel setText:@"能見度"];
    [scrollView addSubview:visiLabel];
    
    visiField = [[UITextField alloc] initWithFrame:CGRectMake(130, 755, 97, 30)];
    visiField.backgroundColor = [UIColor clearColor];
    [visiField setTag:110];
    visiField.delegate = self;
    visiField.placeholder = @"15M";
    visiField.borderStyle = UITextBorderStyleRoundedRect;
    visiField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:visiField];
    
    
    
}


-(void)locateSite
{
    /*
    CLLocationCoordinate2D redwoodCenter;
    redwoodCenter.latitude =25.066427;
    //21.9721199;
    redwoodCenter.longitude =121.633734;
    //120.712141;
    
    redWoods = [[CLCircularRegion alloc] initWithCenter:redwoodCenter radius:800 identifier:@"red_woods"];
    [locationManager startMonitoringForRegion:redWoods];
    
    
    
    NSLog(@"現在位置:%@", [locationManager location]);
     */
}

/*
- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    [[[UIAlertView alloc] initWithTitle:@"Test" message:@"測試進入區域監測功能" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil]show];
    if ([region.identifier isEqualToString:@"red_woods"]) {
        temperField.text = @"紅柴坑";
    }
    
}


- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    
        NSLog(@"不再區域內");
    
}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
{
    NSLog(@"Now monitoring : %@",region.identifier);
}
*/

-(void)viewDidDisappear:(BOOL)animated
{
    dateField.text = nil;
    siteField.text = nil;
    wavesField.text = nil;
    currentField.text = nil;
    maxDepField.text = nil;
    gasField.text = nil;
    divetimeField.text = nil;
    visiField.text = nil;
    temperField.text = nil;
    staPreField.text = nil;
    _endPreField.text = nil;
    
}

-(BOOL)shouldAutorotate
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    dateField.text = nil;
    siteField.text = nil;
    wavesField.text = nil;
    currentField.text = nil;
    maxDepField.text = nil;
    gasField.text = nil;
    divetimeField.text = nil;
    visiField.text = nil;
    temperField.text = nil;
    staPreField.text = nil;
    _endPreField.text = nil;
    

    // Dispose of any resources that can be recreated.
}
@end
