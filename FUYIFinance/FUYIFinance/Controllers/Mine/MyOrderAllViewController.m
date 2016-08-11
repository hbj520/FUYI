//
//  MyOrderAllViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/6/28.
//  Copyright © 2016年 youyou. All rights reserved.
//
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFURLResponseSerialization.h>
#import "MyOrderAllViewController.h"
#import "ProductJudgeViewController.h"
#import "UIViewController+HUD.h"
#import "PersonalWaitPayTableViewCell.h"
#import "PersonalWaitJudgeTableViewCell.h"
#import "MyJudgeTableViewCell.h"
#import "AllOderModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <MJRefresh/MJRefresh.h>
#import "LabelHelper.h"
#import "Tools.h"
#import "Config.h"
#import "PayView.h"
#import "ZCTradeView.h"
#import "MyAPI.h"

@interface MyOrderAllViewController ()<
ZCTradeViewDelegate,
UITableViewDelegate,
UITableViewDataSource,
UIAlertViewDelegate>
{
    UITableView * _tableView;
    NSMutableArray * waitjudgeArray;
    NSMutableArray * waitpayArray;
    NSMutableArray * isjudgeArray;
    NSMutableArray * allData;
    NSInteger page;
    NSInteger index;
    NSInteger index1;
    NSString * _ordernum;
    PayView* _payView;
 
    UIButton* _shadowBtn;
    //NSInteger sectionCout;
}
@property (nonatomic,strong)AFHTTPRequestOperationManager * manager;
@end

@implementation MyOrderAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 100) style:UITableViewStylePlain];
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
    allData = [NSMutableArray array];
    page = 1;
    [self loadData];
    [self addRefresh];
    self.tradeView = [[ZCTradeView alloc] init];
   
    self.tradeView.delegate = self;
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
        if (allData.count>0) {
            [allData removeAllObjects];
        }
        [weakself loadData];
        
    }];
//    MJRefreshAutoNormalFooter * footerRefresh = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        page++;
//        [weakself loadData];
//    }];
//    footerRefresh.automaticallyRefresh = NO;
//    _tableView.mj_footer = footerRefresh;
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
                   
                }else if ([model.state isEqualToString:@"1"]){
                    [waitjudgeArray addObject:model];
                }else{
                    [isjudgeArray addObject:model];
                                   }
            }
            if (waitpayArray.count > 0) {
                [allData addObject:waitpayArray];
                //sectionCout++;
            }
            if (waitjudgeArray.count > 0) {
                [allData addObject:waitjudgeArray];
                //sectionCout++;
            }
            if (isjudgeArray.count > 0) {
                [allData addObject:isjudgeArray];
                //sectionCout++;
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
    
  }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    for (NSInteger i = 0; i < allData.count; i ++) {
        NSArray *arry = allData[i];
        if (section == i) {
            return arry.count;
        }
    }

    return 0;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return allData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(allData.count==2){
        if(waitpayArray.count>0&&waitjudgeArray.count>0){
            if(indexPath.section == 0){
                PersonalWaitPayTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyOrderId" forIndexPath:indexPath];
                cell.cancelBtn.tag = 10 + indexPath.row;
                cell.sureBtn.tag = indexPath.row;
                [cell.sureBtn addTarget:self action:@selector(PayOrder:) forControlEvents:UIControlEventTouchUpInside];
                [cell.cancelBtn addTarget:self action:@selector(CancelOrdernum:) forControlEvents:UIControlEventTouchUpInside];
                AllOderModel * model = [[AllOderModel alloc] init];
                model = waitpayArray[indexPath.row];
                [cell.thumbImage sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"myorderthumbimage"]];
                if(!model.shopname.length){
                    cell.shopname.text = @"李小刚的店铺";
                }else{
                    cell.shopname.text = model.shopname;
                }
                cell.titlename.text = model.name;
                NSString * pricelabel = [NSString stringWithFormat:@"¥%@",model.price];
                cell.price.text = pricelabel;
                NSString * teacherlabel = [NSString stringWithFormat:@"讲师：%@",model.teacher];
                cell.teachername.text = teacherlabel;
                cell.totalPrice.attributedText = [[LabelHelper alloc] attributedStringWithString:pricelabel];
                return cell;
   
            }else{
                PersonalWaitJudgeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WaitJudgeId" forIndexPath:indexPath];
                AllOderModel * model = [[AllOderModel alloc] init];
                model = waitjudgeArray[indexPath.row];
                [cell.thumbImage sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"myorderthumbimage"]];
                if(!model.shopname.length){
                    cell.shopname.text = @"斌神的店铺";
                }else{
                    cell.shopname.text = model.shopname;
                }
                cell.title.text = model.name;
                NSString * teacherlabel = [NSString stringWithFormat:@"讲师：%@",model.teacher];
                cell.teacherName.text = teacherlabel;
                NSString * pricelabel = [NSString stringWithFormat:@"¥%@",model.price];
                cell.price.text = pricelabel;
                cell.totalPrice.attributedText = [[LabelHelper alloc] attributedStringWithString:pricelabel];
                __weak MyOrderAllViewController * weakself = self;
                cell.block = ^(NSIndexPath * cellindexpath){
                    cellindexpath = indexPath;
                    [weakself clickjudgeBtnWithIndexpath:cellindexpath];
                };
                
                return cell;
            }
        }else if(waitpayArray.count>0&&isjudgeArray.count>0){
            if(indexPath.section == 0){
                PersonalWaitPayTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyOrderId" forIndexPath:indexPath];
                cell.cancelBtn.tag = 10 + indexPath.row;
                cell.sureBtn.tag = indexPath.row;
                [cell.sureBtn addTarget:self action:@selector(PayOrder:) forControlEvents:UIControlEventTouchUpInside];
                [cell.cancelBtn addTarget:self action:@selector(CancelOrdernum:) forControlEvents:UIControlEventTouchUpInside];
                AllOderModel * model = [[AllOderModel alloc] init];
                model = waitpayArray[indexPath.row];
                [cell.thumbImage sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"myorderthumbimage"]];
                if(!model.shopname.length){
                    cell.shopname.text = @"李小刚的店铺";
                }else{
                    cell.shopname.text = model.shopname;
                }
                cell.titlename.text = model.name;
                NSString * pricelabel = [NSString stringWithFormat:@"¥%@",model.price];
                cell.price.text = pricelabel;
                NSString * teacherlabel = [NSString stringWithFormat:@"讲师：%@",model.teacher];
                cell.teachername.text = teacherlabel;
                cell.totalPrice.attributedText = [[LabelHelper alloc] attributedStringWithString:pricelabel];
                return cell;

            }else{
                MyJudgeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyJudgeId" forIndexPath:indexPath];
                AllOderModel * model = [[AllOderModel alloc] init];
                model = isjudgeArray[indexPath.row];
                [cell.thumbimage sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"myorderthumbimage"]];
                cell.titlename.text = model.name;
                cell.timelabel.text = model.ctime;
                return cell;

            }
        }else{
            if(indexPath.section == 0){
                PersonalWaitJudgeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WaitJudgeId" forIndexPath:indexPath];
                AllOderModel * model = [[AllOderModel alloc] init];
                model = waitjudgeArray[indexPath.row];
                [cell.thumbImage sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"myorderthumbimage"]];
                if(!model.shopname.length){
                    cell.shopname.text = @"斌神的店铺";
                }else{
                    cell.shopname.text = model.shopname;
                }
                cell.title.text = model.name;
                NSString * teacherlabel = [NSString stringWithFormat:@"讲师：%@",model.teacher];
                cell.teacherName.text = teacherlabel;
                NSString * pricelabel = [NSString stringWithFormat:@"¥%@",model.price];
                cell.price.text = pricelabel;
                cell.totalPrice.attributedText = [[LabelHelper alloc] attributedStringWithString:pricelabel];
                __weak MyOrderAllViewController * weakself = self;
                cell.block = ^(NSIndexPath * cellindexpath){
                    cellindexpath = indexPath;
                    [weakself clickjudgeBtnWithIndexpath:cellindexpath];
                };
                
                return cell;
 
            }else{
                MyJudgeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyJudgeId" forIndexPath:indexPath];
                AllOderModel * model = [[AllOderModel alloc] init];
                model = isjudgeArray[indexPath.row];
                [cell.thumbimage sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"myorderthumbimage"]];
                cell.titlename.text = model.name;
                cell.timelabel.text = model.ctime;
                return cell;
            }
        }
    }else if (allData.count == 1){
        if(waitpayArray.count>0){
            PersonalWaitPayTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyOrderId" forIndexPath:indexPath];
            cell.cancelBtn.tag = 10 + indexPath.row;
            cell.sureBtn.tag = indexPath.row;
            [cell.sureBtn addTarget:self action:@selector(PayOrder:) forControlEvents:UIControlEventTouchUpInside];
            [cell.cancelBtn addTarget:self action:@selector(CancelOrdernum:) forControlEvents:UIControlEventTouchUpInside];
            AllOderModel * model = [[AllOderModel alloc] init];
            model = waitpayArray[indexPath.row];
            [cell.thumbImage sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"myorderthumbimage"]];
            if(!model.shopname.length){
                cell.shopname.text = @"李小刚的店铺";
            }else{
            cell.shopname.text = model.shopname;
            }
            cell.titlename.text = model.name;
            NSString * pricelabel = [NSString stringWithFormat:@"¥%@",model.price];
            cell.price.text = pricelabel;
            NSString * teacherlabel = [NSString stringWithFormat:@"讲师：%@",model.teacher];
            cell.teachername.text = teacherlabel;
            cell.totalPrice.attributedText = [[LabelHelper alloc] attributedStringWithString:pricelabel];
            return cell;
  
        }else if (waitjudgeArray.count>0){
            PersonalWaitJudgeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WaitJudgeId" forIndexPath:indexPath];
            AllOderModel * model = [[AllOderModel alloc] init];
            model = waitjudgeArray[indexPath.row];
            [cell.thumbImage sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"myorderthumbimage"]];
            if(!model.shopname.length){
                cell.shopname.text = @"斌神的店铺";
            }else{
                cell.shopname.text = model.shopname;
            }
            cell.title.text = model.name;
            NSString * teacherlabel = [NSString stringWithFormat:@"讲师：%@",model.teacher];
            cell.teacherName.text = teacherlabel;
            NSString * pricelabel = [NSString stringWithFormat:@"¥%@",model.price];
            cell.price.text = pricelabel;
            cell.totalPrice.attributedText = [[LabelHelper alloc] attributedStringWithString:pricelabel];
            __weak MyOrderAllViewController * weakself = self;
            cell.block = ^(NSIndexPath * cellindexpath){
                cellindexpath = indexPath;
                [weakself clickjudgeBtnWithIndexpath:cellindexpath];
            };
            
            return cell;

        }else{
            MyJudgeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyJudgeId" forIndexPath:indexPath];
            AllOderModel * model = [[AllOderModel alloc] init];
            model = isjudgeArray[indexPath.row];
            [cell.thumbimage sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"myorderthumbimage"]];
            cell.titlename.text = model.name;
            cell.timelabel.text = model.ctime;
            return cell;
        }
    }else{
    
    if(indexPath.section == 0){
        PersonalWaitPayTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyOrderId" forIndexPath:indexPath];
        cell.cancelBtn.tag = 10 + indexPath.row;
        cell.sureBtn.tag = indexPath.row;
        [cell.sureBtn addTarget:self action:@selector(PayOrder:) forControlEvents:UIControlEventTouchUpInside];
        [cell.cancelBtn addTarget:self action:@selector(CancelOrdernum:) forControlEvents:UIControlEventTouchUpInside];
        AllOderModel * model = [[AllOderModel alloc] init];
        model = waitpayArray[indexPath.row];
        [cell.thumbImage sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"myorderthumbimage"]];
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
        [cell.thumbImage sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"myorderthumbimage"]];
        if(!model.shopname.length){
            cell.shopname.text = @"斌神的店铺";
        }else{
        cell.shopname.text = model.shopname;
        }
        cell.title.text = model.name;
        NSString * teacherlabel = [NSString stringWithFormat:@"讲师：%@",model.teacher];
        cell.teacherName.text = teacherlabel;
        NSString * pricelabel = [NSString stringWithFormat:@"¥%@",model.price];
        cell.price.text = pricelabel;
        cell.totalPrice.attributedText = [[LabelHelper alloc] attributedStringWithString:pricelabel];
        __weak MyOrderAllViewController * weakself = self;
        cell.block = ^(NSIndexPath * cellindexpath){
            cellindexpath = indexPath;
            [weakself clickjudgeBtnWithIndexpath:cellindexpath];
        };

        return cell;
    }else{
        MyJudgeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyJudgeId" forIndexPath:indexPath];
        AllOderModel * model = [[AllOderModel alloc] init];
        model = isjudgeArray[indexPath.row];
        [cell.thumbimage sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"myorderthumbimage"]];
        cell.titlename.text = model.name;
        cell.timelabel.text = model.ctime;
        return cell;
    }
    }
}

- (void)clickjudgeBtnWithIndexpath:(NSIndexPath*)indexpath
{
    AllOderModel * model = [[AllOderModel alloc] init];
    model = waitjudgeArray[indexpath.row];
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Mine" bundle:nil];
    ProductJudgeViewController * VC = (ProductJudgeViewController*)[storyboard instantiateViewControllerWithIdentifier:@"productJudge"];
    VC.deleteblock = ^(NSIndexPath * indexpath){
        NSInteger index2 = indexpath.row;
        [waitjudgeArray removeObjectAtIndex:index2];
        [_tableView reloadData];
    };
    VC.uid = model.goodsid;
    VC.image = model.image;
    VC.ustyle = model.goodstype;
    VC.ordernum = model.ordernum;
    VC.indexpath = indexpath;
    VC.index = indexpath.row;
    [self.navigationController pushViewController:VC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    if(indexPath.section == 2){
//        return 80;
//    }
//    else{
//    return 217;
//    }
    if(allData.count>0){
    NSArray * array = allData[indexPath.section];
    AllOderModel * model = array[0];
    if([model.state isEqualToString:@"2"]){
        return 80;
    }else{
       return 217;
    }
    }else{
        return 0;
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
    index1 = sender.tag;
    [[Config Instance] saveOrderNum:_ordernum];
    NSLog(@"ordernum%@",_ordernum);
    [_payView.payBtn addTarget:self action:@selector(payaction) forControlEvents:UIControlEventTouchUpInside];
    _payView.frame = CGRectMake(0, ScreenHeight*0.35- 100, ScreenWidth, ScreenHeight * 0.65);
    _shadowBtn.frame = CGRectMake(0, -ScreenHeight * 0.65- 100, ScreenWidth, ScreenHeight);
    [UIView commitAnimations];
    

}

- (void)payaction
{
    [self.tradeView show];
}

- (NSString *)finish:(NSString *)pwd
{
    NSString * SecurityString = [Tools loginPasswordSecurityLock:pwd];
    NSString * ordernum = [[Config Instance] getOrderNum];

//        [[MyAPI sharedAPI] payOrderWithOrderNum:_ordernum Excode:SecurityString Result:^(BOOL sucess, NSString *msg) {
//        if(sucess){
//            [self showHint:@"付款成功"];
//            [waitpayArray removeObjectAtIndex:index];
//            [_tableView reloadData];
//        }else{
//            [self showHint:msg];
//        }
//    } ErrorResult:^(NSError *enginerError) {
//        
//    }];
    self.manager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:BaseUrl]] ;
    self.manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSDictionary * parameters = @{@"token":KToken,@"ordernum":ordernum,@"excode":SecurityString};
    [self.manager POST:@"orderPay" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * status = responseObject[@"status"];
        NSString * info = responseObject[@"info"];
        if([status isEqualToString:@"1"]){
            [self showHint:info];
            if(index1>=0&&index1<waitpayArray.count){
          //  [waitpayArray removeObjectAtIndex:index1];
            [_tableView reloadData];
                [self down];
                NSString * indexStr = [NSString stringWithFormat:@"%ld",index1];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteact" object:nil userInfo:@{@"index":indexStr}];
            }
            
        }else{
            [self showHint:info];
        }
        [self loadData];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
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
                NSString * indexStr = [NSString stringWithFormat:@"%ld",index-10];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteact" object:nil userInfo:@{@"index":indexStr}];

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
