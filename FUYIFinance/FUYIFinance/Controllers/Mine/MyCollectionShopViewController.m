//
//  MyCollectionShopViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/6/29.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MyCollectionShopViewController.h"
#import "MyCollectionShopTableViewCell.h"

@interface MyCollectionShopViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
}
@end

@implementation MyCollectionShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64 - 45) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.showsVerticalScrollIndicator = NO;
    [_tableView registerNib:[UINib nibWithNibName:@"MyCollectionShopTableViewCell" bundle:nil] forCellReuseIdentifier:@"ColectionShopId"];
    [self.view addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 73;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionShopTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ColectionShopId" forIndexPath:indexPath];
    return cell;
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
