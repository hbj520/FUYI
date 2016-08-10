//
//  OrderManageViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/8/3.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "OrderManageViewController.h"
#import "MyShopDetailTableViewCell.h"
#import "OrderManageModel.h"
#import "MyAPI.h"
@interface OrderManageViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray * dataSource;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation OrderManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dataSource = [NSMutableArray array];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self createUI];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)createUI
{
   self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"MyShopDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID4"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)loadData
{
    [[MyAPI sharedAPI] requestOrderManageRequestWithResult:^(BOOL success, NSString *msg, NSMutableArray *arrays) {
        dataSource = arrays;
        [_tableView reloadData];
    } errorResult:^(NSError *enginerError) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"cellID4";
    MyShopDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    OrderManageModel * model = [[OrderManageModel alloc] init];
    model = dataSource[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (IBAction)back:(id)sender {
    self.navigationController.navigationBarHidden = NO;
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
