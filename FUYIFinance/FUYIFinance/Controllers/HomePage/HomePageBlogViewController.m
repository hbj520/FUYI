//
//  HomePageBlogViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/8/16.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "HomePageBlogViewController.h"

@interface HomePageBlogViewController ()<UIWebViewDelegate>
{
    UIWebView * _webView;
}
@end

@implementation HomePageBlogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
    _webView.delegate = self;
    [_webView setScalesPageToFit:YES];
    [self.view addSubview:_webView];
    if(KToken.length == 0){
        [self logOut];
    }else{
        NSURL * url = [NSURL URLWithString:@"http://60.173.235.34:9090/fuyi/app/nos_blog_tuijian"];
        NSString * body = [NSString stringWithFormat:@"token=%@",KToken];
        NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:url];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
        [_webView loadRequest:request];
    }

}
#pragma mark - PrivateMethod
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}


#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [_webView setScalesPageToFit:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_webView setScalesPageToFit:YES];
}

//回退
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
