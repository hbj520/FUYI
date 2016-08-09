//
//  BaseViewController.m
//  FUYIFinance
//
//  Created by youyou on 16/6/16.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "BaseViewController.h"
#import "MineLoginViewController.h"
#import "AppDelegate.h"
#import "GestureUnlockViewController.h"
//#import <IJKMediaFramework/IJKFFMonitor.h>

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - PrivateMethod
//登陆超时和未登录跳转至登陆
- (void)logOut{
        if (KToken) {
            [[Config Instance] logout];
        }
        UIStoryboard *storybord = [UIStoryboard storyboardWithName:@"Mine" bundle:nil];
        UINavigationController *loginVC = [storybord instantiateViewControllerWithIdentifier:@"LoginStorybordId"];
        loginVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self.navigationController presentModalViewController:loginVC animated:YES];
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
