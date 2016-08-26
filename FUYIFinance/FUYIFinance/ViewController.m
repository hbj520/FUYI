//
//  ViewController.m
//  FUYIFinance
//
//  Created by youyou on 16/6/6.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking/AFNetworking.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: {
                NSLog(@"未知网络");
                break;
            }
            case AFNetworkReachabilityStatusNotReachable: {
                NSLog(@"无网络");
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN: {
                NSLog(@"移动网络");
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi: {
                NSLog(@"AFNetworkReachabilityStatusReachableViaWiFi");
                break;
            }
            default: {
                break;
            }
        }
    }];
    [manager isReachableViaWiFi];
    [manager startMonitoring];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
