//
//  MyJudgeViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/6/29.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MyJudgeViewController.h"
#import "MyJudgeTableViewCell.h"
#import "BBBadgeBarButtonItem.h"
#import <MJRefresh/MJRefresh.h>
#import "MyAPI.h"
#import "MineMyJudgeModel.h"
@interface MyJudgeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    BBBadgeBarButtonItem *_chatBtn;//导航栏自定义按钮
    NSMutableArray * dataSource;
    NSInteger page;
}
@end

@implementation MyJudgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addChatBtn];
    if(!KToken){
        [self logOut];
    }
    dataSource = [NSMutableArray array];
    page = 1;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerNib:[UINib nibWithNibName:@"MyJudgeTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyJudgeId"];
    [self.view addSubview:_tableView];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshtableview) name:@"refreshView" object:nil];
    [self loadData];
    [self addRefresh];
    
}

- (void)refreshtableview
{
    [self loadData];
}

- (void)addRefresh
{
    __weak MyJudgeViewController * weakself = self;
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
    [[MyAPI sharedAPI] requestMyJudgeDataWithParameters:pagestr result:^(BOOL success, NSString *msg, NSMutableArray *arrays) {
        if([msg isEqualToString:@"-1"]){
            [self logOut];
            [_tableView.mj_header endRefreshing];
            [_tableView.mj_footer endRefreshing];
        }else{
            [_tableView.mj_header endRefreshing];
            [_tableView.mj_footer endRefreshing];
        }

        if(success){
        dataSource  = arrays;
        [_tableView reloadData];
            [_tableView.mj_header endRefreshing];
            [_tableView.mj_footer endRefreshing];
        }else{
            [_tableView.mj_header endRefreshing];
            [_tableView.mj_footer endRefreshing];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyJudgeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyJudgeId" forIndexPath:indexPath];
    MineMyJudgeModel * model = [[MineMyJudgeModel alloc] init];
    model = dataSource[indexPath.section];
    cell.model = model;
    return cell;
}


//添加导航栏按钮
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

//信息
- (void)chatAct:(id)sender{

}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

//返回上级页面
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
