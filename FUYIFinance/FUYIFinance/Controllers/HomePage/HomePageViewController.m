//
//  HomePageViewController.m
//  FUYIFinance
//
//  Created by youyou on 16/6/16.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "HomePageViewController.h"
#import "SDCycleScrollView.h"
#import <MJRefresh.h>

//views
#import "HomePageNavgationItem.h"
#import "HomepageHeaderTableViewCell.h"
#import "HomePageHotNewTableViewCell.h"
#import "InvestCollectionViewTableViewCell.h"

//models
#import "HomepageBannerModel.h"
#import "HomePageNoticeModel.h"
#import "HomePageInvestModel.h"

#import "VideoShopViewController.h"

#define DEF_SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

static NSString *headerCellReuseId = @"headerCellReuseId";
static NSString *hotCellReuseId = @"hotCellReuseId";
static NSString *investReuseId = @"investReuseId";

@interface HomePageViewController ()<UITableViewDelegate,
                                     UITableViewDataSource,
                                     SDCycleScrollViewDelegate>
{
    SDCycleScrollView *_headerView;
    NSMutableArray *bannerData;//滚动视图数据
    NSMutableArray *inverstData;//投资项目数据
    NSMutableArray *noticeData;//富谊头条数据
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    inverstData = [NSMutableArray array];
    noticeData = [NSMutableArray array];
    bannerData = [NSMutableArray array];
    [self addTap];
    [self addRefresh];
    [self loadData];
    [self createUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - PrivateMethod
- (void)addRefresh{
    //添加刷新
    __weak HomePageViewController *weakself = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (bannerData.count > 0) {
            [bannerData removeAllObjects];
        }
        if (noticeData.count > 0) {
            [noticeData removeAllObjects];
        }
        if (inverstData.count > 0) {
            [inverstData removeAllObjects];
        }
        [weakself loadData];
    }];
}
- (void)addTap{
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapAct:)];
    [self.tableView addGestureRecognizer:tapGes];
    
}
- (void)TapAct:(UIGestureRecognizer *)ges{
    [Tools hideKeyBoard];
}
- (void)loadData{
    [inverstData addObject:@"finance_planer"];
    [[MyAPI sharedAPI] homePageWithResult:^(BOOL success, NSString *msg, NSMutableArray *arrays) {
        if (success) {
            [bannerData addObjectsFromArray: arrays[0]];
            [noticeData addObjectsFromArray: arrays[1]];
            [inverstData addObjectsFromArray:arrays[2]];
            //添加滚动视图pageview
            [self addPageControl];
            [self.tableView reloadData];
        }else{
            
        }
        [self.tableView.mj_header endRefreshing];
    } errorResult:^(NSError *enginerError) {
        
        [self.tableView.mj_header endRefreshing];

    }];
}
- (void)createUI{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
     self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView registerClass:[InvestCollectionViewTableViewCell class] forCellReuseIdentifier:investReuseId];
    //添加自定义导航栏
    [self addCustomerNavgationItem];

}
- (void)addPageControl{

   NSMutableArray *imageData = [NSMutableArray array];
    if (bannerData.count > 0) {
        for (HomepageBannerModel *model in bannerData) {
            [imageData addObject:model.bannerImgurl];
        }
    }
    _headerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0,ScreenWidth,170) imageURLStringsGroup:imageData];
    _headerView.delegate = self;
}
- (void)addCustomerNavgationItem{
    HomePageNavgationItem *navItem = [[[NSBundle mainBundle] loadNibNamed:@"HomePageNavgationItem" owner:self options:nil] lastObject];
    navItem.frame = CGRectMake(0, 0,ScreenWidth, 64);
    //点击消息按钮
    navItem.messageBlock = ^(){
        
    };
    //点击搜索
    navItem.searchResultBlock = ^(NSString *resutText){
        
    };
    [self.view addSubview:navItem];
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell ;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            HomepageHeaderTableViewCell *headerCell = [tableView dequeueReusableCellWithIdentifier:headerCellReuseId];
            if (headerCell == nil) {
                headerCell = [[[NSBundle mainBundle] loadNibNamed:@"HomepageHeaderTableViewCell" owner:self options:nil] lastObject];
            }
            headerCell.teachTeamBlock = ^{//讲师团队
                
            };
            headerCell.videoShopBolck = ^{//视频商城
           
            [self performSegueWithIdentifier:@"VideoStoreSegue" sender:nil];
            };
            headerCell.blogAreaBlock = ^{//博客专区
                
            };
            headerCell.financeBlock = ^{//金融学院
                
            };
           // headerCell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
            return headerCell;

        }else{
            HomePageHotNewTableViewCell *newTableViewCell = [tableView dequeueReusableCellWithIdentifier:hotCellReuseId];
            if (newTableViewCell == nil) {
                newTableViewCell = [[[NSBundle mainBundle] loadNibNamed:@"HomePageHotNewTableViewCell" owner:self options:nil] lastObject];
            }
            [newTableViewCell configWithData:noticeData];
            return newTableViewCell;
        }

    }else if (indexPath.section == 1){
        InvestCollectionViewTableViewCell *investTableViewCell = [tableView dequeueReusableCellWithIdentifier:investReuseId];
        if (investTableViewCell == nil) {
            investTableViewCell = [[InvestCollectionViewTableViewCell alloc]
                                                            initWithStyle:UITableViewCellStyleDefault
                                                            reuseIdentifier:investReuseId];

        }
        if (inverstData.count > 1) {
            [investTableViewCell createUIWithData:inverstData];
        }
        investTableViewCell.tapInvestCellBlock = ^(NSInteger index){
            
        };
        return investTableViewCell;
    }
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return _headerView;
    }else{
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, 10)];
        bgView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
        return bgView;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 170;
    }else{
        return 10;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 90;
        }else if (indexPath.row == 1){
            return 68;
        }
    }else if (indexPath.section == 1){
        return 205;
    }
    return 1;
}
#pragma mark -SDCycleScrollViewDelegate
//点击头部滚动视图
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - UIVew
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [Tools hideKeyBoard];
}
@end
