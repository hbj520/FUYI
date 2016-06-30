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
@property(nonatomic,assign)BOOL isAllSelected;

@property(nonatomic,retain)NSMutableArray * goodArray;
@property(nonatomic,retain)NSMutableArray * brandArray;



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
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShopCarTableViewCell" bundle:nil] forCellReuseIdentifier:@"shopCarCellReuseID"];
    //[self.tableView registerNib:[UINib nibWithNibName:@"HeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"videoHeaderReuseId"];
    self.tableView.rowHeight = 127;
    
    
    //测试数据源
    NSMutableArray * array0 = [[NSMutableArray alloc]initWithObjects:@"1",@"1", nil];
    NSMutableArray * array1 = [[NSMutableArray alloc]initWithObjects:@"1",@"1", nil];
    NSMutableArray * array2 = [[NSMutableArray alloc]initWithObjects:@"1",@"1", nil];
    self.isSelected = [[NSMutableArray alloc]initWithObjects:array0,array1,array2,nil];
    self.headIsSelected = [[NSMutableArray alloc]initWithObjects:@"1",@"1",@"1", nil];
    self.isAllSelected = YES;
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
//勾选、删除按钮功能
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
    
    [bottomView.chooseAllBtn setBackgroundImage:[UIImage imageNamed:@"shopCar2.jpg"] forState:UIControlStateNormal];
    [bottomView.chooseAllBtn setBackgroundImage:[UIImage imageNamed:@"shopCar21.jpg"] forState:UIControlStateSelected];
    [bottomView.chooseAllBtn addTarget:self action:@selector(chooseAllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
   
    bottomView.chooseAllBtn.selected = _isAllSelected;
    
    [bottomView.goPay addTarget:self action:@selector(goPayClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:bottomView];
}

- (void)chooseAllBtnClick:(UIButton*)button
{
   
    button.selected = !button.selected;
    self.isAllSelected = button.selected;
    if (!button.selected) {
        
//        for (NSArray* array in self.isSelected) {
//         
//        }
        
        
        
        
        
//        [self.isSelected removeAllObjects];
//    
//        [self.headIsSelected removeAllObjects];
   
        
    }
    
}

- (void)goPayClick:(UIButton*)button
{
    
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

/*
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除该商品?删除后无法恢复!" preferredStyle:1];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
//            LZCartModel *model = [self.dataArray objectAtIndex:indexPath.row];
//            
//            [self.dataArray removeObjectAtIndex:indexPath.row];
//            //    删除
//            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//            
//            //判断删除的商品是否已选择
//            if ([self.selectedArray containsObject:model]) {
//                //从已选中删除,重新计算价格
//                [self.selectedArray removeObject:model];
//                [self countPrice];
//            }
//            
//            if (self.selectedArray.count == self.dataArray.count) {
//                _allSellectedButton.selected = YES;
//            } else {
//                _allSellectedButton.selected = NO;
//            }
//            
//            if (self.dataArray.count == 0) {
//                [self changeView];
//            }
//            
            //如果删除的时候数据紊乱,可延迟0.5s刷新一下
            [self performSelector:@selector(reloadTable) withObject:nil afterDelay:0.5];
            
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [alert addAction:okAction];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}
*/

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
