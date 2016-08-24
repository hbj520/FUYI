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
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,64, ScreenWidth, ScreenHeight-112)];
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
   // [_webView loadRequest:request];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadwebrequest) name:@"loadrequest" object:nil];
}

- (void)loadwebrequest
{
    
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

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [webView setScalesPageToFit:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
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
