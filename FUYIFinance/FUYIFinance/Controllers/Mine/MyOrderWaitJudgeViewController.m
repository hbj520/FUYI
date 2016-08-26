//
//  MyOrderWaitJudgeViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/6/28.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MyOrderWaitJudgeViewController.h"
#import "MineGoodsJudgeTableViewController.h"
#import "PersonalWaitJudgeTableViewCell.h"
#import "ProductJudgeViewController.h"
#import "UIViewController+HUD.h"
#import <MJRefresh/MJRefresh.h>
#import "MyAPI.h"
#import "Config.h"
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
    _tableView.mj_footer = footerRefresh;
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
                                                                   [_tableView.mj_header endRefreshing];
                                                                   [_tableView.mj_footer endRefreshingWithNoMoreData];
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
    __weak MyOrderWaitJudgeViewController * weakself = self;
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
    MineGoodsJudgeTableViewController * VC1 = (MineGoodsJudgeTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"GoodJudgeStoryBoardID"];
    VC1.uid = model.goodsid;
    VC1.image = model.image;
    VC1.ustyle = model.goodstyle;
    VC1.ordernum = model.ordernum;
    VC1.indexpath = indexpath;
    VC1.index = indexpath.section;
    VC1.goodsname = model.name;
    VC1.teachname = model.teacher;
    VC1.goodsprice = model.price;
    VC1.deleteblock = ^(NSIndexPath * indexpath){
        NSInteger index = indexpath.section;
        [dataSource removeObjectAtIndex:index];
        [_tableView reloadData];
    };

    [self.navigationController pushViewController:VC1 animated:YES];
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
