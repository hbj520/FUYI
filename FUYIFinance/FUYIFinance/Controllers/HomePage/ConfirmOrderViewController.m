//
//  ConfirmOrderViewController.m
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/7/5.
//  Copyright © 2016年 youyou. All rights reserved.
//

//view
#import "ConInfoTableViewCell.h"
#import "VideoInfoTableViewCell.h"
#import "BuyCountTableViewCell.h"
#import "DeliverMethodTableViewCell.h"
#import "NoticeTableViewCell.h"

#import "ConfirmOrderViewController.h"

@interface ConfirmOrderViewController ()<UITableViewDataSource,UITabBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ConfirmOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatUI];

}

- (void)creatUI{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
        [self.tableView registerNib:[UINib nibWithNibName:@"ConInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"confirmInfoCellReuseID"];
        [self.tableView registerNib:[UINib nibWithNibName:@"VideoInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"videoInfoCellReuseID"];
        [self.tableView registerNib:[UINib nibWithNibName:@"BuyCountTableViewCell" bundle:nil] forCellReuseIdentifier:@"buyerCountCellReuseID"];
        [self.tableView registerNib:[UINib nibWithNibName:@"DeliverMethodTableViewCell" bundle:nil] forCellReuseIdentifier:@"deliMethodCellReuseID"];
        [self.tableView registerNib:[UINib nibWithNibName:@"NoticeTableViewCell" bundle:nil] forCellReuseIdentifier:@"noticeCellReuseID"];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
  
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
 
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 4;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        ConInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"confirmInfoCellReuseID" forIndexPath:indexPath];
        return cell;
    }if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            VideoInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"videoInfoCellReuseID" forIndexPath:indexPath];
            return cell;
        }if (indexPath.row == 1) {
            BuyCountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"buyerCountCellReuseID" forIndexPath:indexPath];
            return cell;
        }if (indexPath.row == 2) {
            NoticeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"noticeCellReuseID" forIndexPath:indexPath];
            return cell;
        }else{
            DeliverMethodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"deliMethodCellReuseID" forIndexPath:indexPath];
            return cell;
        }
    }
    
    return nil;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UILabel* videoLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, <#CGFloat height#>);
        
    }
 
    
    
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    
    
}


    
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 160;
    }else{
        if (indexPath.row == 0) {
            return 130;
        }else{
            return 55;
        }
    }

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
