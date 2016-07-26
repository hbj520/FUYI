//
//  ShopCarViewController.m
//  FUYIFinance
//
//  Created by youyou on 16/6/28.
//  Copyright © 2016年 youyou. All rights reserved.
//

//view
#import "ShopCarNavigationItem.h"
#import "ShopCarBottomView.h"
#import "ShopCarTableViewCell.h"
#import "HeaderView.h"
#import "CustomBtn.h"

#import "ShopCarViewController.h"

#import "Good.h"
#import "TeacherStoreModel.h"

#import "MyAPI.h"
#import "LabelHelper.h"
#import <MJRefresh.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "LPPopup.h"
//static NSString *videoHeader = @"videoHeaderReuseId";



@interface ShopCarViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSInteger _page;
    UIImageView *_noGoodView;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TopConstraintLayout;
@property(nonatomic,retain)NSMutableArray * isSelected;
@property(nonatomic,retain)NSMutableArray * headIsSelected;
@property(nonatomic,assign)BOOL isAllSelected;


//保存商品、商家
@property(nonatomic,retain)NSMutableArray * goodArray;
@property(nonatomic,retain)NSMutableArray * storeArray;

@end

@implementation ShopCarViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    
    [_goodArray removeAllObjects];
    [_storeArray removeAllObjects];
    [_isSelected removeAllObjects];
    [_headIsSelected removeAllObjects];
    // _noGoodView.hidden = YES;
    [self loadData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _goodArray = [[NSMutableArray alloc]init];
    _storeArray = [[NSMutableArray alloc]init];
    _isSelected = [[NSMutableArray alloc]init];
    _headIsSelected = [[NSMutableArray alloc]init];
    
//    _noGoodView = [[UIImageView alloc]initWithFrame:self.view.frame];
//    _noGoodView.image = [UIImage imageNamed:@"noGood"];
//    
//   [self.tableView addSubview:_noGoodView];

    if (KToken) {
        [self creatUI];
        self.isAllSelected = YES;
        //加载数据源
        _page = 1;
        [self loadData];
        [self addRefresh];
    }
}

- (void)addRefresh{
    __weak ShopCarViewController *weakself = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 1;
        if (_goodArray.count > 0) {
            [_goodArray removeAllObjects];
            [_isSelected removeAllObjects];
            
        }
        if (_storeArray.count > 0) {
            [_storeArray removeAllObjects];
            [_headIsSelected removeAllObjects];
        }
        [weakself loadData];
    }];
}

-(void)loadData
{
    NSString *nowPage = [NSString stringWithFormat:@"%ld",(long)_page];
    [[MyAPI sharedAPI] getShopCarDataWithToken:KToken
                                          page:nowPage
                                        result:^(BOOL success, NSString *msg, NSMutableArray *arrays) {
                                            
                                            if ([msg isEqualToString:@"err token"]) {
                                                [self logOut];
                                            }
                                            if (success) {
                                                [_storeArray addObjectsFromArray:arrays[0]];
                                                [_goodArray addObjectsFromArray:arrays[1]];
                                                
                                                
                                                [self.tableView reloadData];
                                                
                                                [self creatData];//添加是否勾选数据
                                            }
                                            [self.tableView.mj_header endRefreshing];
                                            
                                        } errorResult:^(NSError *enginerError) {
                                            [self.tableView.mj_header endRefreshing];
                                        }];
}

-(void)creatData
{
    for (TeacherStoreModel *teacherModel in _storeArray) {
        [_headIsSelected addObject:@"1"];
    }
    
    for (int i = 0; i < _goodArray.count; i++) {
        NSArray *array = _goodArray[i];
        NSMutableArray *goodA = [[NSMutableArray alloc]init];
        
        for (Good *goodModel in array) {
            [goodA addObject:@"1"];
        }
        [_isSelected addObject:goodA];
    }
}

-(void)creatUI
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = RGBACOLOR(235, 235, 235, 1);
    [self.tableView registerNib:[UINib nibWithNibName:@"ShopCarTableViewCell" bundle:nil] forCellReuseIdentifier:@"shopCarCellReuseID"];
    self.tableView.rowHeight = 127;
    
    self.TopConstraintLayout.constant = 44;
    //导航栏
    [self addCustomerNavigationItem];
    //底部结算View
    [self addBottomView];
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.storeArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.goodArray[section] count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shopCarCellReuseID" forIndexPath:indexPath];
    
    [cell.selectBtn setBackgroundImage:[UIImage imageNamed:@"shopCar2.jpg"] forState:UIControlStateNormal];
    [cell.selectBtn setBackgroundImage:[UIImage imageNamed:@"shopCar21.jpg"] forState:UIControlStateSelected];
   
    cell.selectBtn.index = indexPath;
    [cell.selectBtn addTarget:self action:@selector(cellSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
    //默认1
    cell.selectBtn.selected = [self.isSelected[indexPath.section][indexPath.row]boolValue];
    
        Good *goodMod = _goodArray[indexPath.section][indexPath.row];
        [cell.goodImage sd_setImageWithURL:[NSURL URLWithString:goodMod.goodImage] placeholderImage:[UIImage imageNamed:@"shopcar_defual"]];
        cell.goodPrice.attributedText = [[LabelHelper alloc]attributedFontStringWithString:[NSString stringWithFormat:@"¥ %@",goodMod.goodPrice] firstFont:13 secFont:17 thirdFont:14];
        cell.goodContent.text = goodMod.goodName;
   
    return cell;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HeaderView* headerView = [[[NSBundle mainBundle]loadNibNamed:@"HeaderView" owner:self options:nil]lastObject];
    
    [headerView.selectBtn setBackgroundImage:[UIImage imageNamed:@"shopCar2.jpg"] forState:UIControlStateNormal];
    [headerView.selectBtn setBackgroundImage:[UIImage imageNamed:@"shopCar21.jpg"] forState:UIControlStateSelected];
    
    headerView.selectBtn.tag = section;
    [headerView.selectBtn addTarget:self action:@selector(headButton:) forControlEvents:UIControlEventTouchUpInside];
    //默认按钮选中
    headerView.selectBtn.selected = [self.headIsSelected[section] boolValue];
    
    headerView.deleteBtn.tag = section;
    [headerView.deleteBtn addTarget:self action:@selector(deleteButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //设置header颜色
    headerView.backgroundView = [[UIImageView alloc]init];
    headerView.backgroundView.backgroundColor = [UIColor whiteColor];
    
    TeacherStoreModel *TeacherModel = [_storeArray objectAtIndex:section];
    headerView.videoClassLab.text = [NSString stringWithFormat:@"%@的视频课堂",TeacherModel.teacherName];

    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 36;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 95;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    view.backgroundColor = RGBACOLOR(235, 235, 235, 1);
    return view;
}

#pragma mark --privateMethod
//cell单选按钮
- (void)cellSelectBtn:(CustomBtn*)button
{
    button.selected = !button.selected;
    if (!button.selected) {
           HeaderView* head = (HeaderView*)[self.tableView headerViewForSection:button.index.section];
           head.selectBtn.selected = NO;
           [self.headIsSelected removeObjectAtIndex:button.index.section];
           [self.headIsSelected insertObject:@"0" atIndex:button.index.section];

    }
    NSMutableArray * array = self.isSelected[button.index.section];
    [array removeObjectAtIndex:button.index.row];
    [array insertObject:[NSString stringWithFormat:@"%d",button.selected] atIndex:button.index.row];
    NSInteger b = 0;
    for (NSString * boolstr in array) {
        if ([boolstr isEqualToString:@"1"]) {
            b++;
        }
    }
    if (b == array.count) {
        NSLog(@"全选");
        [self.headIsSelected removeObjectAtIndex:button.index.section];
        [self.headIsSelected insertObject:@"1" atIndex:button.index.section];
        HeaderView* head = (HeaderView*)[self.tableView headerViewForSection:button.index.section];
        head.selectBtn.selected = YES;
        
    }
    
    [self allSelectedBtn];
//    NSInteger c = 0;
//    NSInteger d = 0;
//    for (NSString *seleceStr in self.headIsSelected) {
//        if ([seleceStr isEqualToString:@"0"]) {
//            c++;
//        }else{
//            d++;
//        }
//    }
//    
//    if (d == self.headIsSelected.count) {
//        ShopCarBottomView* view1 = (ShopCarBottomView*)[self.view viewWithTag:100];
//        view1.chooseAllBtn.selected = YES;
//        
//    }if (c > 0){
//        ShopCarBottomView* view1 = (ShopCarBottomView*)[self.view viewWithTag:100];
//        view1.chooseAllBtn.selected = NO;
//    }
}

//区头局部全选按钮
- (void)headButton:(CustomBtn*)button
{
    button.selected = !button.selected;
    [self.headIsSelected removeObjectAtIndex:button.tag];
    [self.headIsSelected insertObject:[NSString stringWithFormat:@"%d",button.selected] atIndex:button.tag];
    
    for (int i = 0; i< [(NSMutableArray*)self.isSelected[button.tag] count]; i++) {
        
        ShopCarTableViewCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:button.tag]];
        if (!cell) {
            break;
        }else {
            cell.selectBtn.selected = button.selected;
        }
    }
    NSMutableArray * is1 = [[NSMutableArray alloc]init];
    for (int i = 0 ; i<[(NSMutableArray*)self.isSelected[button.tag] count]; i++) {
        if (button.selected) {
            [is1 addObject:@"1"];
        }else
        {
            [is1 addObject:@"0"];
        }
    }
    [self allSelectedBtn];
    [self.isSelected removeObjectAtIndex:button.tag];
    [self.isSelected insertObject:is1 atIndex:button.tag];
//
//    NSInteger c = 0;
//    NSInteger d = 0;
//    for (NSString *seleceStr in self.headIsSelected) {
//        if ([seleceStr isEqualToString:@"0"]) {
//            c++;
//        }else{
//            d++;
//        }
//    }
//    
//    if (d == self.headIsSelected.count) {
//        ShopCarBottomView* view1 = (ShopCarBottomView*)[self.view viewWithTag:100];
//        view1.chooseAllBtn.selected = YES;
//        
//    }if (c > 0){
//        ShopCarBottomView* view1 = (ShopCarBottomView*)[self.view viewWithTag:100];
//        view1.chooseAllBtn.selected = NO;
//    }
}

//局部删除
- (void)deleteButton:(CustomBtn*)button
{
    NSArray *goodArr = [_goodArray objectAtIndex:button.tag];
    NSMutableArray *orderArr = [[NSMutableArray alloc]init];
    for (Good *headGood in goodArr) {
        [orderArr addObject:headGood.orderNum];
    }
    NSString *OrderStr = [orderArr componentsJoinedByString:@","];
    
    [[MyAPI sharedAPI] deleteVideoFromShopCarWithToken:KToken
                                              orderNum:OrderStr
                                                result:^(BOOL sucess, NSString *msg) {
                                                    if ([msg isEqualToString:@"登录超时"]) {
                                                        [self logOut];
                                                    }
                                                    if (sucess) {
                                                        [self.headIsSelected removeObjectAtIndex:button.tag];
                                                        [self.isSelected removeObjectAtIndex:button.tag];
                                                        [self.storeArray removeObjectAtIndex:button.tag];
                                                        [self.goodArray removeObjectAtIndex:button.tag];
                                                        
                                                        [self allSelectedBtn];//全选按钮状态
                                                        
                                                        [self.tableView reloadData];
                                                        [self showPopup:msg];
                                                    }
                                                } errorResult:^(NSError *enginerError) {
                                                    
                                                }];
}



//底部结算条
-(void)addBottomView
{
    ShopCarBottomView *bottomView = [[[NSBundle mainBundle]loadNibNamed:@"ShopCarBottomView" owner:self options:nil]lastObject];
    bottomView.tag =100;
    bottomView.frame = CGRectMake(0, ScreenHeight-88,ScreenWidth, 44);
    
    [bottomView.chooseAllBtn setBackgroundImage:[UIImage imageNamed:@"shopCar2.jpg"] forState:UIControlStateNormal];
    [bottomView.chooseAllBtn setBackgroundImage:[UIImage imageNamed:@"shopCar21.jpg"] forState:UIControlStateSelected];
    [bottomView.chooseAllBtn addTarget:self action:@selector(chooseAllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.isAllSelected = YES;
    bottomView.chooseAllBtn.selected = self.isAllSelected;
    [bottomView.goPay addTarget:self action:@selector(goPayClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:bottomView];
}

#pragma mark - 刷新底部金额
//- (void)reloadAllPrice
//{
//    self.price = 0;
//    
//    for (int i = 0; i < _goodArray.count; i++) {
//        
//        NSMutableArray * array1 = _goodArray[i];
//        NSMutableArray * array2 = _isSelected[i];
//        
//        
//        for (int a = 0; a < array1.count; a++) {
//            
//            NSString * selectstr = array2[a];
//            if ([selectstr boolValue]) {
//                Good * goods = array1[a];
//                self.price = self.price + [goods.goodPrice integerValue];
//                
//            }
//        }
//    }
//    
//    NSLog(@"------------总价为%ld-------------",(long)self.price);
//    
//    
//}

//全选按钮
- (void)chooseAllBtnClick:(UIButton*)button
{
   button.selected = !button.selected;
    NSInteger headSelectedNum = self.headIsSelected.count;
    if (button.selected) {
        for (NSMutableArray *array in self.isSelected) {
            NSInteger cellSelectedNum = array.count;
            [array removeAllObjects];
            for (int i = 0; i<cellSelectedNum; i++) {
                [array addObject:@"1"];
            }
        }
        [self.headIsSelected removeAllObjects];
        for (int i = 0; i<headSelectedNum; i++) {
            [self.headIsSelected addObject:@"1"];
        }
    }else{
        for (NSMutableArray *array in self.isSelected) {
            NSInteger cellSelectedNum = array.count;
            [array removeAllObjects];
            for (int i = 0; i<cellSelectedNum; i++) {
                [array addObject:@"0"];
            }
        }
        [self.headIsSelected removeAllObjects];
        for (int i = 0; i<headSelectedNum; i++) {
            [self.headIsSelected addObject:@"0"];
    }
    
}
    [self.tableView reloadData];
}

//去结算
- (void)goPayClick:(UIButton*)button
{
    
}

//导航栏
-(void)addCustomerNavigationItem
{
    ShopCarNavigationItem *navItem = [[[NSBundle mainBundle]loadNibNamed:@"ShopCarNavigationItem" owner:self options:nil]lastObject];
    navItem.backgroundColor = RGBACOLOR(244,244,244,1);
    navItem.frame = CGRectMake(0, 0,ScreenWidth, 64);
    
    if (self.isPush) {
        navItem.backBtn.hidden = NO;
    }
    
    navItem.backBlock = ^(){
        [self.navigationController popViewControllerAnimated:YES];
    };
    
    
    //消息按钮
    navItem.messageBlock = ^(){
        
    };
    [self.view addSubview:navItem];
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除该商品?删除后无法恢复!" preferredStyle:1];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            Good *deleGood = _goodArray[indexPath.section][indexPath.row];
            [[MyAPI sharedAPI] deleteVideoFromShopCarWithToken:KToken
                                                      orderNum:deleGood.orderNum
                                                        result:^(BOOL sucess, NSString *msg) {
                                                            if ([msg isEqualToString:@"登录超时"]) {
                                                                [self logOut];
                                                            }
                                                            if (sucess) {
                                                                [self.isSelected[indexPath.section] removeObjectAtIndex:indexPath.row];
                                                                [self.goodArray[indexPath.section] removeObjectAtIndex:indexPath.row];
                                                                
                                                                //判断如果某区行数被删光，删除所在区
                                                                if ([self.goodArray[indexPath.section] count] == 0) {
                                                                    
                                                                    [self.goodArray removeObjectAtIndex:indexPath.section];
                                                                    [self.storeArray removeObjectAtIndex:indexPath.section];
                                                                    [self.isSelected removeObjectAtIndex:indexPath.section];
                                                                    [self.headIsSelected removeObjectAtIndex:indexPath.section];
                
                                                                    [self.tableView reloadData];
                                                                }else{
                                                                    //如果没有被删光，遍历剩下的行是否全选
                                                                    NSInteger y = 0;
                                                                    for (NSString *strr in self.isSelected[indexPath.section]) {
                                                                        if ([strr isEqualToString:@"1"]) {
                                                                            y++;
                                                                        }
                                                                        //如果全选，给所在区选定状态改为@“1”
                                                                    }if (y == [self.isSelected[indexPath.section] count]) {
                                                                        
                                                                        self.headIsSelected[indexPath.section] = @"1";
                                                                    }
                                                                    [self.tableView reloadData];
                                                                }
                                                                
                                                                [self allSelectedBtn];//判断结算条是否全选
                                                                [self.tableView reloadData];
                                                                [self showPopup:msg];
                                                            }else{
                                                                [self showPopup:msg];
                                                            }
                                                        } errorResult:^(NSError *enginerError) {
                                                            
                                                        }];
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:okAction];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
        [self.tableView reloadData];
    }
    
}

//判断全选按钮状态
- (void)allSelectedBtn{
    NSInteger c = 0;
    NSInteger d = 0;
    for (NSString *seleceStr in self.headIsSelected) {
        if ([seleceStr isEqualToString:@"0"]) {
            c++;
        }else{
            d++;
        }
    }
    //如果局部全选，设置全选状态
    if (d == self.headIsSelected.count) {
        ShopCarBottomView* view1 = (ShopCarBottomView*)[self.view viewWithTag:100];
        view1.chooseAllBtn.selected = YES;
        
    }if (c > 0){
        ShopCarBottomView* view1 = (ShopCarBottomView*)[self.view viewWithTag:100];
        view1.chooseAllBtn.selected = NO;
    }
    [self.tableView reloadData];
    
    //区被删光 把全选置为NO
    if (self.headIsSelected.count == 0||self.isSelected.count == 0) {
        ShopCarBottomView* view1 = (ShopCarBottomView*)[self.view viewWithTag:100];
        view1.chooseAllBtn.selected = NO;
        [self.tableView addSubview:_noGoodView];
    }
}

- (void)showPopup:(NSString *)popupWithText
{
    LPPopup *popup = [LPPopup popupWithText:popupWithText];
    [popup showInView:self.view
        centerAtPoint:self.view.center
             duration:kLPPopupDefaultWaitDuration
           completion:nil];
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
