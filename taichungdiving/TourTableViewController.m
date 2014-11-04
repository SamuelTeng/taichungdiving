//
//  TourTableViewController.m
//  taichungdiving
//
//  Created by Samuel Teng on 2014/11/4.
//  Copyright (c) 2014年 SamuelTeng. All rights reserved.
//

#import "TourTableViewController.h"
#define kSection 2
#define kDomestic 0
#define kForeign 1

@interface TourTableViewController ()

@end

@implementation TourTableViewController

@synthesize domesticTour,foreignTour;

-(id)init
{
    self=[super init];
    if (self) {
        domesticTour=[[NSMutableArray alloc]init];
        foreignTour=[[NSMutableArray alloc]init];
        /*use NSDictionary to contain string&key*url data*/
        [domesticTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"東北角潛水旅遊",@"page",@"http://www.td-club.com.tw/Travels.asp?ID=E5_2D",@"url", nil]];
        [domesticTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"琉球嶼潛水旅遊",@"page",@"http://www.td-club.com.tw/Travels.asp?ID=E2_2D",@"url", nil]];
        [domesticTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"綠島潛水旅遊",@"page",@"http://www.td-club.com.tw/Travels.asp?ID=E3_3D",@"url", nil]];
         [domesticTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"蘭嶼潛水旅遊",@"page",@"http://www.td-club.com.tw/Travels.asp?ID=E4_3D",@"url", nil]];
         [domesticTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"澎湖潛水旅遊",@"page",@"http://www.td-club.com.tw/Travels.asp?ID=E6_2D",@"url", nil]];
         [domesticTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"墾丁潛水旅遊",@"page",@"http://www.td-club.com.tw/Travels.asp?ID=E1_2D",@"url", nil]];
        
/*-------------------------------------------------------------------------------------------*/
        
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"馬爾地夫船宿潛水旅遊",@"page",@"http://www.td-club.com.tw/Travels.asp?ID=G1_9D",@"url", nil]];
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"斯米蘭船宿潛水旅遊",@"page",@"http://www.td-club.com.tw/Travels.asp?ID=G3_6D",@"url", nil]];
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"蘇祿海船宿潛水旅遊",@"page",@"http://www.td-club.com.tw/Travels.asp?ID=G4_7D",@"url", nil]];
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"大堡礁潛水旅遊",@"page",@"http://www.td-club.com.tw/Travels.asp?ID=F05_9D",@"url", nil]];
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"明多洛潛水旅遊",@"page",@"http://www.td-club.com.tw/Travels.asp?ID=F10_6D",@"url", nil]];
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"帛琉潛水旅遊",@"page",@"http://www.td-club.com.tw/Travels.asp?ID=F12_5D",@"url", nil]];
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"西巴丹潛水旅遊",@"page",@"http://www.td-club.com.tw/Travels.asp?ID=F16_5D",@"url", nil]];
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"刁曼島潛水旅遊",@"page",@"http://www.td-club.com.tw/Travels.asp?ID=F18_5D",@"url", nil]];
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"莫亞礁潛水旅遊",@"page",@"http://www.td-club.com.tw/Travels.asp?ID=F19_5D",@"url", nil]];
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"阿尼洛潛水旅遊",@"page",@"http://www.td-club.com.tw/Travels.asp?ID=F01_5D",@"url", nil]];
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"杜馬蓋地潛水旅遊",@"page",@"http://www.td-club.com.tw/Travels.asp?ID=F03_5D",@"url", nil]];
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"薄荷島潛水旅遊",@"page",@"http://www.td-club.com.tw/Travels.asp?ID=F02_5D",@"url", nil]];
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"沖繩島潛水旅遊",@"page",@"http://www.td-club.com.tw/Travels.asp?ID=F11_5D",@"url", nil]];
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"普吉島潛水旅遊",@"page",@"http://www.td-club.com.tw/Travels.asp?ID=F13_5D",@"url", nil]];
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"馬拉杜阿潛水旅遊",@"page",@"http://www.td-club.com.tw/Travels.asp?ID=F21_6D",@"url", nil]];
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"土蘭奔潛水旅遊",@"page",@"http://www.td-club.com.tw/Travels.asp?ID=F20_6D",@"url", nil]];
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    domesticTour = nil;
    foreignTour = nil;
}

-(NSArray *)whichArray:(NSUInteger)integer
{
    NSArray *current;
    switch (integer) {
        case kDomestic:
            current=domesticTour;
            break;
            
        case kForeign:
            current=foreignTour;
            break;
        default:
            break;
    }
    return current;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    
        return kSection;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    switch (section) {
        case kDomestic:
            return [domesticTour count];
            break;
            
        case kForeign:
            return [foreignTour count];
            break;
            
        default:
            return 0;
            break;
    }
    
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
