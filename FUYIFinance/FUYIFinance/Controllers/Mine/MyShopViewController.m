//
//  MyShopViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/4.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MyShopViewController.h"
#import "MyShopHeaderTableViewCell.h"
#import "ShopTopTableViewCell.h"
#import "FourBtnTableViewCell.h"
#import "MyShopDetailTableViewCell.h"
#import "BBBadgeBarButtonItem.h"

@interface MyShopViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
    BBBadgeBarButtonItem * _chatBtn;
    BBBadgeBarButtonItem * _chatBtn1;

}
@end

@implementation MyShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addChatBtn];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"MyShopHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID1"];
    [_tableView registerNib:[UINib nibWithNibName:@"ShopTopTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID2"];
    [_tableView registerNib:[UINib nibWithNibName:@"FourBtnTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID3"];
    [_tableView registerNib:[UINib nibWithNibName:@"MyShopDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID4"];
    [self.view addSubview:_tableView];
    
}

- (void)addChatBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 31, 27);
    [btn setImage:[UIImage imageNamed:@"messageBtn"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(chatAct:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 0, 22, 22);
    [btn1 setImage:[UIImage imageNamed:@"barimage"] forState:UIControlStateNormal];
    
    _chatBtn = [[BBBadgeBarButtonItem alloc] initWithCustomUIButton:btn];
    _chatBtn.badgeFont = [UIFont systemFontOfSize:10.0f];
    _chatBtn.badgeOriginX = 15.5;
    _chatBtn.badgeOriginY = -2.5;
    _chatBtn.badgePadding = 2;
    _chatBtn.badgeValue = @"0";
    
    _chatBtn1 = [[BBBadgeBarButtonItem alloc] initWithCustomUIButton:btn1];
    _chatBtn1.badgeFont = [UIFont systemFontOfSize:10.0f];
    _chatBtn1.badgeOriginX = 15.5;
    _chatBtn1.badgeOriginY = -2.5;
    _chatBtn1.badgePadding = 2;
    _chatBtn1.badgeValue = @"0";
    
    NSMutableArray *arryBtn = [NSMutableArray arrayWithObjects:_chatBtn,_chatBtn1, nil];
    self.navigationItem.rightBarButtonItems = arryBtn;
}

- (void)chatAct:(id)sender{
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else if (section==1){
        return 1;
    }else if (section==2){
        return 1;
    }else{
        return 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 135;
    }else if (indexPath.section==1){
        return 40;
    }else if (indexPath.section==2){
        return 110;
    }else{
        return 95;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else if (section==1){
        return 1;
    }else if (section==2){
        return 8;
    }else{
        return 8;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        MyShopHeaderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID1" forIndexPath:indexPath];
        return cell;
    }else if (indexPath.section==1){
        ShopTopTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID2" forIndexPath:indexPath];
        return cell;
    }else if (indexPath.section==2){
        FourBtnTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID3" forIndexPath:indexPath];
        __weak MyShopViewController * weakself = self;
        
        cell.publishBlock = ^(){
            [weakself publishTreasure];
        };
        
        cell.treasureManageBlock = ^(){
            [weakself treasureManage];
        };
        
        cell.orderManageBlock = ^(){
            [weakself orderManage];
        };
        
        cell.shopSettingBlock = ^(){
            [weakself shopManage];
        };
        
        return cell;
    }else{
        MyShopDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID4" forIndexPath:indexPath];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//发布宝贝
- (void)publishTreasure
{
    [self performSegueWithIdentifier:@"publishtreasureSegue" sender:nil];
}

//宝贝管理
- (void)treasureManage
{
    [self performSegueWithIdentifier:@"treasureSegue" sender:nil];
}

//订单管理
- (void)orderManage
{
    
}

//店铺设置
- (void)shopManage
{
    [self performSegueWithIdentifier:@"shopsettingSegue" sender:nil];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

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