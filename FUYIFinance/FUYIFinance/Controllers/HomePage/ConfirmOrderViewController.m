//
//  ConfirmOrderViewController.m
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/7/5.
//  Copyright © 2016年 youyou. All rights reserved.
//

//view
#import "CustomBtn.h"

#import "ConInfoTableViewCell.h"
#import "VideoInfoTableViewCell.h"
#import "BuyCountTableViewCell.h"
#import "DeliverMethodTableViewCell.h"
#import "NoticeTableViewCell.h"
#import "PayView.h"

#import "ConfirmOrderViewController.h"

@interface ConfirmOrderViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    PayView* _payView;
    UIButton* _shadowBtn;
}
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
    [self creatHidePayView];

}
//弹出视图
-(void)creatHidePayView{

     _payView = [[[NSBundle mainBundle]loadNibNamed:@"PayView" owner:self options:nil]lastObject];
    _payView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 430);
    [_payView.downBtn addTarget:self action:@selector(down) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_payView];
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
            }if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            VideoInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"videoInfoCellReuseID" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }if (indexPath.row == 1) {
           BuyCountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"buyerCountCellReuseID" forIndexPath:indexPath];
            [cell.plusBtn addTarget:self action:@selector(changeCount:) forControlEvents:UIControlEventTouchUpInside];
            [cell.minusBtn addTarget:self action:@selector(changeCount:) forControlEvents:UIControlEventTouchUpInside];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }if (indexPath.row == 2) {
            NoticeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"noticeCellReuseID" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            DeliverMethodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"deliMethodCellReuseID" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    return nil;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UILabel* videoLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
        videoLab.text = @"    高清讲座视频";
        videoLab.font = [UIFont systemFontOfSize:14];
        return videoLab;
    }else{
        return nil;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 12)];
        view.backgroundColor = RGBACOLOR(244, 244, 244, 1);
        return view;
    }else{
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        return 40;
    }else{
        return 0;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    if (section == 0) {
        return 12;
    }else{
        return 0;
    }
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

//数量
- (void)changeCount:(UIButton*)button{
    NSLog(@"加减");
    BuyCountTableViewCell* buyCell = (BuyCountTableViewCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    int a = [buyCell.countText.text intValue];
    if (button.tag == 10) {
 
        if (a < 2) {
            return;
        }else{
            a = a - 1;
        }
         buyCell.countText.text = [NSString stringWithFormat:@"%d",a];
        
    }else if (button.tag == 100){
        a = a + 1;
    }
    buyCell.countText.text = [NSString stringWithFormat:@"%d",a];
}


//确认付款弹出
- (IBAction)buyNow:(id)sender {
    NSLog(@"弹出");
    _shadowBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _shadowBtn.backgroundColor = [UIColor blackColor];
    [_shadowBtn addTarget:self action:@selector(down) forControlEvents:UIControlEventTouchUpInside];
    _shadowBtn.alpha = 0.5;
    [self.view addSubview:_shadowBtn];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    _payView.frame = CGRectMake(0, ScreenHeight-430, ScreenWidth, 430);
    _shadowBtn.frame = CGRectMake(0, -430, ScreenWidth, ScreenHeight);
    [UIView commitAnimations];
}

//确认付款落下
-(void)down{
    _shadowBtn.hidden = YES;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    _payView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 430);
    [UIView commitAnimations];
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
