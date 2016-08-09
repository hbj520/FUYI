//
//  OrderInfoViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/8/8.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "OrderInfoViewController.h"
#import "OrderNoticeTableViewCell.h"
#import "OrderNoticeModel.h"
#import "MyAPI.h"
@interface OrderInfoViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * dataSource;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation OrderInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
    [self loadData];
    }

- (void)createUI
{
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"OrderNoticeTableViewCell" bundle:nil] forCellReuseIdentifier:@"OrderId"];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (void)loadData
{
    dataSource = [NSMutableArray array];
    [[MyAPI sharedAPI] requestOrderNoticeWithResult:^(BOOL success, NSString *msg, NSMutableArray *arrays) {
        if(success){
        [dataSource addObjectsFromArray:arrays];
        }
        [self.tableView reloadData];
    } ErrorResult:^(NSError *enginerError) {
        
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"OrderId";
    OrderNoticeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    OrderNoticeModel * model = [[OrderNoticeModel alloc] init];
    model = dataSource[indexPath.row];
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

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
