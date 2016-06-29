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

//static NSString *videoHeader = @"videoHeaderReuseId";



@interface ShopCarViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,retain)NSMutableArray * isSelected;
@property(nonatomic,retain)NSMutableArray * headIsSelected;

@end

@implementation ShopCarViewController

-(void)viewWillAppear:(BOOL)animated
{

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatUI];
}

-(void)creatUI
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //self.tableView.frame = CGRectMake(0, 100, ScreenWidth, ScreenHeight-108);
    [self.tableView registerNib:[UINib nibWithNibName:@"ShopCarTableViewCell" bundle:nil] forCellReuseIdentifier:@"shopCarCellReuseID"];
    //[self.tableView registerNib:[UINib nibWithNibName:@"HeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"videoHeaderReuseId"];
    self.tableView.rowHeight = 127;
    
    
    //测试数据源
    NSMutableArray * array0 = [[NSMutableArray alloc]initWithObjects:@"1",@"1", nil];
    NSMutableArray * array1 = [[NSMutableArray alloc]initWithObjects:@"1",@"1", nil];
    NSMutableArray * array2 = [[NSMutableArray alloc]initWithObjects:@"1",@"1", nil];
    self.isSelected = [[NSMutableArray alloc]initWithObjects:array0,array1,array2,nil];
    self.headIsSelected = [[NSMutableArray alloc]initWithObjects:@"1",@"1",@"1", nil];
    
    //导航栏
    [self addCustomerNavigationItem];
    //底部结算View
    [self addBottomView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
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
    /*
    headerView.deleteBtn.tag = section;
    [headerView.deleteBtn addTarget:self action:@selector(deleteButton:) forControlEvents:UIControlEventTouchUpInside];
   */
    return headerView;
}

#pragma mark --privateMethod
//勾选、删除 按钮功能
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
    
    
}

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
}

- (void)deleteButton:(CustomBtn*)button
{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 51;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    view.backgroundColor = RGBACOLOR(235, 235, 235, 1);
    return view;
}

-(void)addBottomView
{
    ShopCarBottomView *bottomView = [[[NSBundle mainBundle]loadNibNamed:@"ShopCarBottomView" owner:self options:nil]lastObject];
    bottomView.frame = CGRectMake(0, ScreenHeight-88,ScreenWidth, 44);
    [self.view addSubview:bottomView];
}

-(void)addCustomerNavigationItem
{
    ShopCarNavigationItem *navItem = [[[NSBundle mainBundle]loadNibNamed:@"ShopCarNavigationItem" owner:self options:nil]lastObject];
    navItem.backgroundColor = RGBACOLOR(244,244,244,1);
    navItem.frame = CGRectMake(0, 0,ScreenWidth, 64);
    //消息按钮
    navItem.messageBlock = ^(){
        
    };
    [self.view addSubview:navItem];
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
