//
//  MyOrderFlowAllViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/8/23.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MyOrderFlowAllViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <MJRefresh/MJRefresh.h>
#import "TeachOrderAllTableViewCell.h"
#import "OrderManageModel.h"
#import "LabelHelper.h"
#import "Config.h"
#import "MyAPI.h"
@interface MyOrderFlowAllViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
    NSMutableArray * dataSource;
    NSInteger page;
}
@end

@implementation MyOrderFlowAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dataSource = [NSMutableArray array];
    page = 1;
    [self createUI];
    [self loadData];
    [self addRefresh];
}

- (void)addRefresh
{
    __weak MyOrderFlowAllViewController * weakself = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        page = 1;
        [weakself loadData];
        
    }];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page++;
        [weakself loadData];
    }];
    
}


//加载数据
- (void)loadData
{
    NSString * pagestr = [NSString stringWithFormat:@"%ld",page];
    [[MyAPI sharedAPI] getOrderFlowDataWithIdentify:@"1"
                                               Page:pagestr Result:^(BOOL success, NSString *msg, NSMutableArray *arrays) {
        if(success){
            if(page == 1){
                [dataSource removeAllObjects];
            }
            [dataSource addObjectsFromArray:arrays];
            [_tableView reloadData];
            [_tableView.mj_header endRefreshing];
            [_tableView.mj_footer endRefreshing];
        }
    } ErrorResult:^(NSError *enginerError) {
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    }];
}

//搭建视图
- (void)createUI
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-100) style:UITableViewStylePlain];
    [_tableView registerNib:[UINib nibWithNibName:@"TeachOrderAllTableViewCell" bundle:nil] forCellReuseIdentifier:@"TeachAllCellID"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}


#pragma mark -UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellID = @"TeachAllCellID";
    TeachOrderAllTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    OrderManageModel * model = [[OrderManageModel alloc] init];
    model = dataSource[indexPath.section];
    [cell.thumbImg sd_setImageWithURL:[NSURL URLWithString:model.goodsimg] placeholderImage:[UIImage imageNamed:@"myorderthumbimage"]];
    cell.name.text = model.goodsname;
    cell.price.text = [NSString stringWithFormat:@"¥%@",model.money];
    NSString * teacher = [[Config Instance] getUserName];
    cell.teahname.text = [NSString stringWithFormat:@"讲师：%@",teacher];
    NSMutableAttributedString * str = [[LabelHelper alloc] attributedStringWithString:[NSString stringWithFormat:@"¥%@",model.money]];
    cell.totalprice.attributedText = str;
    cell.dealtime.text = [NSString stringWithFormat:@"交易时间：%@",model.ctime];
    return cell;
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
