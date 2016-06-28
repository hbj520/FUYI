//
//  ShopCarViewController.m
//  FUYIFinance
//
//  Created by youyou on 16/6/28.
//  Copyright © 2016年 youyou. All rights reserved.
//

//view
#import "ShopCarNavigationItem.h"
#import "ShopCarBottomView.h"

#import "ShopCarViewController.h"

@interface ShopCarViewController ()//<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ShopCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatUI];
}

-(void)creatUI
{
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
    [self addCustomerNavigationItem];
    [self addBottomView];
}

-(void)addBottomView
{
    ShopCarBottomView *bottomView = [[[NSBundle mainBundle]loadNibNamed:@"ShopCarBottomView" owner:self options:nil]lastObject];
    bottomView.frame = CGRectMake(0, ScreenHeight-88,ScreenWidth, 44);
    [self.view addSubview:bottomView];
}

-(void)addCustomerNavigationItem
{
    ShopCarNavigationItem *navItem = [[[NSBundle mainBundle]loadNibNamed:@"ShopCarNavigationItem" owner:self options:nil]lastObject];
    navItem.backgroundColor = RGBACOLOR(244,244,244,1);
    navItem.frame = CGRectMake(0, 0,ScreenWidth, 64);
    //消息按钮
    navItem.messageBlock = ^(){
        
    };
    [self.view addSubview:navItem];
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
