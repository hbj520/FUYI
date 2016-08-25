//
//  MyOrderFlowViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/8/23.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MyOrderFlowViewController.h"
#import "YSLContainerViewController.h"
#import "MyOrderFlowAllViewController.h"
#import "MyOrderFlowWaitPayViewController.h"

@interface MyOrderFlowViewController ()<YSLContainerViewControllerDelegate>
{
    YSLContainerViewController *containerVC;
}
@end

@implementation MyOrderFlowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUI];
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)createUI
{
    
    MyOrderFlowAllViewController * allVC = [[MyOrderFlowAllViewController alloc] init];
    allVC.title = @"全部";
    MyOrderFlowWaitPayViewController * waitVC = [[MyOrderFlowWaitPayViewController alloc] init];
    waitVC.title = @"待付款";
    float statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    float navigationHeight = self.navigationController.navigationBar.frame.size.height;
    
    containerVC = [[YSLContainerViewController alloc]initWithControllers:@[allVC,waitVC]
                                                            topBarHeight:statusHeight + navigationHeight
                                                    parentViewController:self];
    containerVC.delegate = self;
    containerVC.menuItemFont = [UIFont systemFontOfSize:13];
    containerVC.menuItemTitleColor = [UIColor darkGrayColor];
    
    [self.view addSubview:containerVC.view];
 
}

- (void)containerViewItemIndex:(NSInteger)index currentController:(UIViewController *)controller
{
    if (index == 0) {
        
        }else{
        
    }
}

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
