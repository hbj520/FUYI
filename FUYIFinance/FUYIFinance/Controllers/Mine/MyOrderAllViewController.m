//
//  MyOrderAllViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/6/28.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MyOrderAllViewController.h"
#import "UIViewController+HUD.h"
#import "PersonalWaitPayTableViewCell.h"
#import "PersonalWaitJudgeTableViewCell.h"
#import "MyJudgeTableViewCell.h"
#import "AllOderModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <MJRefresh/MJRefresh.h>
#import "LabelHelper.h"
#import "Tools.h"
#import "PayView.h"
#import "ZCTradeView.h"
#import "MyAPI.h"

@interface MyOrderAllViewController ()<ZCTradeViewDelegate,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    UITableView * _tableView;
    NSMutableArray * waitjudgeArray;
    NSMutableArray * waitpayArray;
    NSMutableArray * isjudgeArray;
    NSInteger page;
    NSInteger index;
    NSString * _ordernum;
    PayView* _payView;
    ZCTradeView * _tradeView;
    UIButton* _shadowBtn;
    NSInteger sectionCout;
}
@end

@implementation MyOrderAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"PersonalWaitPayTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyOrderId"];
    [_tableView registerNib:[UINib nibWithNibName:@"PersonalWaitJudgeTableViewCell" bundle:nil] forCellReuseIdentifier:@"WaitJudgeId"];
    [_tableView registerNib:[UINib nibWithNibName:@"MyJudgeTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyJudgeId"];
    
    [self.view addSubview:_tableView];
    waitjudgeArray = [NSMutableArray array];
    waitpayArray = [NSMutableArray array];
    isjudgeArray = [NSMutableArray array];
    page = 1;
    [self loadData];
    [self addRefresh];
    _tradeView = [[ZCTradeView alloc] init];
    _tradeView.delegate = self;
    [self creatHidePayView];
}

- (void)addRefresh
{
    __weak MyOrderAllViewController * weakself = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        page = 0;
       
        if(waitjudgeArray.count>0){
            [waitjudgeArray removeAllObjects];
        }
        if(waitpayArray.count>0){
            [waitpayArray removeAllObjects];
        }
        if(isjudgeArray.count>0){
            [isjudgeArray removeAllObjects];
        }
        [weakself loadData];
        
    }];
    MJRefreshAutoNormalFooter * footerRefresh = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page++;
        [weakself loadData];
    }];
    footerRefresh.automaticallyRefresh = NO;
    _tableView.mj_footer = footerRefresh;
}

-(void)creatHidePayView{
    
    _payView = [[[NSBundle mainBundle]loadNibNamed:@"PayView" owner:self options:nil]lastObject];;
    _payView.titleLab.text = @"付款详情";
    _payView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight * 0.65);
    [_payView.downBtn addTarget:self action:@selector(down) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_payView];
}

- (void)loadData
{
    NSString * pagestr = [NSString stringWithFormat:@"%ld",page];
    [[MyAPI sharedAPI] requestAllOrderDataWithParameters:pagestr result:^(BOOL success, NSString *msg, NSMutableArray *arrays) {
        if([msg isEqualToString:@"-1"]){
            [self logOut];
        }

        if(success){
            for(AllOderModel * model in arrays){
                if([model.state isEqualToString:@"0"]){
                    [waitpayArray addObject:model];
                    if (waitpayArray.count > 0) {
                        sectionCout++;
                    }
                }else if ([model.state isEqualToString:@"1"]){
                    [waitjudgeArray addObject:model];
                    if (waitjudgeArray.count > 0) {
                        sectionCout++;
                    }
                }else{
                    [isjudgeArray addObject:model];
                    if (isjudgeArray.count > 0) {
                        sectionCout++;
                    }
                }
            }
            [_tableView reloadData];
            [_tableView.mj_header endRefreshing];
            [_tableView.mj_footer endRefreshing];
        }else{
          
        }
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        
    } errorResult:^(NSError *enginerError) {
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    }];
    
    /**
     *    if([msg isEqualToString:@"-1"]){
     [self logOut];
     }
     if(success){
     [dataSource addObjectsFromArray:arrays];
     [_tableView reloadData];
     }else{
     
     }
     [_tableView.mj_header endRefreshing];
     [_tableView.mj_footer endRefreshing];
     
     } errorResult:^(NSError *enginerError) {
     [_tableView.mj_header endRefreshing];
     [_tableView.mj_footer endRefreshing];
     }];
     

     *
     *  @param NSInteger <#NSInteger description#>
     *
     *  @return <#return value description#>
     */
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        return waitpayArray.count;
    }else if (section == 1){
        return waitjudgeArray.count;
    }else{
        return isjudgeArray.count;
    }

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return sectionCout;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        PersonalWaitPayTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyOrderId" forIndexPath:indexPath];
        cell.cancelBtn.tag = 10 + indexPath.row;
        cell.sureBtn.tag = indexPath.row;
        [cell.sureBtn addTarget:self action:@selector(PayOrder:) forControlEvents:UIControlEventTouchUpInside];
        [cell.cancelBtn addTarget:self action:@selector(CancelOrdernum:) forControlEvents:UIControlEventTouchUpInside];
        AllOderModel * model = [[AllOderModel alloc] init];
        model = waitpayArray[indexPath.row];
        [cell.thumbImage sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"placeimage"]];
        cell.shopname.text = model.shopname;
        cell.titlename.text = model.name;
        NSString * pricelabel = [NSString stringWithFormat:@"¥%@",model.price];
        cell.price.text = pricelabel;
        NSString * teacherlabel = [NSString stringWithFormat:@"讲师：%@",model.teacher];
        cell.teachername.text = teacherlabel;
       cell.totalPrice.attributedText = [[LabelHelper alloc] attributedStringWithString:pricelabel];
        return cell;
    }else if(indexPath.section == 1){
        PersonalWaitJudgeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WaitJudgeId" forIndexPath:indexPath];
        AllOderModel * model = [[AllOderModel alloc] init];
        model = waitjudgeArray[indexPath.row];
        [cell.thumbImage sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"placeimage"]];
        cell.shopname.text = model.shopname;
        cell.title.text = model.name;
        NSString * teacherlabel = [NSString stringWithFormat:@"讲师：%@",model.teacher];
        cell.teacherName.text = teacherlabel;
        NSString * pricelabel = [NSString stringWithFormat:@"¥%@",model.price];
        cell.price.text = pricelabel;
        cell.totalPrice.attributedText = [[LabelHelper alloc] attributedStringWithString:pricelabel];
        return cell;
    }else{
        MyJudgeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyJudgeId" forIndexPath:indexPath];
        AllOderModel * model = [[AllOderModel alloc] init];
        model = isjudgeArray[indexPath.row];
        [cell.thumbimage sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"placeimage"]];
        cell.titlename.text = model.name;
        cell.timelabel.text = model.ctime;
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 2){
        return 80;
    }
    else{
    return 217;
    }
}

- (void)CancelOrdernum:(UIButton *)sender
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"确认删除订单？" message:@"删除之后可以从电脑端订单回收站恢复" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alertView show];
    index = sender.tag;
 
}

- (void)PayOrder:(UIButton *)sender
{
    _shadowBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _shadowBtn.backgroundColor = [UIColor blackColor];
    [_shadowBtn addTarget:self action:@selector(down) forControlEvents:UIControlEventTouchUpInside];
    _shadowBtn.alpha = 0.5;
    [self.view addSubview:_shadowBtn];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    AllOderModel * model = [[AllOderModel alloc] init];
    model = waitpayArray[sender.tag];
    _payView.lastPriceLab.text = model.price;
    _ordernum = model.ordernum;
    [_payView.payBtn addTarget:sender action:@selector(payaction) forControlEvents:UIControlEventTouchUpInside];
    _payView.frame = CGRectMake(0, ScreenHeight*0.35- 100, ScreenWidth, ScreenHeight * 0.65);
    _shadowBtn.frame = CGRectMake(0, -ScreenHeight * 0.65- 100, ScreenWidth, ScreenHeight);
    
    [UIView commitAnimations];
    

}

- (void)payaction
{
    [_tradeView show];
}

- (NSString *)finish:(NSString *)pwd
{
    NSString * SecurityString = [Tools loginPasswordSecurityLock:pwd];
    [[MyAPI sharedAPI] payOrderWithOrderNum:_ordernum Excode:SecurityString Result:^(BOOL sucess, NSString *msg) {
        if(sucess){
            [self showHint:@"付款成功"];
            [waitpayArray removeObjectAtIndex:index];
            [_tableView reloadData];
        }
    } ErrorResult:^(NSError *enginerError) {
        
    }];
    return nil;
}

//确认付款落下
-(void)down{
    _shadowBtn.hidden = YES;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    _payView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight * 0.65);
    [UIView commitAnimations];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1){
        MineWaitPayModel * model = [[MineWaitPayModel alloc] init];
        model = waitpayArray[index - 10];
         _ordernum = model.ordernum;
        [[MyAPI sharedAPI] cancelOrderWithOrdernum:_ordernum result:^(BOOL sucess, NSString *msg) {
            if(sucess){
                [self showHint:@"取消订单成功"];
                [waitpayArray removeObjectAtIndex:index-10];
                [_tableView reloadData];
            }
        } errorResult:^(NSError *enginerError) {
            
        }];
        
    }
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
