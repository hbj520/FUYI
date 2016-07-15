//
//  MyOrderViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/6/28.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MyOrderViewController.h"
#import "BBBadgeBarButtonItem.h"
#import "YSLContainerViewController.h"
#import "MyOrderAllViewController.h"
#import "MyOrderWaitPayViewController.h"
#import "MyOrderSecondWaitPayViewController.h"
#import "MyOrderWaitGoodViewController.h"
#import "MyOrderWaitJudgeViewController.h"

@interface MyOrderViewController ()<YSLContainerViewControllerDelegate>
{
    BBBadgeBarButtonItem * _chatBtn; //自定义导航栏按钮
}
@end

@implementation MyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navigationController.navigationBar.hidden = NO;
//    self.navigationController.navigationBar.translucent = NO;
    [self addChatBtn];   //添加自定义导航栏按钮
    //创建全部界面
    MyOrderAllViewController * myOrderAllVC = [[MyOrderAllViewController alloc] init];
    myOrderAllVC.title = @"全部";
    
    //创建待付款界面
    MyOrderSecondWaitPayViewController * myOrderWaitPayVC = [[MyOrderSecondWaitPayViewController alloc] init];
    myOrderWaitPayVC.title = @"待付款";
    
    //创建待收货界面
    MyOrderWaitGoodViewController * myOrderWaitGoodVC = [[MyOrderWaitGoodViewController alloc] init];
    myOrderWaitGoodVC.title = @"待收货";
    
    //创建待评价界面
    MyOrderWaitJudgeViewController * myOrderWaitJudgeVC = [[MyOrderWaitJudgeViewController alloc] init];
    myOrderWaitJudgeVC.title = @"待评价";
    
    float statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    float navigationHeight = self.navigationController.navigationBar.frame.size.height;
    
    YSLContainerViewController *containerVC = [[YSLContainerViewController alloc]initWithControllers:@[myOrderAllVC,myOrderWaitPayVC,myOrderWaitGoodVC,myOrderWaitJudgeVC]
                                                                                        topBarHeight:statusHeight + navigationHeight
                                                                                parentViewController:self];
    containerVC.delegate = self;
    containerVC.menuItemFont = [UIFont systemFontOfSize:13];
    containerVC.menuItemTitleColor = [UIColor darkGrayColor];
       
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

//添加自定义导航栏按钮
- (void)addChatBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 31, 27);
    [btn setImage:[UIImage imageNamed:@"messageBtn"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(chatAct:) forControlEvents:UIControlEventTouchUpInside];
    _chatBtn = [[BBBadgeBarButtonItem alloc] initWithCustomUIButton:btn];
    _chatBtn.badgeFont = [UIFont systemFontOfSize:10.0f];
    _chatBtn.badgeOriginX = 15.5;
    _chatBtn.badgeOriginY = -2.5;
    _chatBtn.badgePadding = 2;
    _chatBtn.badgeValue = @"0";
    
    NSMutableArray *arryBtn = [NSMutableArray arrayWithObjects:_chatBtn, nil];
    self.navigationItem.rightBarButtonItems = arryBtn;
}

//自定义导航栏按钮的事件响应方法
- (void)chatAct:(id)sender{
    
}

//退回到上级界面
- (IBAction)back:(id)sender {
    self.navigationController.navigationBarHidden = YES;
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
