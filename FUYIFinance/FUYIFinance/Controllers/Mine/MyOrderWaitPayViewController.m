//
//  MyOrderWaitPayViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/6/28.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MyOrderWaitPayViewController.h"
#import "ConfirmOrderViewController.h"
#import "PersonalWaitPayTableViewCell.h"
#import "UIViewController+HUD.h"
#import <MJRefresh/MJRefresh.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "PayView.h"
#import "ZCTradeView.h"
#import "XLPasswordView.h"
#import "MineWaitPayModel.h"
#import "StoreDataModel.h"
#import "Config.h"
#import "Tools.h"
#import "MyAPI.h"
@interface MyOrderWaitPayViewController ()<XLPasswordViewDelegate,ZCTradeViewDelegate,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    UITableView * _tableView;
    NSMutableArray * _dataSource; //待付款的数据
    PayView* _payView;
    XLPasswordView * passwordview;
    UIButton* _shadowBtn;
    NSInteger  index;
    NSInteger index1;
    NSInteger page;
    NSString * _ordernum;
}
@end

@implementation MyOrderWaitPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.tag = 10;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _dataSource = [NSMutableArray array];
    page = 1;
    [_tableView registerNib:[UINib
                            nibWithNibName:@"PersonalWaitPayTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyOrderId"];
    

    [self.view addSubview:_tableView];

    [self addRefresh];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshtableview) name:@"refreshView" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadView) name:@"reload" object:nil];
    [self loadData];
    [self creatHidePayView];
}



- (void)refreshtableview
{
    [self loadData];
}

- (void)reloadView
{
    [self loadData];
}

- (void)addRefresh
{
    __weak MyOrderWaitPayViewController * weakself = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        page = 1;
        [weakself loadData];
        
    }];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page++;
        [weakself loadData];
    }];
  
}

//加载数据
- (void)loadData
{
    NSString * pagestr = [NSString stringWithFormat:@"%ld",page];
    [[MyAPI sharedAPI] requestWaitpayDataWithParameters:pagestr
                                                 result:^(BOOL success, NSString *msg, NSMutableArray *arrays) {
                                                     if(success){
                                                         if(page == 1){
                                                             [_dataSource removeAllObjects];
                                                         }
                                                         [_dataSource addObjectsFromArray:arrays];
                                                         [_tableView reloadData];
                                                         [_tableView.mj_header endRefreshing];
                                                         [_tableView.mj_footer endRefreshing];
                                                     }else{
                                                         if([msg isEqualToString:@"-1"]){
                                                             [self logOut];
                                                         }else{
                                                             if(page==1){
                                                                 [_dataSource removeAllObjects];
                                                                 [_tableView reloadData];
                                                             }else{
                                                                 [_tableView reloadData];
                                                                 [_tableView.mj_footer endRefreshingWithNoMoreData];
                                                             }
                                                         }
                                                         [_tableView.mj_header endRefreshing];
                                                        }
            
    } errorResult:^(NSError *enginerError) {
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    }];
    
}

-(void)creatHidePayView{
    
    _payView = [[[NSBundle mainBundle]loadNibNamed:@"PayView" owner:self options:nil]lastObject];;
    _payView.titleLab.text = @"付款详情";
    _payView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight * 0.65);
    [_payView.downBtn addTarget:self action:@selector(down) forControlEvents:UIControlEventTouchUpInside];
    [_payView.payBtn addTarget:self action:@selector(payaction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_payView];
}

- (void)payaction
{
    passwordview = [XLPasswordView passwordView];
    passwordview.delegate = self;
    [passwordview showPasswordInView:self.view];
}



- (void)passwordView:(XLPasswordView *)passwordView didFinishInput:(NSString *)password

{
    NSString * SecurityString = [Tools loginPasswordSecurityLock:password];
    NSString * ordernum = [[Config Instance] getOrderNum];
    if(_ordernum.length&&KToken.length){
        [[MyAPI sharedAPI] payOrderWithOrderNum:ordernum Excode:SecurityString Result:^(BOOL sucess, NSString *msg) {
            if(sucess){
                [self showHint:msg];
                if(_dataSource.count&&index1<_dataSource.count){
                    [_dataSource removeObjectAtIndex:index1];
                    [_tableView reloadData];
                    [passwordView hidePasswordView];
                    [self down];
                }
            }else{
                if([msg isEqualToString:@"-1"]){
                    [self logOut];
                }else{
                [self showHint:msg];
                }
                [passwordView hidePasswordView];
            }
            [self loadData];
        } ErrorResult:^(NSError *enginerError) {
            
        }];
    }
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 217;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonalWaitPayTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyOrderId" forIndexPath:indexPath];
    
    //取消按钮
    cell.cancelBtn.tag = 10 + indexPath.section;
    [cell.cancelBtn addTarget:self action:@selector(clickCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    //确定按钮
    cell.sureBtn.tag = indexPath.section;
    [cell.sureBtn addTarget:self action:@selector(clickSureBtn:) forControlEvents:UIControlEventTouchUpInside];
    MineWaitPayModel * model = [[MineWaitPayModel alloc] init];
    model = _dataSource[indexPath.section];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineWaitPayModel * model = [[MineWaitPayModel alloc] init];
    model = _dataSource[indexPath.section];
    StoreDataModel * model1 = [[StoreDataModel alloc] init];
    model1.videoName = model.name;
    model1.videoImage = model.image;
    model1.videoPrice = model.price;
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"HomePage" bundle:nil];
    
    ConfirmOrderViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"confirmstoryboardId"];
    vc.model = model1;
    [self.navigationController pushViewController:vc animated:YES];
    
}

//点击取消订单
- (void)clickCancelBtn:(UIButton*)sender
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"确认删除订单？" message:@"删除之后可以从电脑端订单回收站恢复" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alertView show];
    index = sender.tag;
    NSLog(@"%ld",(long)sender.tag);
}

//点击确定付款
- (void)clickSureBtn:(UIButton*)sender
{
    index1 = sender.tag;
    _shadowBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _shadowBtn.backgroundColor = [UIColor blackColor];
    [_shadowBtn addTarget:self action:@selector(down) forControlEvents:UIControlEventTouchUpInside];
    _shadowBtn.alpha = 0.5;
    [self.view addSubview:_shadowBtn];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    MineWaitPayModel * model = [[MineWaitPayModel alloc] init];
    model = _dataSource[sender.tag];
    _payView.lastPriceLab.text = [NSString stringWithFormat:@"%@",model.price];
    _payView.videoprice.text = [NSString stringWithFormat:@"%@",model.price];
    [_payView.videoImg sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"bigimage"]];
    _payView.titleLab.text = model.name;
    _payView.layer.cornerRadius = 3;
    _payView.layer.masksToBounds = YES;
    _ordernum = model.ordernum;
    [[Config Instance] saveOrderNum:model.ordernum];
    _payView.frame = CGRectMake(0, ScreenHeight*0.7, ScreenWidth, ScreenHeight * 0.3);
    _shadowBtn.frame = CGRectMake(0, -ScreenHeight * 0.3, ScreenWidth, ScreenHeight);
  
    
    [UIView commitAnimations];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1){
        MineWaitPayModel * model = [[MineWaitPayModel alloc] init];
        model = _dataSource[index - 10];
[[MyAPI sharedAPI] cancelOrderWithOrdernum:model.ordernum result:^(BOOL sucess, NSString *msg) {
    if (sucess) {
        [self showHint:msg];
        [_dataSource removeObjectAtIndex:index-10];
        [_tableView reloadData];
    }else{
        if([msg isEqualToString:@"-1"]){
            [self logOut];
        }else{
        [self showHint:msg];
        }
    }
    
} errorResult:^(NSError *enginerError) {
    
}];
      
    }
}

//确认付款落下
-(void)down{
    _shadowBtn.hidden = YES;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    _payView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight * 0.65);
    [UIView commitAnimations];
}

#pragma mark- privatemethod
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

//退回到上级界面
- (IBAction)back:(id)sender {
    self.navigationController.navigationBarHidden = YES;
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
