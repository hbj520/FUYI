//
//  TreasureManageViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/6/30.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "TreasureManageViewController.h"
#import "ManageTreasureTableViewController.h"
#import "BBBadgeBarButtonItem.h"
#import "UIViewController+HUD.h"
#import "LoveManageTableViewCell.h"
#import <MJRefresh/MJRefresh.h>
#import "ManageTreasureModel.h"
#import "MyAPI.h"
@interface TreasureManageViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    NSIndexPath * indexpath;
    BBBadgeBarButtonItem * _chatBtn;  //自定义的导航栏按钮
    BBBadgeBarButtonItem * _chatBtn1; //自定义的导航栏按钮
    NSMutableArray * dataSource;
    NSInteger page;
}
@end

@implementation TreasureManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addChatBtn];
    page = 1;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"LoveManageTableViewCell" bundle:nil] forCellReuseIdentifier:@"TreasureId"];
    [self.view addSubview:_tableView];
    [self addRefresh];
    dataSource = [NSMutableArray array];
    [self loadData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:@"loadTreasureManageView" object:nil];
    
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"loadTreasureManageView" object:nil];
}

#pragma mark -PRIVATEMETHOD
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    if(self.isGoodsSetting){
        self.navigationItem.title = @"宝贝管理";
    }else{
        self.navigationItem.title = @"宝贝管理";
    }
    
}

- (void)loadData
{
    NSString * pageStr = [NSString stringWithFormat:@"%ld",page];
    [[MyAPI sharedAPI] RequestManageTreasureDataWithPage:pageStr result:^(BOOL success, NSString *msg, NSMutableArray *arrays) {
        if(success){
            dataSource = arrays;
            [_tableView reloadData];
        }
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    } errorResult:^(NSError *enginerError) {
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    }];
}

- (void)addRefresh
{
    __weak TreasureManageViewController * weakself = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [weakself loadData];
    }];
    MJRefreshAutoNormalFooter * footerRefresh = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page++;
        [weakself loadData];
    }];
    footerRefresh.automaticallyRefresh = NO;
    _tableView.mj_footer = footerRefresh;
}

- (void)addChatBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 31, 27);
    [btn setImage:[UIImage imageNamed:@"messageBtn"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(chatAct:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 0, 20, 20);
    [btn1 setImage:[UIImage imageNamed:@"barimage"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(clickBtn1) forControlEvents:UIControlEventTouchUpInside];
    
    _chatBtn = [[BBBadgeBarButtonItem alloc] initWithCustomUIButton:btn];
    _chatBtn.badgeFont = [UIFont systemFontOfSize:10.0f];
    _chatBtn.badgeOriginX = 15.5;
    _chatBtn.badgeOriginY = -2.5;
    _chatBtn.badgePadding = 2;
    _chatBtn.badgeValue = @"0";
    
    _chatBtn1 = [[BBBadgeBarButtonItem alloc] initWithCustomUIButton:btn1];
    _chatBtn1.badgeFont = [UIFont systemFontOfSize:10.0f];
    _chatBtn1.badgeOriginX = 15.5;
    _chatBtn1.badgeOriginY = -2.5;
    _chatBtn1.badgePadding = 2;
    _chatBtn1.badgeValue = @"0";
    
    NSMutableArray *arryBtn = [NSMutableArray arrayWithObjects:_chatBtn,_chatBtn1, nil];
    self.navigationItem.rightBarButtonItems = arryBtn;
}

//点击消息
- (void)chatAct:(id)sender{
    
}

//点击环状
- (void)clickBtn1
{
    [_tableView.mj_header beginRefreshing];
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
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LoveManageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TreasureId" forIndexPath:indexPath];
    cell.modifyBtn.tag = indexPath.section;
    [cell.modifyBtn addTarget:self action:@selector(clickmodifyBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.deleteBtn.tag = 100 + indexPath.section;
    [cell.deleteBtn addTarget:self action:@selector(clickdeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    ManageTreasureModel * model = [[ManageTreasureModel alloc] init];
    model = dataSource[indexPath.section];
    cell.model = model;
    return cell;
}

//点击编辑宝贝按钮
- (void)clickmodifyBtn:(UIButton*)sender
{
    //跳转到编辑宝贝
    NSInteger index = sender.tag;
    ManageTreasureModel * model = dataSource[index];
    NSString * imageStr = [NSString stringWithFormat:@"http://60.173.235.34:9090/fuyi//%@",model.thumbimg];
    NSArray * arr = @[model.goodsid,model.price,model.title,imageStr];
    [self performSegueWithIdentifier:@"modifySegue" sender:arr];
}

//点击删除宝贝按钮
- (void)clickdeleteBtn:(UIButton*)sender
{
    NSInteger index = sender.tag - 100;
    ManageTreasureModel * model = dataSource[index];
    
    [[MyAPI sharedAPI] DeleteTreasureWithTreasureid:model.goodsid result:^(BOOL sucess, NSString *msg) {
        if(sucess){
            [self showHint:@"删除成功"];
            [self loadData];
        }
    } errorResult:^(NSError *enginerError) {
        
    }];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



//退回到上级界面
- (IBAction)back:(id)sender {
   
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"modifySegue"]){
        ManageTreasureTableViewController * vc = segue.destinationViewController;
        vc.array = sender;
    }
}


@end
