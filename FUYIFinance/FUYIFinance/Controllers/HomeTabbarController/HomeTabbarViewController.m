//
//  HomeTabbarViewController.m
//  FUYIFinance
//
//  Created by youyou on 16/6/14.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "HomeTabbarViewController.h"

@interface HomeTabbarViewController ()
{
    NSArray *titleArrays;
    NSMutableArray *menusVCs;//tabbars的控制器
}
@property (nonatomic,strong) UIStoryboard *homePageSB;
@property (nonatomic,strong) UIStoryboard *customerServiceSB;
@property (nonatomic,strong) UIStoryboard *shopCarSB;
@property (nonatomic,strong) UIStoryboard *mineSB;
@end

@implementation HomeTabbarViewController
- (UIStoryboard *)homePageSB{
    if (!_homePageSB) {
        _homePageSB = [UIStoryboard storyboardWithName:@"HomePage" bundle:[NSBundle mainBundle]];
    }
    return _homePageSB;
}
- (UIStoryboard *)customerServiceSB{
    if (!_customerServiceSB) {
        _customerServiceSB = [UIStoryboard storyboardWithName:@"CustomerService" bundle:[NSBundle mainBundle]];
    }
    return _customerServiceSB;
}
- (UIStoryboard *)shopCarSB{
    if (!_shopCarSB) {
        _shopCarSB = [UIStoryboard storyboardWithName:@"ShopCar" bundle:[NSBundle mainBundle]];
    }
   return _shopCarSB;
}
- (UIStoryboard *)mineSB{
    if (!_mineSB) {
        _mineSB = [UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]];
    }
   return _mineSB;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
