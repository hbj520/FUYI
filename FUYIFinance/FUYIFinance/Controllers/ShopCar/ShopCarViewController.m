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
#import "shopCarCell.h"
#import "videoHeaderView.h"

#import "ShopCarViewController.h"

//static NSString *videoHeader = @"videoHeaderReuseId";



@interface ShopCarViewController ()<UITableViewDelegate,UITableViewDataSource>

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
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //self.tableView.frame = CGRectMake(0, 100, ScreenWidth, ScreenHeight-108);
    [self.tableView registerNib:[UINib nibWithNibName:@"shopCarCell" bundle:nil] forCellReuseIdentifier:@"shopCarCellReuseID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"videoHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"videoHeaderReuseId"];
    self.tableView.rowHeight = 127;
    //导航栏
    [self addCustomerNavigationItem];
    //底部结算View
    [self addBottomView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    shopCarCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shopCarCellReuseID" forIndexPath:indexPath];
    
    return cell;

}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    videoHeaderView* headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"videoHeaderReuseId"];
    return headerView;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 51;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    view.backgroundColor = RGBACOLOR(235, 235, 235, 1);
    return view;
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
