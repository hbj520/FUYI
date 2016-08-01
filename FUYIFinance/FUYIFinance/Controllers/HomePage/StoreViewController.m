//
//  StoreViewController.m
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/7/21.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "StoreViewController.h"

//view
#import "StoreHeaderTableViewCell.h"
#import "ShopTopTableViewCell.h"
#import "MyShopDetailTableViewCell.h"

#import "MyAPI.h"
#import <MJRefresh.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "LabelHelper.h"

#import "TeacherStoreHeaderModel.h"
#import "StoreDataModel.h"
@interface StoreViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _page;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,retain)NSMutableArray * VideoArr;
@property(nonatomic,copy)TeacherStoreHeaderModel * teacherMod;

@end

@implementation StoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _VideoArr = [[NSMutableArray alloc]init];
    _teacherMod = [[TeacherStoreHeaderModel alloc]init];
    
    
    _page = 1;
    [self addRefresh];
    [self loadData];
    [self creatUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //[self loadData];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)addRefresh{
    //添加刷新
    __weak StoreViewController *weakself = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 1;
        if (_VideoArr.count > 0) {
            [_VideoArr removeAllObjects];
        }
        [weakself loadData];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _page++;
        [weakself loadData];
    }];
}


- (void)loadData{
    
    NSString *nowPage = [NSString stringWithFormat:@"%ld",(long)_page];
    
    [[MyAPI sharedAPI] getTeacherStoreDataWithTeacherId:self.model.teacherId page:nowPage result:^(BOOL success, NSString *msg, NSMutableArray *arrays) {
        if (success) {
            _teacherMod = arrays[0];
            [_VideoArr addObjectsFromArray:arrays[1]];
            [self.tableView reloadData];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } errorResult:^(NSError *enginerError) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)creatUI{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"StoreHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:@"StoreHeadCellId"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShopTopTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID2"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MyShopDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID4"];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else{
        return _VideoArr.count;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            StoreHeaderTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"StoreHeaderTableViewCell" owner:self options:nil]lastObject];
            /*  收藏店铺
            [cell.collectStoreBtn setBackgroundImage:[UIImage imageNamed:@"colloectStoreCancel"] forState:UIControlStateNormal];
            [cell.collectStoreBtn setBackgroundImage:[UIImage imageNamed:@"colloectStore"] forState:UIControlStateSelected];
            [cell.collectStoreBtn addTarget:self action:@selector(collectStoreClick:) forControlEvents:UIControlEventTouchUpInside];
             */
             
            cell.teacherNameLab.text = _teacherMod.teacherName;
            cell.collectCountLab.text = [NSString stringWithFormat:@"收藏数：%@",_teacherMod.storeCollectNum];
            [cell.teacherImage sd_setImageWithURL:[NSURL URLWithString:_teacherMod.teacherImage] placeholderImage:[UIImage imageNamed:@"person_headicon"]];
            [cell.bgImage sd_setImageWithURL:[NSURL URLWithString:_teacherMod.storeImage] placeholderImage:[UIImage imageNamed:@"VD_class_demo"]];

            return cell;
        }if (indexPath.row == 1) {
            ShopTopTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"ShopTopTableViewCell" owner:self options:nil]lastObject];
            cell.StoreHotLab.text = _teacherMod.hotContent;
            return cell;
        }
    }else{
        MyShopDetailTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"MyShopDetailTableViewCell" owner:self options:nil]lastObject];
        StoreDataModel *model = [_VideoArr objectAtIndex:indexPath.row];
        [cell.thumbimage sd_setImageWithURL:[NSURL URLWithString:model.videoImage] placeholderImage:[UIImage imageNamed:@"myorderthumbimage"]];
        cell.teacherName.text = [NSString stringWithFormat:@"讲师：%@",model.teacherName];
        cell.price.attributedText = [[LabelHelper alloc]attributedFontStringWithString:[NSString stringWithFormat:@"¥ %@",model.videoPrice] firstFont:9 secFont:13 thirdFont:9];
        cell.title.text = model.videoName;
        cell.paycount.text = [NSString stringWithFormat:@"%@人付款",model.sellNum];
        
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0&&indexPath.row == 0) {
        return 100;
    }if (indexPath.section == 0&&indexPath.row == 1 ) {
        return 40;
    }else{
        return 96;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        return 10;
    }
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }else{
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
        view.backgroundColor = RGBACOLOR(245, 244, 245, 1);
        return view;
    }
}

/* 收藏店铺点击
- (void)collectStoreClick:(UIButton*)button{
    button.selected = !button.selected;
    
}
*/
- (IBAction)back:(id)sender {
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
