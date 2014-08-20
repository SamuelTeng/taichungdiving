//
//  LogBookTableViewController.m
//  taichungdiving
//
//  Created by Samuel Teng on 2014/8/19.
//  Copyright (c) 2014年 SamuelTeng. All rights reserved.
//

#import "LogBookTableViewController.h"
#import "MainViewController.h"
#import "AppDelegate.h"
#import "DiveLog.h"

@interface LogBookTableViewController (){
    
    AppDelegate *delegate_logbook;
    MainViewController *mainView;
    DiveLog *diveLog;
}

@end

@implementation LogBookTableViewController

@synthesize resultController;

-(void)fetchData
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"DiveLog" inManagedObjectContext:delegate_logbook.managedObjectContext]];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObject:sortDescriptor];
    [request setSortDescriptors:descriptors];
    
    NSError *error;
    resultController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:delegate_logbook.managedObjectContext sectionNameKeyPath:@"date" cacheName:nil];
    resultController.delegate = self;
    if (![resultController performFetch:&error]) {
        NSLog(@"error : %@", [error localizedFailureReason]);
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [delegate_logbook.navi pushViewController:mainView animated:NO];
            break;
            
            
        default:
            break;
    }
}


-(void)loadView
{
    [super loadView];
    delegate_logbook = [[UIApplication sharedApplication] delegate];
    mainView = [[MainViewController alloc] init];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchData];
    
    if (! resultController.fetchedObjects.count) {
        UIAlertView *noLog = [[UIAlertView alloc] initWithTitle:@"無日誌記錄" message:@"沒有日誌記錄，請按下\"新增\"新增一筆日誌或\"取消\"回到主頁面" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"新增", nil];
        [noLog show];
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    int count = resultController.fetchedObjects.count;
    NSString *countOfLogs = [NSString stringWithFormat:@"目前支數:%i",count];
    self.navigationItem.title = countOfLogs;
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return [[resultController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [[[resultController sections] objectAtIndex:section]numberOfObjects];
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
