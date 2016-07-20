//
//  MyOrderWaitJudgeViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/6/28.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MyOrderWaitJudgeViewController.h"
#import "PersonalWaitJudgeTableViewCell.h"
#import "ProductJudgeViewController.h"
#import "UIViewController+HUD.h"
#import <MJRefresh/MJRefresh.h>
#import "MyAPI.h"
#import "MineWaitJudgeModel.h"

@interface MyOrderWaitJudgeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    NSMutableArray * dataSource;
    NSInteger page;
}
@end

@implementation MyOrderWaitJudgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    page = 1;
    dataSource = [NSMutableArray array];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [_tableView registerNib:[UINib nibWithNibName:@"PersonalWaitJudgeTableViewCell" bundle:nil] forCellReuseIdentifier:@"WaitJudgeId"];
    [self.view addSubview:_tableView];
    [self addRefresh];
    dataSource = [NSMutableArray array];
    [self loadData];
}

- (void)addRefresh
{
    __weak MyOrderWaitJudgeViewController * weakself = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        page = 1;
        if(dataSource.count>0){
            [dataSource removeAllObjects];
        }
        [weakself loadData];
        
    }];
    MJRefreshAutoNormalFooter * footerRefresh = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page++;
        [weakself loadData];
    }];
    footerRefresh.automaticallyRefresh = NO;
    _tableView.mj_footer = footerRefresh;
}



- (void)loadData
{
    NSString * pagestr = [NSString stringWithFormat:@"%ld",page];
    [self showHudInView:self.view hint:@"正在加载中"];
[[MyAPI sharedAPI] requestWaitjudgeDataWithParameters:pagestr result:^(BOOL success, NSString *msg, NSMutableArray *arrays) {
    if([msg isEqualToString:@"-1"]){
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        [self hideHud];
        [self logOut];
    }
    if(success){
        [dataSource addObjectsFromArray:arrays];
        [_tableView reloadData];
        [self hideHud];
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];

    
    }else{
        [self hideHud];
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];

    }
} errorResult:^(NSError *enginerError) {
    [self hideHud];
    [_tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshing];

}];
    
}

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
    
        return 218;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonalWaitJudgeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WaitJudgeId" forIndexPath:indexPath];
    cell.judgeBtn.tag = indexPath.section;   //给评价按钮绑定tag值
    //给评价按钮添加响应事件方法
    MineWaitJudgeModel * model = [[MineWaitJudgeModel alloc] init];
    model = dataSource[indexPath.section];
    __weak MyOrderWaitJudgeViewController * weakself = self;
    cell.model = model;
    cell.block = ^(NSIndexPath * cellindexpath){
        [weakself clickjudgeBtnWithIndexpath:cellindexpath];
    };
        return cell;
}

//点击评价按钮的事件响应方法
- (void)clickjudgeBtnWithIndexpath:(NSIndexPath *)indexpath
{
    //跳转到商品评价界面
    MineWaitJudgeModel * model = dataSource[indexpath.section];
    
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Mine" bundle:nil];
    ProductJudgeViewController * VC = (ProductJudgeViewController*)[storyboard instantiateViewControllerWithIdentifier:@"productJudge"];
    VC.uid = model.goodsid;
    VC.ustyle = model.goodstyle;
    NSInteger indx = indexpath.section;
    VC.indx = indx;
    [self.navigationController pushViewController:VC animated:YES];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
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
