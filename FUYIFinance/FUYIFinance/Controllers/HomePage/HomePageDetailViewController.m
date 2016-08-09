//
//  HomePageDetailViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/8/9.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "HomePageDetailViewController.h"

@interface HomePageDetailViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation HomePageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString: @"http://www.baidu.com"]];
    [self.webView loadRequest:request];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
