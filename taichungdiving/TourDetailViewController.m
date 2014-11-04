//
//  TourDetailViewController.m
//  taichungdiving
//
//  Created by Samuel Teng on 2014/11/4.
//  Copyright (c) 2014年 SamuelTeng. All rights reserved.
//

#import "TourDetailViewController.h"

@interface TourDetailViewController (){
    
    UIActivityIndicatorView *spinner;

}

@end

@implementation TourDetailViewController

@synthesize webView,pageData;

-(void)loadView
{
    [super loadView];
    self.view.backgroundColor=[UIColor purpleColor];
    spinner=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.webView.frame=self.view.bounds;
    spinner.frame=self.view.bounds;
    self.webView.scalesPageToFit = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)setPageData:(NSDictionary *)page_Data
{
    pageData=page_Data;
    self.webView=[[UIWebView alloc]initWithFrame:CGRectZero];
    /*set the delegate to catch the timing of load and finish load web view*/
    self.webView.delegate=self;
    [self.view addSubview:self.webView];
    self.title=[pageData objectForKey:@"page"];
    
    NSString *pathString=[pageData objectForKey:@"url"];
    NSURL *pathURL=[[NSURL alloc]initWithString:pathString];
    NSURLRequest *urlRequest=[[NSURLRequest alloc]initWithURL:pathURL];
    [self.webView loadRequest:urlRequest];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [spinner stopAnimating];
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    spinner.color=[UIColor blackColor];
    [self.view addSubview:spinner];
    [spinner startAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
   
    spinner = nil;
    pageData = nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
