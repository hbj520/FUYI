//
//  MyOrderMyCollectionViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/6/29.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MyOrderMyCollectionViewController.h"
#import "BBBadgeBarButtonItem.h"
#import "YSLContainerViewController.h"
#import "MyCollectionCourseViewController.h"
#import "MyCollectionShopViewController.h"

@interface MyOrderMyCollectionViewController ()<YSLContainerViewControllerDelegate>
{
    BBBadgeBarButtonItem * _chatBtn;
}
@end

@implementation MyOrderMyCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addChatBtn];
    MyCollectionCourseViewController * MyCollectionCourseVC = [[MyCollectionCourseViewController alloc] init];
    MyCollectionCourseVC.title = @"收藏的课程";
    
    MyCollectionShopViewController * MyCollectionShopVC = [[MyCollectionShopViewController alloc] init];
    MyCollectionShopVC.title = @"  收藏的店铺";
    
    float statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    float navigationHeight = self.navigationController.navigationBar.frame.size.height;
    
    YSLContainerViewController *containerVC = [[YSLContainerViewController alloc]initWithControllers:@[MyCollectionCourseVC,MyCollectionShopVC]
                                                                                        topBarHeight:statusHeight + navigationHeight
                                                                                parentViewController:self];
    containerVC.delegate = self;
    
    containerVC.menuItemFont = [UIFont systemFontOfSize:16];
    
    [self.view addSubview:containerVC.view];

    
}

- (void)containerViewItemIndex:(NSInteger)index currentController:(UIViewController *)controller
{
    //    NSLog(@"current Index : %ld",(long)index);
    //    NSLog(@"current controller : %@",controller);
    [controller viewWillAppear:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

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

- (void)chatAct:(id)sender{
    
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
