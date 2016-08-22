//
//  MyOrderSecondWaitJudgeViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/8/10.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MyOrderSecondWaitJudgeViewController.h"
#import "PersonalWaitJudgeTableViewCell.h"
#import "ProductJudgeViewController.h"
#import "UIViewController+HUD.h"
#import <MJRefresh/MJRefresh.h>
#import "MyAPI.h"
#import "Config.h"
#import "MineWaitJudgeModel.h"
@interface MyOrderSecondWaitJudgeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
   // UITableView * _tableView;
    NSMutableArray * dataSource;
    NSInteger page;
}

@end

@implementation MyOrderSecondWaitJudgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    page = 1;
    dataSource = [NSMutableArray array];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 100) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"PersonalWaitJudgeTableViewCell" bundle:nil] forCellReuseIdentifier:@"WaitJudgeId"];
    [self.view addSubview:_tableView];
    [self addRefresh];
    dataSource = [NSMutableArray array];
    [self loadData];

}

- (void)addRefresh
{
    __weak MyOrderSecondWaitJudgeViewController * weakself = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        page = 1;
        
        if (KToken) {
            [weakself loadData];
        }else{
            [_tableView.mj_header endRefreshing];
            [_tableView.mj_footer endRefreshing];
            [self logOut];
        }
        
    }];
    
    MJRefreshAutoNormalFooter * footerRefresh = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page++;
        if (KToken) {
            [weakself loadData];
        }else{
            [_tableView.mj_header endRefreshing];
            [_tableView.mj_footer endRefreshing];
            [self logOut];
        }
    }];
    footerRefresh.automaticallyRefresh = NO;
    self.tableView.mj_footer = footerRefresh;
}

- (void)loadData
{

        NSString * pagestr = [NSString stringWithFormat:@"%ld",page];
        
        [[MyAPI sharedAPI] requestWaitjudgeDataWithParameters:pagestr
                                                       result:^(BOOL success, NSString *msg, NSMutableArray *arrays) {
                                                           
                                                           if(success){
                                                               if(page == 1){
                                                                   if(dataSource.count>0){
                                                                       [dataSource removeAllObjects];
                                                                   }
                                                               }
                                                               [dataSource addObjectsFromArray:arrays];
                                                               [_tableView reloadData];
                                                               [_tableView.mj_header endRefreshing];
                                                               [_tableView.mj_footer endRefreshing];
                                                           }else{
                                                               if([msg isEqualToString:@"-1"]){
                                                                   [self logOut];
                                                               }else{
                                                                   //[self showHint:msg];
                                                                   if([msg isEqualToString:@"0"]&&page==1){
                                                                       [dataSource removeAllObjects];
                                                                       [_tableView reloadData];
                                                                       [_tableView.mj_header endRefreshing];
                                                                   }else{
                                                                       
                                                                       [_tableView.mj_header endRefreshing];
                                                                       [_tableView.mj_footer endRefreshingWithNoMoreData];
                                                                   }
                                                               }
                                                           }
                                                       } errorResult:^(NSError *enginerError) {
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
    __weak MyOrderSecondWaitJudgeViewController * weakself = self;
    cell.model = model;
    cell.block = ^(NSIndexPath * cellindexpath){
        cellindexpath = indexPath;
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
    VC.deleteblock = ^(NSIndexPath *indexpath){
        NSInteger index = indexpath.section;
        [dataSource removeObjectAtIndex:index];
        [_tableView reloadData];
        
    };
    VC.uid = model.goodsid;
    VC.image = model.image;
    VC.ustyle = model.goodstyle;
    VC.ordernum = model.ordernum;
    VC.indexpath = indexpath;
    VC.index = indexpath.section;
    NSLog(@"%ld",VC.index);
    [self.navigationController pushViewController:VC animated:YES];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
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
