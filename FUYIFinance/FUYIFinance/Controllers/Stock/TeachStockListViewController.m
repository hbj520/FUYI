//
//  TeachStockListViewController.m
//  FUYIFinance
//
//  Created by youyou on 16/12/12.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "TeachStockListViewController.h"
#import "TeachStockAnalyzeTableViewCell.h"
#import "StockRecommendListDetailModel.h"
@interface TeachStockListViewController ()
<UITableViewDataSource,
UITableViewDelegate>
{
    NSMutableArray *todayDataSource;
    NSMutableArray *historyDataSource;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *lastTimeTableView;
- (IBAction)backBtn:(id)sender;

@end

@implementation TeachStockListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configTableView];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -PrivateMethod
- (void)loadData{
    [[MyAPI sharedAPI] getStockTeacherAnlyzeListWithTeachId:self.teachId teachName:self.teachName result:^(BOOL success, NSString *msg, NSMutableArray *arrays) {
        if (success) {
            todayDataSource = [NSMutableArray arrayWithArray:arrays[0]];
            historyDataSource = [NSMutableArray arrayWithArray:arrays[1]];
            [self.tableView reloadData];
            [self.lastTimeTableView reloadData];
        }
    } errorResult:^(NSError *enginerError) {
        
    }];
}
- (void)configTableView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"TeachStockAnalyzeTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:teachStockReuseId];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.lastTimeTableView.delegate = self;
    self.lastTimeTableView.dataSource = self;
    [self.lastTimeTableView registerNib:[UINib nibWithNibName:@"TeachStockAnalyzeTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:teachStockReuseId];
    self.lastTimeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}
#pragma mark -UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tableView) {
        return todayDataSource.count;
    }else if (tableView == self.lastTimeTableView){
        return historyDataSource.count;
    }
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TeachStockAnalyzeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:teachStockReuseId forIndexPath:indexPath];
    StockRecommendListDetailModel *model;
    if (tableView == self.tableView) {
       model = [todayDataSource objectAtIndex:indexPath.row ];

    }else if (tableView == self.lastTimeTableView){
        model = [historyDataSource objectAtIndex:indexPath.row ];

    }
    [cell configWithData:model];
    cell.clickZanBlock=^(BOOL isSelect){
        NSInteger suppportCount =   model.supportCount.integerValue;
        if (isSelect) {
            suppportCount++;
            [[MyAPI sharedAPI] supportOrAgainstStockRecommendSupport:@"1" stock_rec_id:model.stockId result:^(BOOL sucess, NSString *msg) {
                
            } errorResult:^(NSError *enginerError) {
                
            }];
        }else{
            suppportCount--;
 
        }
        model.supportCount = [NSString stringWithFormat:@"%ld",suppportCount];

        [cell configWithData:model];

    };
    cell.clickAgainstBlock=^(BOOL isSelect){
        NSInteger unsuppportCount =   model.supportCount.integerValue;
        if (isSelect) {
            unsuppportCount++;

            [[MyAPI sharedAPI] supportOrAgainstStockRecommendSupport:@"0" stock_rec_id:model.stockId result:^(BOOL sucess, NSString *msg) {
                
            } errorResult:^(NSError *enginerError) {
                
            }];
        }else{
            unsuppportCount--;
        }
        model.opposeCount = [NSString stringWithFormat:@"%ld",unsuppportCount];
        [cell configWithData:model];

    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120.;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"stockDetailSegueId" sender:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
