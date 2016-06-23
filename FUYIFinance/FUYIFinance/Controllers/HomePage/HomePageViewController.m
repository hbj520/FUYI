//
//  HomePageViewController.m
//  FUYIFinance
//
//  Created by youyou on 16/6/16.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "HomePageViewController.h"

//views
#import "HomePageNavgationItem.h"

@interface HomePageViewController ()

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - PrivateMethod
- (void)createUI{
    //添加自定义导航栏
    [self addCustomerNavgationItem];

    
}
- (void)addCustomerNavgationItem{
    HomePageNavgationItem *navItem = [[[NSBundle mainBundle] loadNibNamed:@"HomePageNavgationItem" owner:self options:nil] lastObject];
    navItem.frame = CGRectMake(0, 0,ScreenWidth, 64);
    //点击消息按钮
    navItem.messageBlock = ^(){
        
        
    };
    //点击搜索
    navItem.searchResultBlock = ^(NSString *resutText){
        
    };
    [self.view addSubview:navItem];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - UIVew
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [Tools hideKeyBoard];
}
@end
