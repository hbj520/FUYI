//
//  StockDetailViewController.m
//  FUYIFinance
//
//  Created by youyou on 16/12/16.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "StockDetailViewController.h"

@interface StockDetailViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *stockAnnalyzeWebView;
- (IBAction)backBtn:(id)sender;
@end

@implementation StockDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.1.227:9090/app/toStockAnal&token=%@",KToken]]];
//    self.stockAnnalyzeWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
   // [self.view addSubview:_webView];
    [ self.stockAnnalyzeWebView loadRequest:request];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.hidesBackButton = YES;
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

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
