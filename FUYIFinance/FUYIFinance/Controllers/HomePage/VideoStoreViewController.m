//
//  VideoStoreViewController.m
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/7/4.
//  Copyright © 2016年 youyou. All rights reserved.
//

//view
#import "VideoStoreTableViewCell.h"


#import "VideoStoreViewController.h"
#import "VideoDetailViewController.h"


@interface VideoStoreViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation VideoStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatUI];
    
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = NO;
}
//返回首页
- (IBAction)back:(id)sender {
     [self.navigationController popViewControllerAnimated:YES];
}

-(void)creatUI{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"VideoStoreTableViewCell" bundle:nil] forCellReuseIdentifier:@"VideoStoreCellReuseID"];
    self.tableView.rowHeight = 115;
    
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VideoStoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoStoreCellReuseID" forIndexPath:indexPath];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"====");
    [self performSegueWithIdentifier:@"videoDetailSegue" sender:nil];
   
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
