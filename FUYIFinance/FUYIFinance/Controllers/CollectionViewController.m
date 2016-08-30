//
//  CollectionViewController.m
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/8/1.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "CollectionViewController.h"
#import "VideoDetailViewController.h"
#import "MyCollectionTableViewCell.h"

#import "MineCollectionTreasureModel.h"
#import "StoreDataModel.h"
#import "LabelHelper.h"
#import "MJRefresh.h"
#import <SDWebImage/UIImageView+WebCache.h>


static NSString *collectionId = @"MyCollectionId";
@interface CollectionViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger _page;
    NSMutableArray *collectGoodArr;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CollectionViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    collectGoodArr = [[NSMutableArray alloc]init];
    [self creatUI];
    _page = 1;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:@"reloadcollect" object:nil];
    [self loadDataWithPage:_page];
    [self addRefresh];

  self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)creatUI{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //self.tableView.frame = CGRectMake(0, 0, ScreenWidth-64, ScreenHeight);
    [self.tableView registerNib:[UINib nibWithNibName:@"MyCollectionTableViewCell" bundle:nil] forCellReuseIdentifier:collectionId];
    self.tableView.rowHeight = 105;
    self.tableView.sectionHeaderHeight = 14;
    self.tableView.sectionFooterHeight = 0;
}

//添加上下拉刷新
- (void)addRefresh{
    __weak CollectionViewController *weakself = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 1;
        [weakself loadDataWithPage:_page];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _page++;
        [weakself loadDataWithPage:_page];
    }];
}


- (void)loadData
{
    [_tableView.mj_header beginRefreshing];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"reloadcollect" object:nil];
}

- (void)loadDataWithPage:(NSInteger)page{
    NSString *nowPage = [NSString stringWithFormat:@"%ld",(long)_page];
    [[MyAPI sharedAPI] requestCollectionTreasureDataWithParameters:nowPage result:^(BOOL success, NSString *msg, NSMutableArray *arrays) {
        if (success) {
            if(page == 1){
                if (collectGoodArr.count > 0) {
                    [collectGoodArr removeAllObjects];
                }
            }
            [collectGoodArr addObjectsFromArray:arrays];
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }else{
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            if([msg isEqualToString:@"-1"]){
                [self logOut];
            }else if([msg isEqualToString:@"0"]){
                if(_page!=1){
                    [_tableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [collectGoodArr removeAllObjects];
                    [_tableView reloadData];
                }
            }
        }
       
    } errorResult:^(NSError *enginerError) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}


#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return collectGoodArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   MyCollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:collectionId forIndexPath:indexPath];
    
    MineCollectionTreasureModel *model = [collectGoodArr objectAtIndex:indexPath.section];
    
    [cell.thumbimage sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"myorderthumbimage"]];
    cell.titlename.text = model.name;
    cell.teachername.text = model.teacher;
    
    cell.pricelabel.attributedText = [[LabelHelper alloc]attributedFontStringWithString:[NSString stringWithFormat:@"%@",model.price] firstFont:13 secFont:17 thirdFont:14];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineCollectionTreasureModel * model =[[MineCollectionTreasureModel alloc] init];
    model = collectGoodArr[indexPath.section];
    StoreDataModel * model1 = [[StoreDataModel alloc] initWithParameters:model.goodsid
                                                               videoName:model.name
                                                             teacherName:model.teacher videoImage:model.image videoPrice:model.price sellNum:model.num videodescription:model.about teacherId:model.tid videoType:model.type videoCollect:model.collection cart:model.cart videoUrl:model.videourl];
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"HomePage" bundle:nil];
    
    VideoDetailViewController * vc =[storyboard instantiateViewControllerWithIdentifier:@"VideoShopStoryBoardID"];
    vc.model = model1;
    [self.navigationController pushViewController:vc animated:YES];
}


- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectio{
    
    return nil;
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
