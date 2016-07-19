//
//  MyCollectionCourseViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/6/29.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MyCollectionCourseViewController.h"
#import "MyCollectionTableViewCell.h"
#import "MineCollectionTreasureModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MyAPI.h"

@interface MyCollectionCourseViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
    NSMutableArray * dataSource;
}
@end

@implementation MyCollectionCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 100) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"MyCollectionTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyCollectionId"];
    [self.view addSubview:_tableView];
    [self loadData];
}

//加载数据
- (void)loadData
{
    [[MyAPI sharedAPI] requestCollectionTreasureDataWithParameters:@"" result:^(BOOL success, NSString *msg, NSMutableArray *arrays) {
        dataSource = [NSMutableArray array];
        if(success){
            dataSource = arrays;
            [_tableView reloadData];
        }else{
            [self logOut];
        }
    } errorResult:^(NSError *enginerError) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 107;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyCollectionId" forIndexPath:indexPath];
    MineCollectionTreasureModel * model = [[MineCollectionTreasureModel alloc] init];
    model = dataSource[indexPath.section];
    [cell.thumbimage sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:NULL];
    cell.titlename.text = model.name;
    cell.teachername.text = model.teacher;
    NSString * price = [NSString stringWithFormat:@"%@.00",model.price];
    cell.pricelabel.text = price;
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
