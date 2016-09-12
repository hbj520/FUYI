//
//  VideoDetailViewController.m
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/7/4.
//  Copyright © 2016年 youyou. All rights reserved.
//



#import "VideoDetailViewController.h"
#import "ShopCarViewController.h"
#import "ConfirmOrderViewController.h"
#import "StoreViewController.h"
#import "IJKMoviePlayerViewController.h"
#import "MyOrderAllViewController.h"
#import "GLVideoPlayView.h"
#import "XLPasswordView.h"
#import "UIViewController+HUD.h"
//view
#import "VideoDetailFirstTableViewCell.h"
#import "VideoDetailSecTableViewCell.h"
#import "VideoDetailThirdtTableViewCell.h"
#import "StoreDataModel.h"
#import "LabelHelper.h"
#import "LPPopup.h"
#import "Config.h"
#import "MyAPI.h"
#import "PayView.h"
#import "Masonry.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <AFNetworking/AFNetworking.h>


@interface VideoDetailViewController ()<XLPasswordViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)collectionBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *collectionBtn;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIView *buyNowBtn;
@property (nonatomic,strong) UIBezierPath *path;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttomLayoutConstraint;

@end
@implementation VideoDetailViewController
{
    CALayer     *layer;
    //UILabel     *_cntLabel;// 购物车总数量显示文本
    NSInteger    _cnt;// 总数量
    UIImageView *head0;
    IJKMoviePlayerViewController *playerVC;
    PayView* _payView;
    UIButton* _shadowBtn;
    XLPasswordView * passwordview;
    UIImageView *videoImageView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    passwordview = [XLPasswordView passwordView];
    passwordview.delegate = self;
    self.view.tag = 10;
    [self creatHidePayView];
    [self creatUI];
      _cnt = 0;
   
    
    
    //[self judgeCollectSelected];//判断第一次进来的收藏按钮状态
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
   
    [passwordview showPasswordInView:self.view];

    
}

- (void)passwordView:(XLPasswordView *)passwordView didFinishInput:(NSString *)password

{
    NSString * SecurityString = [Tools loginPasswordSecurityLock:password];
    NSString * ordernum = [[Config Instance] getOrderNum];
    [[MyAPI sharedAPI] payOrderWithOrderNum:ordernum Excode:SecurityString Result:^(BOOL sucess, NSString *msg) {
        if(sucess){
            [self showHint:msg];
            [self down];
            [passwordView hidePasswordView];
            UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Mine" bundle:nil];
            MyOrderAllViewController * VC = (MyOrderAllViewController *)[storyboard instantiateViewControllerWithIdentifier:@"MyOrderStoryBoardID"];
            [self.navigationController pushViewController:VC animated:YES];
            
        }else{
            if([msg isEqualToString:@"-1"]){
                [self showPopup:@"登录超时"];
                [self logOut];
            }else{
            [self showHint:msg];
            }
            [passwordView hidePasswordView];
            [self down];
        }
    } ErrorResult:^(NSError *enginerError) {
        
    }];
}


//确认付款落下
-(void)down{
    _shadowBtn.hidden = YES;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    _payView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight*0.65);
    [UIView commitAnimations];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
   // [playerVC removeFromParentViewController];
}
//判断第一次进来的按钮状态
- (void)judgeCollectSelected{
    if ([_model.videoCollect isEqualToString:@"0"]) {
        self.collectBtn.selected = NO;
    }else{
        self.collectBtn.selected = YES;
    }
}

-(void)creatUI{
   // self.navigationItem.hidesBackButton = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"VideoDetailFirstTableViewCell" bundle:nil] forCellReuseIdentifier:@"detailFirstReuseID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"VideoDetailSecTableViewCell" bundle:nil] forCellReuseIdentifier:@"detailSecReuseID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"VideoDetailThirdtTableViewCell" bundle:nil] forCellReuseIdentifier:@"detailThirdReuseID"];
    [self addBottomTapGesAndButton];//添加底部点击事件
    //添加头部视频图片
    head0 = [[UIImageView alloc]init];
    [head0 sd_setImageWithURL:[NSURL URLWithString:_model.videoImage]placeholderImage:[UIImage imageNamed:@"VD_class_demo"]];
    UIImageView *playImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/2-25, 83, 50, 50)];
    playImageView.image = [UIImage imageNamed:@"play"];
    [head0 addSubview:playImageView];
    UITapGestureRecognizer *tapViedoGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(videoClick:)];
    head0.userInteractionEnabled = YES;
    [head0 addGestureRecognizer:tapViedoGes];
    
}

- (void)addBottomTapGesAndButton{
    UITapGestureRecognizer *tapShopGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shopClick:)];
    [self.shopView addGestureRecognizer:tapShopGes];
    
    UITapGestureRecognizer *tapServiceGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(serviceClick:)];
    [self.serviceView addGestureRecognizer:tapServiceGes];
}


 
#pragma mark - creatLPPopup

- (void)showPopup:(NSString *)popupWithText
{
    LPPopup *popup = [LPPopup popupWithText:popupWithText];
    [popup showInView:self.view
        centerAtPoint:self.view.center
             duration:kLPPopupDefaultWaitDuration
           completion:nil];
}

//收藏
- (IBAction)collectClick:(UIButton*)button {
    
    //if ([_model.videoCollect isEqualToString:@"0"]) {
   
}

- (void)cancelCollection{
    [[MyAPI sharedAPI] cancelCollectGoodsWithWithToken:KToken
                                               goodsId:_model.videoId
                                                  type:_model.videoType
                                                result:^(BOOL sucess, NSString *msg) {
                                                    if (sucess) {
                                                        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadcollect" object:nil];
                                                        [self showPopup:msg];
                                                        _model.videoCollect = @"0";
                                                    }else{
                                                        [self showPopup:msg];
                                                        
                                                    }
                                                } errorResult:^(NSError *enginerError) {
                                                    
                                                }];

}

- (void)postCollection{
    [[MyAPI sharedAPI]collectGoodsWithToken:KToken
                                    goodsId:_model.videoId
                                       type:_model.videoType
                                     result:^(BOOL sucess, NSString *msg) {
                                         if ([msg isEqualToString:@"登录超时"]) {
                                             
                                             [self logOut];
                                         }
                                         if (sucess) {
                                             [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadcollect" object:nil];
                                             [self showPopup:msg];
                                             _model.videoCollect = @"1";
                                         }else{
                                             [self showPopup:msg];
                                             
                                         }
                                     } errorResult:^(NSError *enginerError) {
                                     }];
}
//店铺
- (void)shopClick:(UIGestureRecognizer *)ges{
    [self performSegueWithIdentifier:@"GoStoreSegue" sender:self.model];
}
//点击播放预览视频
- (void)videoClick:(UIGestureRecognizer *)ges{
   // [self performSelector:@selector(preview) withObject:nil afterDelay:10.f];
    
    UIImageView *videoView = (UIImageView *)ges.view;
    videoImageView = videoView;
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: {
                NSLog(@"未知网络");
                break;
            }
            case AFNetworkReachabilityStatusNotReachable: {
                NSLog(@"无网络");
                [self showHint:@"请检查网络!"];
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN: {
                NSLog(@"移动网络");
                if ([[[Config Instance] getIsWifi] isEqualToString:@"0"]) {
                    [self addVideoViewToView:videoView];
                    [self showHint:@"土豪,您当前在移动网络下观看视频，请注意流量控制~~"];
                }else{
                    [self showAlertView];
                }
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi: {
                [self addVideoViewToView:videoView];
                NSLog(@"WiFi");
                break;
            }
            default: {
                break;
            }
        }
    }];
    [manager startMonitoring];


}
- (void)showAlertView{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您将在移动网络下观看视频" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}
- (void)addVideoViewToView:(UIImageView *)videoView{
    NSString * videoUrl = _model.videoUrl;
    playerVC = [IJKMoviePlayerViewController InitVideoViewFromViewController:self withTitle:@"GLTest" URL:[NSURL URLWithString:@"http://krtv.qiniudn.com/150522nextapp"] isLiveVideo:YES isOnlineVideo:NO isFullScreen:NO completion:nil];
    __weak VideoDetailViewController *weakself = self;
    playerVC.fullScreenBlock = ^(BOOL isFullScreen){
        if (isFullScreen) {
            videoView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
            weakself.buttomLayoutConstraint.constant = 0;
            weakself.backBtn.hidden = YES;
            weakself.buyNowBtn.hidden = YES;
            [weakself.tableView reloadData];
        }else{
            videoView.frame = CGRectMake(0, 0,ScreenWidth,215);
            weakself.buttomLayoutConstraint.constant = 50;
            weakself.backBtn.hidden = NO;
            weakself.buyNowBtn.hidden = NO;
        }
    };
    [self addChildViewController:playerVC];
    [videoView addSubview:playerVC.view];
    playerVC.playView.limitTime = 10.f;
    
    //[self addChildViewController:playerVC];
    
    UITapGestureRecognizer *tapViedoGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(video:)];
    [playerVC.view addGestureRecognizer:tapViedoGes];
    playerVC.view.userInteractionEnabled = YES;
    [playerVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    /** 判断直播是否开启,并执行退出 */
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //        [playerVC GoBack];
    });
}
- (void)preview
{
    [playerVC.player shutdown];
}

- (void)video:(UIGestureRecognizer *)ges{
    if (playerVC.playView.isHideTool) {
        [playerVC.playView showAndFade];
        [playerVC.playViewFullScreen showAndFade];
        playerVC.playView.isHideTool = NO;
    }else{
        [playerVC.playView hide];
        [playerVC.playViewFullScreen hide];
        playerVC.playView.isHideTool = YES;
    }
   // NSLog(@"video play taop");
}
#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else{
        return 1;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        VideoDetailFirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailFirstReuseID" forIndexPath:indexPath];
        cell.videoTitleLab.text = _model.videoName;
        cell.detailVideoPriceLab.attributedText = [[LabelHelper alloc]attributedFontStringWithString:[NSString stringWithFormat:@"%@",_model.videoPrice] firstFont:17 secFont:24 thirdFont:19];
        
        cell.authorLab.text = [NSString stringWithFormat:@"讲师：%@",_model.teacherName];
        cell.saleCountsLab.text = [NSString stringWithFormat:@"月销%@笔",_model.sellNum];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if ([_model.videoCollect isEqualToString:@"0"]) {
            cell.collectionBtn.selected = NO;
        }else{
            cell.collectionBtn.selected = YES;
        }
        cell.collectBlock = ^(UIButton *collectionBtn){
            if (collectionBtn.selected == NO) {
                
                if (KToken) {
                    collectionBtn.selected = !collectionBtn.selected;
                    [self postCollection];
                }else{
                    [self logOut];
                }
            }else{
                
                if (KToken) {
                    collectionBtn.selected = !collectionBtn.selected;
                    [self cancelCollection];
                }else{
                    [self logOut];
                }
            }
        };
        return cell;
    }if (indexPath.section == 0 && indexPath.row == 1) {
        VideoDetailSecTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailSecReuseID" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        VideoDetailThirdtTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailThirdReuseID" forIndexPath:indexPath];
        cell.videoContentText.text = _model.videodescription;

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIView *head1 = [[UIView alloc]init];
        head1.backgroundColor = RGBACOLOR(234, 235, 236, 1);
        return head1;
    }else{
       
        return head0;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        if (self.backBtn.hidden) {
            return   ScreenHeight;
        }
        return 215;
    }else{
        return 15;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
       
        return 140;
    }if (indexPath.section == 0 && indexPath.row == 1) {
        return 40;
    }else{
        return 260;
    }
}

#pragma mark -PrivateMethod
- (IBAction)back:(id)sender {
     [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
    [playerVC removeFromParentViewController];
    [playerVC.playView removeFromSuperview];
    
}

//立即下单
- (IBAction)buyNow:(id)sender {
    if (!KToken) {
        [self showHint:@"请先登录，再购买"];
    }else{
        NSString * isTeacher = [[Config Instance] getisteacher];

        [[MyAPI sharedAPI] getOrderNumWithGoodsid:_model.videoId Money:_model.videoPrice Result:^(BOOL sucess, NSString *msg) {
            if(!msg){
                return ;
            }else{
                if(sucess){
                    [[Config Instance] saveOrderNum:msg];
                    _shadowBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
                    _shadowBtn.backgroundColor = [UIColor blackColor];
                    [_shadowBtn addTarget:self action:@selector(down) forControlEvents:UIControlEventTouchUpInside];
                    _shadowBtn.alpha = 0.5;
                    [self.view addSubview:_shadowBtn];
                    
                    [UIView beginAnimations:nil context:nil];
                    [UIView setAnimationDuration:1.0];
                    _payView.frame = CGRectMake(0, ScreenHeight*0.7, ScreenWidth, ScreenHeight*0.3);
                    _payView.lastPriceLab.text = [NSString stringWithFormat:@"%@",self.model.videoPrice];
                    _payView.videoprice.text = [NSString stringWithFormat:@"%@",self.model.videoPrice];
                    [_payView.videoImg sd_setImageWithURL:[NSURL URLWithString:self.model.videoImage] placeholderImage:[UIImage imageNamed:@"bigimage"]];
                    _payView.titleLab.text = self.model.videoName;
                    _payView.layer.cornerRadius = 3;
                    _payView.layer.masksToBounds = YES;
                    _shadowBtn.frame = CGRectMake(0, -ScreenHeight*0.3, ScreenWidth, ScreenHeight);
                    [UIView commitAnimations];
                }else if([msg isEqualToString:@"0"]){
                  [self showHint:@"请不要重复购买!"];
                }else if([msg isEqualToString:@"-1"]){
                    [self showPopup:@"登录超时"];
                    [self logOut];
                   // return ;
                }
            }
        } ErrorResult:^(NSError *enginerError) {
            
        }];
            }
}
#pragma mark -SegueDelegate
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"ConfirmOrderSegue"]) {
        ConfirmOrderViewController *confirmVC = segue.destinationViewController;
        confirmVC.model = sender[0];
        confirmVC.ordernum = sender[1];
    }
    if ([segue.identifier isEqualToString:@"GoStoreSegue"]) {
        StoreViewController *storeVC = segue.destinationViewController;
        storeVC.model = sender;
    }

}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {//确定，返回登录
        [self addVideoViewToView:videoImageView];

    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
//    ShopCarViewController *shopVC = segue.destinationViewController;
//    NSNumber *isPushNumber = sender;
//    BOOL isPush = isPushNumber.boolValue;
//   shopVC.isPush = isPush;
    
//}


- (IBAction)collectionBtn:(id)sender {
    if (self.collectionBtn.selected == NO) {
        if (KToken) {
            self.collectionBtn.selected = !self.collectionBtn.selected;
            [self postCollection];
        }else{
            [self logOut];
        }
    }else{
        
        if (KToken) {
            self.collectionBtn.selected = !self.collectionBtn.selected;
            [self cancelCollection];
        }else{
            [self logOut];
        }
    }
}
@end
