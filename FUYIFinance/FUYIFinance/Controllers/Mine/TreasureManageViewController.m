//
//  TreasureManageViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/6/30.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "TreasureManageViewController.h"
#import "BBBadgeBarButtonItem.h"
#import "LoveManageTableViewCell.h"

@interface TreasureManageViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    NSIndexPath * indexpath;
    BBBadgeBarButtonItem * _chatBtn;  //自定义的导航栏按钮
    BBBadgeBarButtonItem * _chatBtn1; //自定义的导航栏按钮
}
@end

@implementation TreasureManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addChatBtn];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"LoveManageTableViewCell" bundle:nil] forCellReuseIdentifier:@"TreasureId"];
    [self.view addSubview:_tableView];
    
}

- (void)addChatBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 31, 27);
    [btn setImage:[UIImage imageNamed:@"messageBtn"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(chatAct:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 0, 20, 20);
    [btn1 setImage:[UIImage imageNamed:@"barimage"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(clickBtn1) forControlEvents:UIControlEventTouchUpInside];
    
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

//点击消息
- (void)chatAct:(id)sender{
    
}

//点击环状
- (void)clickBtn1
{
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LoveManageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TreasureId" forIndexPath:indexPath];
    cell.modifyBtn.tag = indexPath.section;
    [cell.modifyBtn addTarget:self action:@selector(clickmodifyBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.deleteBtn.tag = 100 + indexPath.section;
    [cell.deleteBtn addTarget:self action:@selector(clickdeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

//点击编辑宝贝按钮
- (void)clickmodifyBtn:(UIButton*)sender
{
    //跳转到编辑宝贝
    [self performSegueWithIdentifier:@"modifySegue" sender:nil];
}

//点击删除宝贝按钮
- (void)clickdeleteBtn:(UIButton*)sender
{
    
 
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

//退回到上级界面
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
