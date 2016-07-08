//
//  VideoShopViewController.m
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/7/5.
//  Copyright © 2016年 youyou. All rights reserved.
//
#import "VideoDetailViewController.h"
#import "VideoShopViewController.h"

#import "VideoStoreTableViewCell.h"
#import "VideoShopTableViewCell.h"

#import "DOPDropDownMenu.h"

#import "SelectModel.h"
#import "StoreDataModel.h"


#import <MJRefresh.h>
#import <SDWebImage/UIImageView+WebCache.h>

static NSString *videoShopReuseId = @"videoShopReuseId";

@interface VideoShopViewController ()<UITableViewDataSource,UITableViewDelegate,DOPDropDownMenuDataSource,DOPDropDownMenuDelegate>
{
    NSMutableArray *financeSelectData;
    NSMutableArray *classSelectData;
    
    NSMutableArray *storeArray;
    
   
}
@property (nonatomic,copy) NSString *saveId;
@property (nonatomic, weak) DOPDropDownMenu *menu;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)back:(id)sender;

@end

@implementation VideoShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    financeSelectData = [NSMutableArray array];
    classSelectData = [NSMutableArray array];
    storeArray = [NSMutableArray array];
    // Do any additional setup after loading the view.
    [self creatUI];

    [self loadMenuData];
    [self loadStoreData];
   // [self addRefresh];

}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma   mark -PrivateMethod 
- (void)addRefresh{
    //添加刷新
    __weak VideoShopViewController *weakself = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (financeSelectData.count > 0) {
            [financeSelectData removeAllObjects];
        }
        if (classSelectData.count > 0) {
            [classSelectData removeAllObjects];
        }
        if (storeArray.count > 0) {
            [storeArray removeAllObjects];
        }
        [weakself loadData];
    }];
    
   // self.tableView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
      //  <#code#>
   // }];
    
    
}
- (void)TapAct:(UIGestureRecognizer *)ges{
    [Tools hideKeyBoard];
}




-(void)creatUI{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[VideoShopTableViewCell class] forCellReuseIdentifier:videoShopReuseId];
    [self dropDownMenu];//下拉菜单
}

- (void)loadMenuData{
    //下拉菜单
    [[MyAPI sharedAPI] videoStoreWithResult:^(BOOL success, NSString *msg, NSMutableArray *arrays) {
        if (success) {
            financeSelectData = arrays[0];
            classSelectData = arrays[1];
        }
    } errorResult:^(NSError *enginerError) {
        
    }];
}

- (void)loadStoreData{
    //默认商城
    [[MyAPI sharedAPI] videoStoreDefaultDataWithResult:^(BOOL success, NSString *msg, NSMutableArray *arrays) {
        if (success) {
            storeArray = arrays[0];
            [self.tableView reloadData];
           // [self.tableView.mj_header endRefreshing];
           // [self.tableView.mj_footer endRefreshing];
        }
    } erroResult:^(NSError *enginerError) {
       // [self.tableView.mj_header endRefreshing];
       // [self.tableView.mj_footer endRefreshing];
    }];
}
//根据id刷新商城
-(void)loadLeftSelData{
    [[MyAPI sharedAPI] videoStoreWithSelectId:self.saveId  result:^(BOOL success, NSString *msg, NSMutableArray *arrays) {
        if (success) {
            storeArray = arrays[0];
            [self.tableView reloadData];
           // [self.tableView.mj_header endRefreshing];
            //[self.tableView.mj_footer endRefreshing];
        }
    } errorResult:^(NSError *enginerError) {
       // [self.tableView.mj_header endRefreshing];
       // [self.tableView.mj_footer endRefreshing];
    }];
}
-(void)loadRightSelData{
    [[MyAPI sharedAPI] videoStoreWithRightSelectId:self.saveId result:^(BOOL success, NSString *msg, NSMutableArray *arrays) {
        if (success) {
            storeArray = arrays[0];
            [self.tableView reloadData];
           // [self.tableView.mj_header endRefreshing];
           // [self.tableView.mj_footer endRefreshing];
        }
    } errorResult:^(NSError *enginerError) {
       // [self.tableView.mj_header endRefreshing];
        //[self.tableView.mj_footer endRefreshing];
    }];
}

- (void)dropDownMenu
{
    // 添加下拉菜单
    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:44];
    menu.delegate = self;
    menu.dataSource = self;
    [self.view addSubview:menu];
    _menu = menu;
    
    // 创建menu 第一次显示 不会调用点击代理，可以用这个手动调用
    [menu selectDefalutIndexPath];
}

#pragma mark - DOPDropDownMenuDelegate
- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu
{
    return 2;
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column
{
    if (column == 0) {
        return financeSelectData.count+1;
    }else {
        return classSelectData.count+1;
    }
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath
{
        //下拉菜单数据默认第一行显示 设置第一行死数据
    if (indexPath.column == 0) {
        if (indexPath.row == 0) {
            return @"金融品种";
        }else{
        SelectModel *model = financeSelectData[indexPath.row-1];
        return model.selectName;
        }
    }else {
        if (indexPath.row == 0) {
            return @"课程类型";
        }else{
            SelectModel *model = classSelectData[indexPath.row-1];
        return model.selectName;
        }
    }
}

- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
        NSLog(@"点击了 %ld - %ld 项目",indexPath.column,indexPath.row);
        if (indexPath.row == 0) {
            return;
        }else{
            SelectModel *model = financeSelectData[indexPath.row-1];
            self.saveId = model.selectId;
            [self loadLeftSelData];
        }
        
    }else {
        NSLog(@"点击了 %ld - %ld 项目",indexPath.column,indexPath.row);
        if (indexPath.row == 0) {
            return;
        }else{
            SelectModel *model = classSelectData[indexPath.row-1];
            self.saveId = model.selectId;
            [self loadRightSelData];
        }
    }
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return storeArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VideoShopTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"VideoShopTableViewCell" owner:self options:nil] lastObject];
    
    StoreDataModel *model = [storeArray objectAtIndex:indexPath.row];
    [cell.videoImage sd_setImageWithURL:[NSURL URLWithString:model.videoImage]placeholderImage:[UIImage imageNamed:@"bigimage"]];
    cell.videoTitle.text = model.videoName;
    cell.teacherName.text = [NSString stringWithFormat:@"讲师： %@",model.teacherName];
    cell.videoPrice.text = [NSString stringWithFormat:@"¥ %@",model.videoPrice];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 115;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"++++++++++++++++++++++++++");
    [self performSegueWithIdentifier:@"videoDetailSegue" sender:nil];
    
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
    [self.view endEditing:YES];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
