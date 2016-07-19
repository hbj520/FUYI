//
//  MyOrderWaitPayViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/6/28.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MyOrderWaitPayViewController.h"
#import "PersonalWaitPayTableViewCell.h"
#import "PayView.h"
#import "MineWaitPayModel.h"
#import "MyAPI.h"
@interface MyOrderWaitPayViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    UITableView * _tableView;
    NSMutableArray * _dataSource; //待付款的数据
    PayView* _payView;
    UIButton* _shadowBtn;
}
@end

@implementation MyOrderWaitPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerNib:[UINib
                            nibWithNibName:@"PersonalWaitPayTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyOrderId"];
    

    [self.view addSubview:_tableView];

    [self loadData];
    
    [self creatHidePayView];
}

//加载数据
- (void)loadData
{
    [[MyAPI sharedAPI] requestWaitpayDataWithParameters:@"" result:^(BOOL success, NSString *msg, NSMutableArray *arrays) {
        if(success){
            _dataSource = arrays;
        }
        else{
            [self logOut];
        }
    } errorResult:^(NSError *enginerError) {
        
    }];
    
}

-(void)creatHidePayView{
    
    _payView = [[[NSBundle mainBundle]loadNibNamed:@"PayView" owner:self options:nil]lastObject];;
    _payView.titleLab.text = @"付款详情";
    _payView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight * 0.65);
    [_payView.downBtn addTarget:self action:@selector(down) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_payView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
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
    return 10;
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
   
    return cell;
}

//点击取消订单
- (void)clickCancelBtn:(UIButton*)sender
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"确认删除订单？" message:@"删除之后可以从电脑端订单回收站恢复" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alertView show];
    NSLog(@"%ld",(long)sender.tag);
}

//点击确定付款
- (void)clickSureBtn:(UIButton*)sender
{
    _shadowBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _shadowBtn.backgroundColor = [UIColor blackColor];
    [_shadowBtn addTarget:self action:@selector(down) forControlEvents:UIControlEventTouchUpInside];
    _shadowBtn.alpha = 0.5;
    [self.view addSubview:_shadowBtn];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    _payView.frame = CGRectMake(0, ScreenHeight*0.35, ScreenWidth, ScreenHeight * 0.65);
    _shadowBtn.frame = CGRectMake(0, -ScreenHeight * 0.65, ScreenWidth, ScreenHeight);
    
    [UIView commitAnimations];

    NSLog(@"%ld",(long)sender.tag);
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1){
        
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
