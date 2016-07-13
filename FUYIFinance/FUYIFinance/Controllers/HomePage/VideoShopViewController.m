//
//  VideoShopViewController.m
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/7/5.
//  Copyright © 2016年 youyou. All rights reserved.
//
#import "VideoDetailViewController.h"
#import "VideoShopViewController.h"

#import "VideoShopNavigationItem.h"
#import "VideoStoreTableViewCell.h"
#import "VideoShopTableViewCell.h"

#import "DOPDropDownMenu.h"

#import "SelectModel.h"
#import "StoreDataModel.h"

#import "LabelHelper.h"
#import <MJRefresh.h>
#import <SDWebImage/UIImageView+WebCache.h>

static NSString *videoShopReuseId = @"videoShopReuseId";

@interface VideoShopViewController ()<UITableViewDataSource,UITableViewDelegate,DOPDropDownMenuDataSource,DOPDropDownMenuDelegate>
{
    NSMutableArray *financeSelectData;
    NSMutableArray *classSelectData;
    
    NSMutableArray *storeArray;
    
    NSString *typeId;
    NSString *labelId;
    NSInteger _page;
    NSString *key;
   
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
    
    _page = 1;
    typeId = @"";
    labelId = @"";
    key = @"";
    
    [self loadMenuData];
    [self loadDataWithTypeSelectId:typeId labelSelectId:labelId pageNum:_page keyWord:key];
    [self addRefresh];
    //[self addTap];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
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
        _page = 1;
        [weakself loadDataWithTypeSelectId:typeId labelSelectId:labelId pageNum:_page keyWord:key];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _page++;
        [weakself loadDataWithTypeSelectId:typeId labelSelectId:labelId pageNum:_page keyWord:key];
    }];
}

- (void)addTap{
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapAct:)];
    [self.view addGestureRecognizer:tapGes];
    
}
- (void)TapAct:(UIGestureRecognizer *)ges{
    [Tools hideKeyBoard];
}

-(void)creatUI{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[VideoShopTableViewCell class] forCellReuseIdentifier:videoShopReuseId];
    [self dropDownMenu];//下拉菜单
    [self addCustomerNavgationItem];
}

- (void)addCustomerNavgationItem{
    VideoShopNavigationItem *navItem = [[[NSBundle mainBundle] loadNibNamed:@"VideoShopNavigationItem" owner:self options:nil] lastObject];
    navItem.frame = CGRectMake(0, 0,ScreenWidth, 64);
    navItem.backBlock = ^(){
        [self.navigationController popViewControllerAnimated:YES];
    };
    
    //[navItem setBackColor];
    [self.view addSubview:navItem];
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

//根据id刷新商城
-(void)loadDataWithTypeSelectId:(NSString*)typeSelectId
                  labelSelectId:(NSString*)labelSelectId
                           pageNum:(NSInteger)pageNum
                        keyWord:(NSString*)keyWord{
    NSString *nowPage = [NSString stringWithFormat:@"%ld",_page];
    [[MyAPI sharedAPI] videoStoreWithTypeSelectId:typeSelectId labelSelectId:labelSelectId page:nowPage keyWord:keyWord result:^(BOOL success, NSString *msg, NSMutableArray *arrays) {
        if (success) {
            storeArray = arrays;
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
        }
    } errorResult:^(NSError *enginerError) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
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
            typeId = model.selectId;
            _page = 1;
            [self loadDataWithTypeSelectId:typeId labelSelectId:labelId pageNum:_page keyWord:key];
        }
        
    }else {
        NSLog(@"点击了 %ld - %ld 项目",indexPath.column,indexPath.row);
        if (indexPath.row == 0) {
            return;
        }else{
            SelectModel *model = classSelectData[indexPath.row-1];
            labelId = model.selectId;
            _page = 1;
            [self loadDataWithTypeSelectId:typeId labelSelectId:labelId pageNum:_page keyWord:key];
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
    //cell.videoPrice.text = [NSString stringWithFormat:@"¥ %@",model.videoPrice];
    
    cell.videoPrice.attributedText = [[LabelHelper alloc] attributedFontStringWithString:[NSString stringWithFormat:@"¥ %@",model.videoPrice]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 115;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"++++++++++++++++++++++++++");
    StoreDataModel *model = [storeArray objectAtIndex:indexPath.row];

    [self performSegueWithIdentifier:@"videoDetailSegue" sender:model];
    
    //self.saveId
    
    
    
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    VideoDetailViewController *detailVC = segue.destinationViewController;
    detailVC.model = sender;
}


#pragma mark - UIVew
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
