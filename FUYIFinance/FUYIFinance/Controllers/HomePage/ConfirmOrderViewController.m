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
#import "ZCTradeView.h"
#import "StoreDataModel.h"
#import "UIViewController+HUD.h"
#import "ConfirmOrderViewController.h"
#import "MyOrderAllViewController.h"
#import "XLPasswordView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Config.h"
#import "Tools.h"
#import "LabelHelper.h"
#import "MyAPI.h"

@interface ConfirmOrderViewController ()<XLPasswordViewDelegate,ZCTradeViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    PayView* _payView;
    UIButton* _shadowBtn;
    ZCTradeView * _tradeView;
    int a;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation ConfirmOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatUI];
    a = 1;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.hidesBottomBarWhenPushed = YES;
  //  self.bottomView.hidden = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideBottomBar) name:@"hidebottom" object:nil];
    //self.navigationController.navigationBar.hidden = NO;
}
- (void)hideBottomBar
{
    self.bottomView.hidden = YES;
}

- (void)creatUI{
    self.view.tag = 10;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
        [self.tableView registerNib:[UINib nibWithNibName:@"ConInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"confirmInfoCellReuseID"];
        [self.tableView registerNib:[UINib nibWithNibName:@"VideoInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"videoInfoCellReuseID"];
        [self.tableView registerNib:[UINib nibWithNibName:@"BuyCountTableViewCell" bundle:nil] forCellReuseIdentifier:@"buyerCountCellReuseID"];
        [self.tableView registerNib:[UINib nibWithNibName:@"DeliverMethodTableViewCell" bundle:nil] forCellReuseIdentifier:@"deliMethodCellReuseID"];
        [self.tableView registerNib:[UINib nibWithNibName:@"NoticeTableViewCell" bundle:nil] forCellReuseIdentifier:@"noticeCellReuseID"];
    _tradeView = [[ZCTradeView alloc] init];
    _tradeView.delegate = self;
    [self creatHidePayView];//弹出视图

    self.allPriceLab.attributedText = [[LabelHelper alloc]attributedFontStringWithString:[NSString stringWithFormat:@"¥ %@",_model.videoPrice] firstFont:14 secFont:18 thirdFont:18];//商品数为1时的价格

}
//弹出视图
-(void)creatHidePayView{
     _payView = [[[NSBundle mainBundle]loadNibNamed:@"PayView" owner:self options:nil]lastObject];
    _payView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight*0.65);
    [_payView.downBtn addTarget:self action:@selector(down) forControlEvents:UIControlEventTouchUpInside];
    [_payView.payBtn addTarget:self action:@selector(payaction) forControlEvents:UIControlEventTouchUpInside];
    
    //[_payView.payWayBtn addTarget:self action:@selector(selectBank) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_payView];
}

- (void)payaction
{
//    NSString * SecurityString = [Tools loginPasswordSecurityLock:@"123123"];
//    NSString * ordernum = [[Config Instance] getOrderNum];
//    if(self.ordernum.length > 0&&KToken.length > 0){
//        [[MyAPI sharedAPI] payOrderWithOrderNum:ordernum Excode:SecurityString Result:^(BOOL sucess, NSString *msg) {
//            if(sucess){
//                [self showHint:msg];
//                [self down];
//                UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Mine" bundle:nil];
//                MyOrderAllViewController * VC = (MyOrderAllViewController *)[storyboard instantiateViewControllerWithIdentifier:@"MyOrderStoryBoardID"];
//                [self.navigationController pushViewController:VC animated:YES];
//                
//            }else{
//                [self showHint:msg];
//            }
//        } ErrorResult:^(NSError *enginerError) {
//            
//        }];
//    }

   // [_tradeView show];
    XLPasswordView * passwordView = [XLPasswordView passwordView];
    passwordView.delegate = self;
    
    [passwordView showPasswordInView:self.view];

    
}

- (void)passwordView:(XLPasswordView *)passwordView didFinishInput:(NSString *)password

{
    NSString * SecurityString = [Tools loginPasswordSecurityLock:password];
    NSString * ordernum = [[Config Instance] getOrderNum];
            [[MyAPI sharedAPI] payOrderWithOrderNum:ordernum Excode:SecurityString Result:^(BOOL sucess, NSString *msg) {
                if(sucess){
                    [self showHint:msg];
                    [self down];
                    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Mine" bundle:nil];
                    MyOrderAllViewController * VC = (MyOrderAllViewController *)[storyboard instantiateViewControllerWithIdentifier:@"MyOrderStoryBoardID"];
                    [self.navigationController pushViewController:VC animated:YES];
    
                }else{
                    [self showHint:msg];
                }
            } ErrorResult:^(NSError *enginerError) {
                
            }];
}



//-(NSString *)finish:(NSString *)pwd{
//    NSString * SecurityString = [Tools loginPasswordSecurityLock:pwd];
//    NSString * ordernum = [[Config Instance] getOrderNum];
//    if(self.ordernum.length > 0&&KToken.length > 0){
//    [[MyAPI sharedAPI] payOrderWithOrderNum:ordernum Excode:SecurityString Result:^(BOOL sucess, NSString *msg) {
//        if(sucess){
//            [self showHint:msg];
//            [self down];
//            UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Mine" bundle:nil];
//            MyOrderAllViewController * VC = (MyOrderAllViewController *)[storyboard instantiateViewControllerWithIdentifier:@"MyOrderStoryBoardID"];
//            [self.navigationController pushViewController:VC animated:YES];
//
//        }else{
//            [self showHint:msg];
//        }
//    } ErrorResult:^(NSError *enginerError) {
//        
//    }];
//    }
//    return pwd;
//}
//
#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
 
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 3;
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
            
            [cell.videoImage sd_setImageWithURL:[NSURL URLWithString:_model.videoImage] placeholderImage:[UIImage imageNamed:@"classImageDemo_1"]];
            cell.videoContentLab.text = _model.videoName;
            cell.videoPriceLab.attributedText = [[LabelHelper alloc]attributedFontStringWithString:[NSString stringWithFormat:@"¥ %@",_model.videoPrice] firstFont:14 secFont:18 thirdFont:15];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
   //购买数目cell     }if (indexPath.row == 1) {
//            BuyCountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"buyerCountCellReuseID" forIndexPath:indexPath];
//            
//            [cell.plusBtn addTarget:self action:@selector(changeCount:) forControlEvents:UIControlEventTouchUpInside];
//            [cell.minusBtn addTarget:self action:@selector(changeCount:) forControlEvents:UIControlEventTouchUpInside];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            return cell;
        }if (indexPath.row == 1) {
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
      videoLab.backgroundColor = [UIColor whiteColor];
        
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
        return 3;
    }else{
        if (indexPath.row == 0) {
            return 130;
        }else{
            return 55;
        }
    }
}

/*
//数量
- (void)changeCount:(UIButton*)button{
    NSLog(@"加减");
    BuyCountTableViewCell* buyCell = (BuyCountTableViewCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    a = [buyCell.countText.text intValue];
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
    
  //  NSLog(@"商品数量显示%@",buyCell.countText.text);
   // 商品数量计算价格
    self.allPriceLab.attributedText = [[LabelHelper alloc]attributedFontStringWithString:[NSString stringWithFormat:@"¥ %.2f",[_model.videoPrice floatValue] * [buyCell.countText.text floatValue]] firstFont:14 secFont:18 thirdFont:18];
    
}
*/

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
    _payView.frame = CGRectMake(0, ScreenHeight*0.35, ScreenWidth, ScreenHeight*0.65);
    _payView.lastPriceLab.text = [NSString stringWithFormat:@"%@元",self.allPriceLab.text];
    _shadowBtn.frame = CGRectMake(0, -ScreenHeight*0.65, ScreenWidth, ScreenHeight);
    [UIView commitAnimations];
}

//确认付款落下
-(void)down{
    _shadowBtn.hidden = YES;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    _payView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight*0.65);
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
