//
//  MyCollectionCourseViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/6/29.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MyCollectionCourseViewController.h"
#import "VideoDetailViewController.h"
#import "MyCollectionTableViewCell.h"
#import "MineCollectionTreasureModel.h"
#import "StoreDataModel.h"
#import "UIViewController+HUD.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <MJRefresh/MJRefresh.h>
#import "MyAPI.h"

@interface MyCollectionCourseViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
    NSMutableArray * dataSource;
    NSInteger page;
}
@end

@implementation MyCollectionCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    page = 1;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 100) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    dataSource = [NSMutableArray array];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"MyCollectionTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyCollectionId"];
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
    __weak MyCollectionCourseViewController* weakself = self;
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


//加载数据
- (void)loadData
{
    [self showHudInView:self.view hint:@"正在加载中"];
    NSString * pagestr = [NSString stringWithFormat:@"%ld",page];
    [[MyAPI sharedAPI] requestCollectionTreasureDataWithParameters:pagestr
                                                            result:^(BOOL success, NSString *msg, NSMutableArray *arrays) {

        if(success){
          
            for(MineCollectionTreasureModel * model in arrays){
                [dataSource addObject:model];
            }
            
            [self hideHud];
            [_tableView reloadData];
            [_tableView.mj_header endRefreshing];
            [_tableView.mj_footer endRefreshing];

        }else{
            [self hideHud];
            [_tableView.mj_header endRefreshing];
            [_tableView.mj_footer endRefreshing];
            if([msg isEqualToString:@"-1"]){
                [self logOut];
            }
           
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 107;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyCollectionId" forIndexPath:indexPath];
    MineCollectionTreasureModel * model = [[MineCollectionTreasureModel alloc] init];
    model = dataSource[indexPath.section];
    [cell.thumbimage sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"myorderthumbimage"]];
    cell.titlename.text = model.name;
    NSString * teachername = [NSString stringWithFormat:@"讲师:%@",model.teacher];
    cell.teachername.text = teachername;
    NSString * pricelabel = [NSString stringWithFormat:@"¥ %@",model.price];
    NSString * price = [NSString stringWithFormat:@"%@",pricelabel];
    cell.pricelabel.text = price;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineCollectionTreasureModel * model =[[MineCollectionTreasureModel alloc] init];
    model = dataSource[indexPath.section];
    StoreDataModel * model1 = [[StoreDataModel alloc] initWithParameters:model.goodsid
                                                               videoName:model.name
                                                             teacherName:model.teacher videoImage:model.image videoPrice:model.price sellNum:model.num videodescription:model.about teacherId:model.tid videoType:model.type videoCollect:model.collection cart:model.cart];
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"HomePage" bundle:nil];
    
    VideoDetailViewController * vc =[storyboard instantiateViewControllerWithIdentifier:@"VideoShopStoryBoardID"];
    vc.model = model1;
    [self.navigationController pushViewController:vc animated:YES];
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
