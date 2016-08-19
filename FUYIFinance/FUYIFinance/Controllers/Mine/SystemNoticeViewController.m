//
//  SystemNoticeViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/8/8.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "SystemNoticeViewController.h"
#import "NoticeListTableViewCell.h"
#import "SystemNoticeModel.h"
#import "MyAPI.h"
@interface SystemNoticeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger page;
    NSMutableArray * dataSource;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SystemNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
    [self loadData];
}

//搭设界面
- (void)createUI
{
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"NoticeListTableViewCell" bundle:nil] forCellReuseIdentifier:@"NoticeId"];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
}


//加载数据
- (void)loadData
{
    dataSource = [NSMutableArray array];
    [[MyAPI sharedAPI] requestSystemNoticeWithResult:^(BOOL success, NSString *msg, NSMutableArray *arrays) {
        if(success){
            [dataSource addObjectsFromArray:arrays];
        }
        [self.tableView reloadData];
    } ErrorResult:^(NSError *enginerError) {
        
    }];
}

#pragma mark-TableViewDelegate
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
    static NSString * cellId = @"NoticeId";
    NoticeListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    SystemNoticeModel * model = [[SystemNoticeModel alloc] init];
    model = dataSource[indexPath.row];
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
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
