//
//  MyOrderViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/6/28.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MyOrderViewController.h"
#import "YSLContainerViewController.h"
#import "MyOrderAllViewController.h"
#import "MyOrderWaitPayViewController.h"
#import "MyOrderWaitGoodViewController.h"
#import "MyOrderWaitJudgeViewController.h"

@interface MyOrderViewController ()<YSLContainerViewControllerDelegate>

@end

@implementation MyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navigationController.navigationBar.hidden = NO;
//    self.navigationController.navigationBar.translucent = NO;
    MyOrderAllViewController * myOrderAllVC = [[MyOrderAllViewController alloc] init];
    myOrderAllVC.title = @"全部";
    
    MyOrderWaitPayViewController * myOrderWaitPayVC = [[MyOrderWaitPayViewController alloc] init];
    myOrderWaitPayVC.title = @"待付款";
    
    MyOrderWaitGoodViewController * myOrderWaitGoodVC = [[MyOrderWaitGoodViewController alloc] init];
    myOrderWaitGoodVC.title = @"待收货";
    
    MyOrderWaitJudgeViewController * myOrderWaitJudgeVC = [[MyOrderWaitJudgeViewController alloc] init];
    myOrderWaitJudgeVC.title = @"待评价";
    
    float statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    float navigationHeight = self.navigationController.navigationBar.frame.size.height;
    
    YSLContainerViewController *containerVC = [[YSLContainerViewController alloc]initWithControllers:@[myOrderAllVC,myOrderWaitPayVC,myOrderWaitGoodVC,myOrderWaitJudgeVC]
                                                                                        topBarHeight:statusHeight + navigationHeight
                                                                                parentViewController:self];
    containerVC.delegate = self;

    containerVC.menuItemFont = [UIFont systemFontOfSize:16];
    
    [self.view addSubview:containerVC.view];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)containerViewItemIndex:(NSInteger)index currentController:(UIViewController *)controller
{
    //    NSLog(@"current Index : %ld",(long)index);
    //    NSLog(@"current controller : %@",controller);
    [controller viewWillAppear:YES];
}

- (IBAction)back:(id)sender {
    self.navigationController.navigationBar.hidden = YES;
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
