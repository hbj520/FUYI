//
//  StockViewController.m
//  FUYIFinance
//
//  Created by youyou on 16/12/12.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "StockViewController.h"
#import "StockTableViewCell.h"
#import "StockRecommendListModel.h"
@interface StockViewController ()
<UITableViewDelegate,
UITableViewDataSource>
{
    NSMutableArray *dataSource;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation StockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self configTableView];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   // [self loadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - PrivateMethod
- (void)loadData{
    [[MyAPI sharedAPI] getStockInvestRecommentListWithPage:@"1" Result:^(BOOL success, NSString *msg, NSMutableArray *arrays) {
        if (success) {
            dataSource = [NSMutableArray arrayWithArray:arrays];
            [self.tableView reloadData];
        }
    } errorResult:^(NSError *enginerError) {
        
    }];
}
- (void)configTableView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"StockTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:stockReuseId];
}
#pragma mark -UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    StockTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stockReuseId forIndexPath:indexPath];
    StockRecommendListModel *model = [dataSource objectAtIndex:indexPath.row];
    [cell configWithData:model];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 125.;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"teachStockSegueId" sender:nil];
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
