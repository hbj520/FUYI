//
//  HomePageViewController.m
//  FUYIFinance
//
//  Created by youyou on 16/6/16.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "HomePageViewController.h"
#import "UIViewController+HUD.h"
#import "BlogViewController.h"
#import "HomePageDetailViewController.h"
#import "IJKMoviePlayerViewController.h"


#import "SDCycleScrollView.h"
#import "MJRefresh.h"
#import "Masonry.h"

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
#import "TeacherTeamViewController.h"

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
    IJKMoviePlayerViewController *playerVC;
    HomePageNavgationItem *navItem;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraintLayOut;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    inverstData = [NSMutableArray array];
    noticeData = [NSMutableArray array];
    bannerData = [NSMutableArray array];
    
  //  [self addTap];
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
#pragma mark -ViewLifeCycle
- (void)loadView{
    [super loadView];
}
#pragma mark - PrivateMethod
- (void)addRefresh{
    //添加刷新
    __weak HomePageViewController *weakself = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [playerVC removeFromParentViewController];
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
    [inverstData addObjectsFromArray:@[@"finance_planer",@"metal_invest",@"foreign_exchange",@"oil_invest",@"gold_invest"]];
    [[MyAPI sharedAPI] homePageWithResult:^(BOOL success, NSString *msg, NSMutableArray *arrays) {
        if (success) {
            [bannerData addObjectsFromArray: arrays[0]];
            NSArray * noticedata = arrays[1];
            NSMutableArray * titleArray = [NSMutableArray array];
            for(HomePageNoticeModel * model in noticedata){
                [titleArray addObject:model.noticeTitle];
            }
            NSInteger arrcount = noticedata.count;
            NSMutableArray * arr2 = [NSMutableArray array];
            for(NSInteger i = 0;i<arrcount/2;i++){
                //从一个可变数组中分割小数组
                NSArray * arr1 = [titleArray subarrayWithRange:NSMakeRange(i * 2, 2)];
                [arr2 addObject:arr1];
            }
            [noticeData addObjectsFromArray:arr2];
            //[inverstData addObjectsFromArray:arrays[2]];
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
- (void)setUpNoticeData:(NSArray *)noticeDatas{
    
    [noticeData addObjectsFromArray: @[@[@"第0组第一行",@"第0组第二行"],@[@"第一组第一行",@"第一组第二行"],@[@"第二组第一行",@"第二组第一行"],@[@"第3组第一行",@"第3组第二行"]]];
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
    if (bannerData.count > 0) {// 滚动视图
        for (HomepageBannerModel *model in bannerData) {
            [imageData addObject:model.bannerImgurl];
        }
    }
    _headerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0,ScreenWidth,170) imageURLStringsGroup:imageData];
    
    _headerView.delegate = self;
}
- (void)addCustomerNavgationItem{
    navItem = [[[NSBundle mainBundle] loadNibNamed:@"HomePageNavgationItem" owner:self options:nil] lastObject];
    navItem.frame = CGRectMake(0, 0,ScreenWidth, 64);
    //点击消息按钮
    navItem.messageBlock = ^(){
        
    };
    //点击搜索
    navItem.searchResultBlock = ^(NSString *resutText){
    
    };
    [self.view addSubview:navItem];
    [navItem mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@0);
//        make.top.equalTo(@0);
//        make.right.equalTo(@0);
//        make.height.equalTo(@64);
        make.left.top.right.mas_equalTo(0);
       make.height.mas_equalTo(64);
        
    }];
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;// 3个部分
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return 2; // 只有此部分为2行
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell ;
    if (indexPath.section == 0) {
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reusedId"];
        }
        return cell;
        
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            HomepageHeaderTableViewCell *headerCell = [tableView dequeueReusableCellWithIdentifier:headerCellReuseId];
            if (headerCell == nil) {
                headerCell = [[[NSBundle mainBundle] loadNibNamed:@"HomepageHeaderTableViewCell" owner:self options:nil] lastObject];
            }
            headerCell.teachTeamBlock = ^{//讲师团队
                if (KToken) {
                    [self performSegueWithIdentifier:@"TeacherTeamSegue" sender:nil];
                }else{
                    [self logOut];
                }
            };
            headerCell.videoShopBolck = ^{//视频商城
                
                [self performSegueWithIdentifier:@"VideoStoreSegue" sender:nil];
            };
            headerCell.blogAreaBlock = ^{//博客专区
                //跳转到博客专区--> 登入
                [self performSegueWithIdentifier:@"blogSegue" sender:nil];
            };
            headerCell.financeBlock = ^{//金融学院
                [self showHint:@"正在建设中"];
            };
            return headerCell;
            
        }else{
            HomePageHotNewTableViewCell *newTableViewCell = [tableView dequeueReusableCellWithIdentifier:hotCellReuseId];
            if (newTableViewCell == nil) {
                newTableViewCell = [[[NSBundle mainBundle] loadNibNamed:@"HomePageHotNewTableViewCell" owner:self options:nil] lastObject];
            }
            [newTableViewCell configWithData:noticeData];// 获取数据。
            newTableViewCell.block = ^(){
            // 跳转至百度
            [self performSegueWithIdentifier:@"homepagedetailSegue" sender:@"http://www.baidu.com"];
            };
            return newTableViewCell;
        }
    }else if (indexPath.section == 2){
        InvestCollectionViewTableViewCell *investTableViewCell = [tableView dequeueReusableCellWithIdentifier:investReuseId];
        investTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (investTableViewCell == nil) {
            investTableViewCell = [[InvestCollectionViewTableViewCell alloc]
                                   initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:investReuseId];
        }
        if (inverstData.count > 1) {
            [investTableViewCell createUIWithData:inverstData];
        }
        investTableViewCell.tapInvestCellBlock = ^(NSInteger index){
            [self performSegueWithIdentifier:@"VideoStoreSegue" sender:nil];
//            if (index -100 == 0) {
//                [self performSegueWithIdentifier:@"homepagedetailSegue" sender:@"http://www.sina.com.cn"];
//            }else{
//                HomePageInvestModel * model = [[HomePageInvestModel alloc] init];
//                model = inverstData[index - 100];
//                [self performSegueWithIdentifier:@"homepagedetailSegue" sender:@"http://www.baidu.com"];
//            }

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
        bgView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];// 灰色
      
        return bgView;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        if (navItem.hidden) {
            return ScreenHeight;
        }
        return 170; //  头部视图的高度170；
    }else if (section == 1){
        return 0.1; // 距离上面的图片0.01 高。
    }
    return 10; // 10高度的灰色。
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return 90; //第一行为90。
        }else if (indexPath.row == 1){
            return 68; // 第二行为富谊头条的行高68。
        }
    }else if (indexPath.section == 2){//??
        return 205; //205
    }
    return 0.1;
}
#pragma mark -SDCycleScrollViewDelegate
//点击头部滚动视图
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    HomepageBannerModel * model = bannerData[index];
    [self performSegueWithIdentifier:@"homepagedetailSegue" sender:model.bannerLink];
//    HomepageBannerModel * model = bannerData[index];
//    playerVC = [IJKMoviePlayerViewController InitVideoViewFromViewController:self withTitle:@"GLTest" URL:[NSURL URLWithString:model.bannerLink] isLiveVideo:YES isOnlineVideo:NO isFullScreen:NO completion:nil];
//    playerVC.fullScreenBlock = ^(BOOL isFullScreen){
//        if (isFullScreen) {
//            navItem.hidden = YES;
//            _headerView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
//            self.topConstraintLayOut.constant = 0;
//            [self setTabBarHidden:YES];
//            [self.tableView reloadData];
//        }else{
//            navItem.hidden = NO;
//            _headerView.frame = CGRectMake(0, 0,ScreenWidth,170);
//            self.topConstraintLayOut.constant = 44;
//            [self setTabBarHidden:NO];
//        }
//    };
//    [self addChildViewController:playerVC];
//    [_headerView addSubview:playerVC.view];
//    [playerVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@0);
//        make.top.equalTo(@0);
//        make.right.equalTo(@0);
//        make.bottom.equalTo(@0);
//    }];
//    /** 判断直播是否开启,并执行退出 */
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        //        [playerVC GoBack];
//    });
    
   
}
- (void)setTabBarHidden:(BOOL)hidden
{
    UIView *tab = self.tabBarController.view;
    
    if ([tab.subviews count] < 2) {
        return;
    }
    UIView *view;
    
    if ([[tab.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]]) {
        view = [tab.subviews objectAtIndex:1];
    } else {
        view = [tab.subviews objectAtIndex:0];
    }
    
    if (hidden) {
        view.frame = tab.bounds;
    } else {
        view.frame = CGRectMake(tab.bounds.origin.x, tab.bounds.origin.y, tab.bounds.size.width, tab.bounds.size.height);
    }
    self.view.frame = view.frame;
    self.tabBarController.tabBar.hidden = hidden;
}

#pragma mark - Navigation

//In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  //   Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"homepagedetailSegue"]){
        HomePageDetailViewController * vc = segue.destinationViewController;
        vc.url = sender;
    }
}

#pragma mark - UIVew
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [Tools hideKeyBoard];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [Tools hideKeyBoard]; 
}
@end
