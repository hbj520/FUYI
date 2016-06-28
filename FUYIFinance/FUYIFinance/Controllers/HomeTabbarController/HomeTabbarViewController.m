//
//  HomeTabbarViewController.m
//  FUYIFinance
//
//  Created by youyou on 16/6/14.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "HomeTabbarViewController.h"
#import "HexColor.h"

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
    menusVCs = [NSMutableArray array];
    self.tabBar.tintColor = [UIColor colorWith8BitRed:232 green:59 blue:62]
    ;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"HomeTabbars" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSArray *array = dict[@"tabBarMenus"];
    for (NSDictionary *dic in array) {
        UITabBarItem *tabbarItem = [[UITabBarItem alloc] init];
        [tabbarItem setImage:[UIImage imageNamed:dic[@"image"]]];
        [tabbarItem setSelectedImage:[UIImage imageNamed:dic[@"select_image"]]];
        [tabbarItem setTitle:dic[@"title"]];
        SEL selector = NSSelectorFromString(dic[@"storybordId"]);
        IMP imp = [self methodForSelector:selector];
        UIStoryboard * (*func)(id,SEL) = (void *)imp;
        UIStoryboard *sb = func(self,selector);
        UIViewController *vc = [sb instantiateInitialViewController];
        vc.tabBarItem = tabbarItem;
        [menusVCs addObject:vc];
    }
    self.viewControllers = menusVCs;
    
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