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
#import "Brand.h"

//static NSString *videoHeader = @"videoHeaderReuseId";



@interface ShopCarViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TopConstraintLayout;
@property(nonatomic,retain)NSMutableArray * isSelected;
@property(nonatomic,retain)NSMutableArray * headIsSelected;
@property(nonatomic,assign)BOOL isAllSelected;


//保存商品、商标
@property(nonatomic,retain)NSMutableArray * goodArray;
@property(nonatomic,retain)NSMutableArray * brandArray;



@end

@implementation ShopCarViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (!KToken) {
        [self logOut];
    }else{
        [self creatUI];
        self.isAllSelected = YES;
        //加载数据源
        [self loadData];
    }

    
}

-(void)loadData
{
    //创建数据
    [self creatData];
}

-(void)creatData
{   //测试数据源
    NSMutableArray * array0 = [[NSMutableArray alloc]initWithObjects:@"1",@"1", nil];
    NSMutableArray * array1 = [[NSMutableArray alloc]initWithObjects:@"1",@"1", nil];
    NSMutableArray * array2 = [[NSMutableArray alloc]initWithObjects:@"1",@"1", nil];
    self.isSelected = [[NSMutableArray alloc]initWithObjects:array0,array1,array2,nil];
    self.headIsSelected = [[NSMutableArray alloc]initWithObjects:@"1",@"1",@"1", nil];
}

-(void)creatUI
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShopCarTableViewCell" bundle:nil] forCellReuseIdentifier:@"shopCarCellReuseID"];
    self.tableView.rowHeight = 127;
    
    self.TopConstraintLayout.constant = 44;
    //导航栏
    [self addCustomerNavigationItem];
    //底部结算View
    [self addBottomView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.isSelected.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.isSelected[section] count];
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
   
    return cell;

}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HeaderView* headerView = [[[NSBundle mainBundle]loadNibNamed:@"HeaderView" owner:self options:nil]lastObject];
 
    [headerView.selectBtn setBackgroundImage:[UIImage imageNamed:@"shopCar2.jpg"] forState:UIControlStateNormal];
    [headerView.selectBtn setBackgroundImage:[UIImage imageNamed:@"shopCar21.jpg"] forState:UIControlStateSelected];
    
    headerView.selectBtn.tag = section;
    [headerView.selectBtn addTarget:self action:@selector(headButton:) forControlEvents:UIControlEventTouchUpInside];
    //默认1
    headerView.selectBtn.selected = [self.headIsSelected[section] boolValue];
    
    headerView.deleteBtn.tag = section;
    [headerView.deleteBtn addTarget:self action:@selector(deleteButton:) forControlEvents:UIControlEventTouchUpInside];
   
    return headerView;
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
    NSInteger c = 0;
    NSInteger d = 0;
    for (NSString *seleceStr in self.headIsSelected) {
        if ([seleceStr isEqualToString:@"0"]) {
            c++;
        }else{
            d++;
        }
    }
    
    if (d == self.headIsSelected.count) {
        ShopCarBottomView* view1 = (ShopCarBottomView*)[self.view viewWithTag:100];
        view1.chooseAllBtn.selected = YES;
        
    }if (c > 0){
        ShopCarBottomView* view1 = (ShopCarBottomView*)[self.view viewWithTag:100];
        view1.chooseAllBtn.selected = NO;
    }
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
    
    [self.isSelected removeObjectAtIndex:button.tag];
    [self.isSelected insertObject:is1 atIndex:button.tag];

    NSInteger c = 0;
    NSInteger d = 0;
    for (NSString *seleceStr in self.headIsSelected) {
        if ([seleceStr isEqualToString:@"0"]) {
            c++;
        }else{
            d++;
        }
    }
    
    if (d == self.headIsSelected.count) {
        ShopCarBottomView* view1 = (ShopCarBottomView*)[self.view viewWithTag:100];
        view1.chooseAllBtn.selected = YES;
        
    }if (c > 0){
        ShopCarBottomView* view1 = (ShopCarBottomView*)[self.view viewWithTag:100];
        view1.chooseAllBtn.selected = NO;
    }
}

//删除
- (void)deleteButton:(CustomBtn*)button
{
    [self.headIsSelected removeObjectAtIndex:button.tag];
    [self.isSelected removeObjectAtIndex:button.tag];
    
    //确保全选按钮跟着删除后局部全选按钮变动
    NSInteger SecR = 0;
    for (NSString *restStr in self.headIsSelected) {
            if ([restStr isEqualToString:@"1"]) {
                SecR ++;
            }
    }if (SecR == self.headIsSelected.count ) {
        ShopCarBottomView* view1 = (ShopCarBottomView*)[self.view viewWithTag:100];
        view1.chooseAllBtn.selected = YES;
    }
    
    if (self.headIsSelected.count == 0) {
        ShopCarBottomView* view1 = (ShopCarBottomView*)[self.view viewWithTag:100];
        view1.chooseAllBtn.selected = NO;
    }
    
    [self.tableView reloadData];
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
            
            [self.isSelected[indexPath.section] removeObjectAtIndex:indexPath.row];
         //   [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            //判断如果某区行数被删光，删除所在区
            if ([self.isSelected[indexPath.section] count] == 0) {
                [self.isSelected removeObjectAtIndex:indexPath.section];
                [self.headIsSelected removeObjectAtIndex:indexPath.section];
//                NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:indexPath.section];
//                [tableView deleteSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
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
            
            //遍历区是否局部全选
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
            }
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:okAction];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
        [self.tableView reloadData];
    }
    
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
