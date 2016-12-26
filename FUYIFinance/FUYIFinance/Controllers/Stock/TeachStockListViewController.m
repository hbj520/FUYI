//
//  TeachStockListViewController.m
//  FUYIFinance
//
//  Created by youyou on 16/12/12.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "TeachStockListViewController.h"
#import "TeachStockAnalyzeTableViewCell.h"
@interface TeachStockListViewController ()
<UITableViewDataSource,
UITableViewDelegate>
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
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TeachStockAnalyzeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:teachStockReuseId forIndexPath:indexPath];
    [cell configWith];
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
