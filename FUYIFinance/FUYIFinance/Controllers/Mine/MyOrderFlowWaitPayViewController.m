//
//  MyOrderFlowWaitPayViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/8/23.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MyOrderFlowWaitPayViewController.h"
#import "MyAPI.h"
@interface MyOrderFlowWaitPayViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
    NSMutableArray * dataSource;
    
}

@end

@implementation MyOrderFlowWaitPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dataSource = [NSMutableArray array];
    [self createUI];
    //[self loadData];
}

- (void)createUI
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 100) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
   // _tableView.delegate = self;
   // _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (void)loadData
{
    [[MyAPI sharedAPI] getOrderFlowDataWithIdentify:@"2" Result:^(BOOL success, NSString *msg, NSMutableArray *arrays) {
       
    } ErrorResult:^(NSError *enginerError) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
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
