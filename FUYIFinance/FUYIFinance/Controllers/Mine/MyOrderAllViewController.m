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
#import "ConfirmOrderViewController.h"
#import "ProductJudgeViewController.h"
#import "MineGoodsJudgeTableViewController.h"
#import "UIViewController+HUD.h"
#import "PersonalWaitPayTableViewCell.h"
#import "PersonalWaitJudgeTableViewCell.h"
#import "MyJudgeTableViewCell.h"
#import "AllOderModel.h"
#import "StoreDataModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <MJRefresh/MJRefresh.h>
#import "LabelHelper.h"
#import "Tools.h"
#import "Config.h"
#import "PayView.h"
#import "ZCTradeView.h"
#import "XLPasswordView.h"
#import "MyAPI.h"

@interface MyOrderAllViewController ()<
XLPasswordViewDelegate,
ZCTradeViewDelegate,
UITableViewDelegate,
UITableViewDataSource,
UIAlertViewDelegate>
{
  //  UITableView * _tableView;
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
    [self creatHidePayView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePage) name:@"updatepage" object:nil];
}

//更新页面
- (void)updatePage
{
    [self loadData];
}

//移除观察者
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"updatepage" object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

//添加上拉刷新
- (void)addRefresh
{
    __weak MyOrderAllViewController * weakself = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        page = 1;
       
       [weakself loadData];
        
    }];

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
        if(success){
            if(page == 1){
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
            }
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
            }
            if (waitjudgeArray.count > 0) {
                [allData addObject:waitjudgeArray];
            }
            if (isjudgeArray.count > 0) {
                [allData addObject:isjudgeArray];
            }

            [_tableView reloadData];
            [_tableView.mj_header endRefreshing];
            [_tableView.mj_footer endRefreshing];
        }else{
            if([msg isEqualToString:@"-1"]){
                [self logOut];
            }else{
                if([msg isEqualToString:@"0"]){
                    [waitpayArray removeAllObjects];
                    [waitjudgeArray removeAllObjects];
                    [isjudgeArray removeAllObjects];
                    [allData removeAllObjects];
                    [_tableView reloadData];
                }
            }
            [_tableView.mj_header endRefreshing];
        }
       
        
    } errorResult:^(NSError *enginerError) {
        [_tableView.mj_header endRefreshing];
    }];
    
  }


#pragma mark-TableViewDelegate
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
                    cell.shopname.text = @"默认店铺名";
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
                    cell.shopname.text = @"李小刚的店铺";
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
                    cell.shopname.text = @"默认店铺名";
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
                cell.defaultjudge.text = model.content;
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
                    cell.shopname.text = @"李小刚的店铺";
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
                cell.defaultjudge.text = model.content;
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
                cell.shopname.text = @"李小刚的店铺";
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
            cell.defaultjudge.text = model.content;
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
        if(!model.shopname.length){
            cell.shopname.text = @"默认店铺名";
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
    }else if(indexPath.section == 1){
        PersonalWaitJudgeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WaitJudgeId" forIndexPath:indexPath];
        AllOderModel * model = [[AllOderModel alloc] init];
        model = waitjudgeArray[indexPath.row];
        [cell.thumbImage sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"myorderthumbimage"]];
        if(!model.shopname.length){
            cell.shopname.text = @"李小刚的店铺";
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
        cell.defaultjudge.text = model.content;
        cell.timelabel.text = model.ctime;
        return cell;
    }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(waitpayArray.count>0){
        if(indexPath.section == 0){
        AllOderModel * model = [[AllOderModel alloc] init];
        model = waitpayArray[indexPath.row];
        StoreDataModel * model1 = [[StoreDataModel alloc] init];
        model1.videoName = model.name;
        model1.videoImage = model.image;
        model1.videoPrice = model.price;
        UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"HomePage" bundle:nil];
        ConfirmOrderViewController * VC = (ConfirmOrderViewController *)[storyboard instantiateViewControllerWithIdentifier:@"confirmstoryboardId"];
            VC.model = model1;
            [self.navigationController pushViewController:VC animated:YES];
    }
    }
}

- (void)clickjudgeBtnWithIndexpath:(NSIndexPath*)indexpath
{
    AllOderModel * model = [[AllOderModel alloc] init];
    model = waitjudgeArray[indexpath.row];
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Mine" bundle:nil];
    MineGoodsJudgeTableViewController * VC1 = (MineGoodsJudgeTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"GoodJudgeStoryBoardID"];
    VC1.uid = model.goodsid;
    VC1.image = model.image;
    VC1.ustyle = model.goodstype;
    VC1.ordernum = model.ordernum;
    VC1.indexpath = indexpath;
    VC1.index = indexpath.section;
    VC1.goodsname = model.name;
    VC1.goodsprice = model.price;
    VC1.teachname = model.teacher;
    VC1.deleteblock = ^(NSIndexPath * indexpath){
        NSInteger index2 = indexpath.row;
        [waitjudgeArray removeObjectAtIndex:index2];
        [_tableView reloadData];
    };
    [self.navigationController pushViewController:VC1 animated:YES];
       }

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
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


#pragma mark - 取消订单
- (void)CancelOrdernum:(UIButton *)sender
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"确认删除订单？" message:@"删除之后可以从电脑端订单回收站恢复" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alertView show];
    index = sender.tag;
 
}


#pragma mark - 确认付款
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
    _payView.lastPriceLab.text = [NSString stringWithFormat:@"¥%@",model.price];
    _payView.videoprice.text = [NSString stringWithFormat:@"¥%@",model.price];
    [_payView.videoImg sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"bigimage"]];
    _payView.titleLab.text = model.name;
    _payView.layer.cornerRadius = 3;
    _payView.layer.masksToBounds = YES;
    _ordernum = model.ordernum;
    index1 = sender.tag;
    [[Config Instance] saveOrderNum:_ordernum];
    NSLog(@"ordernum%@",_ordernum);
    [_payView.payBtn addTarget:self action:@selector(payaction) forControlEvents:UIControlEventTouchUpInside];
    _payView.frame = CGRectMake(0, ScreenHeight*0.35- 100, ScreenWidth, ScreenHeight * 0.65);
    _shadowBtn.frame = CGRectMake(0, -ScreenHeight * 0.65- 100, ScreenWidth, ScreenHeight);
    [UIView commitAnimations];
    

}

#pragma mark -弹出支付密码键盘
- (void)payaction
{
    XLPasswordView * passwordView = [XLPasswordView passwordView];
    passwordView.delegate = self;
    
    [passwordView showPasswordInView:self.view];
}



- (void)passwordView:(XLPasswordView *)passwordView didFinishInput:(NSString *)password

{
    NSString * SecurityString = [Tools loginPasswordSecurityLock:password];
    NSString * ordernum = [[Config Instance] getOrderNum];
    self.manager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:BaseUrl]] ;
    self.manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSDictionary * parameters = @{@"token":KToken,@"ordernum":ordernum,@"excode":SecurityString};
    [self.manager POST:@"orderPay" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * status = responseObject[@"status"];
        NSString * info = responseObject[@"info"];
        if([status isEqualToString:@"1"]){
            [self showHint:info];
            [passwordView hidePasswordView];
            [self down];
            [_tableView.mj_header beginRefreshing];
        }else{
            [self showHint:info];
            [passwordView hidePasswordView];
        }

    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}




//确认付款落下
-(void)down{
    _shadowBtn.hidden = YES;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    _payView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight * 0.65);
    [UIView commitAnimations];
}

//取消订单
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
