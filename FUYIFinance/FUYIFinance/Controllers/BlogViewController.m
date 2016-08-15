//
//  BlogViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/8/12.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "BlogViewController.h"

@interface BlogViewController ()<UIWebViewDelegate>
{
    UIWebView * _webView;
}
@end

@implementation BlogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.fuyi001.com/blog/blogIndex.html"]];
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,64, ScreenWidth, ScreenHeight-64)];
    _webView.delegate = self;
    [_webView setScalesPageToFit:YES];
    [self.view addSubview:_webView];
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://www.fuyi001.com/blog/blogIndex.html"]];
    [_webView loadRequest:request];
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [webView setScalesPageToFit:YES];
}

- (IBAction)back:(id)sender {
    [_webView goBack];
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
