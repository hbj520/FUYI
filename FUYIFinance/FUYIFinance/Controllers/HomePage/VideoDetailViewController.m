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

//view
#import "VideoDetailFirstTableViewCell.h"
#import "VideoDetailSecTableViewCell.h"
#import "VideoDetailThirdtTableViewCell.h"
#import "StoreDataModel.h"

#import "LabelHelper.h"
#import "LPPopup.h"
#import "MyAPI.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface VideoDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) UIBezierPath *path;

@end
@implementation VideoDetailViewController
{
    CALayer     *layer;
    //UILabel     *_cntLabel;// 购物车总数量显示文本
    NSInteger    _cnt;// 总数量
    UIImageView *head0;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatUI];
      _cnt = 0;
    
    [self judgeCollectSelected];//判断第一次进来的收藏按钮状态
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
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
    
    //右上角数字label
    _numLab.textAlignment = NSTextAlignmentCenter;
    _numLab.layer.cornerRadius = CGRectGetHeight(_numLab.bounds)/2;
    _numLab.layer.masksToBounds = YES;
    _numLab.layer.borderWidth = 1.0f;
    _numLab.layer.borderColor = [[UIColor whiteColor]CGColor];
    [self.view addSubview:_numLab];
    
    if (_cnt >= 0) {
        _numLab.hidden = YES;
    }
    
    //路线坐标
    _path = [UIBezierPath bezierPath];
    [_path moveToPoint:CGPointMake(ScreenWidth*0.6, ScreenHeight * 0.9)];
    [_path addQuadCurveToPoint:CGPointMake(ScreenWidth-68, 10)
                  controlPoint:CGPointMake(50, 200)];
}
//进购物车界面
- (IBAction)pushToShopCar:(id)sender {
    UIStoryboard *storyBord = [UIStoryboard storyboardWithName:@"ShopCar" bundle:[NSBundle mainBundle]];
    ShopCarViewController *shopVC = [storyBord instantiateViewControllerWithIdentifier:@"ShopCarStorybordId"];
    shopVC.isPush = YES;
    [self.navigationController pushViewController:shopVC animated:YES];
//    [self performSegueWithIdentifier:@"PushToShopCarSegue" sender:[NSNumber numberWithBool:YES]];
    //self.tabBarController.selectedIndex = 2;
}

- (void)addBottomTapGesAndButton{
    [self.collectBtn setBackgroundImage:[UIImage imageNamed:@"VD_star"] forState:UIControlStateNormal];
    [self.collectBtn setBackgroundImage:[UIImage imageNamed:@"VD_red_Star.jpg"] forState:UIControlStateSelected];
    
    [self.addShopCarBtn addTarget:self action:@selector(addShopCarClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tapShopGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shopClick:)];
    [self.shopView addGestureRecognizer:tapShopGes];
    
    UITapGestureRecognizer *tapServiceGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(serviceClick:)];
    [self.serviceView addGestureRecognizer:tapServiceGes];
}

//加入购物车
- (void)addShopCarClick:(UIButton*)button{
    
    if (!layer)
    {
        button.enabled = NO;
        layer = [CALayer layer];
        layer.contents = (__bridge id)head0.image.CGImage;
        layer.contentsGravity = kCAGravityResizeAspectFill;
        layer.bounds = CGRectMake(0, 0, 50, 50);
        layer.masksToBounds = YES;
        //layer.position = CGPointMake(50, 150);
        layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor whiteColor]);
        [self.view.layer addSublayer:layer];
    }
    
    if ([_model.cart isEqualToString:@"0"]) {
         [self groupAnimation];//加入购物车动画
        [[MyAPI sharedAPI]addGoodIntoShopCarWithToken:KToken
                                              goodsId:_model.videoId
                                                 type:_model.videoType
                                                money:_model.videoPrice
                                               result:^(BOOL sucess, NSString *msg) {
                                                   
                                                   if ([msg isEqualToString:@"登录超时"]) {
                                                       [self logOut];
                                                   }
                                                   if (sucess) {
                                                       [self showPopup:msg];
                                                   }else{
                                                       [self showPopup:msg];
                                                   }
                                                   
                                               } errorResult:^(NSError *enginerError) {
                                                   
                                               }];
        _model.cart = @"1";
    }else{
        [self showPopup:@"购物车已存在！"];
    }
}

- (void)groupAnimation
{
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation1.path = _path.CGPath;
    animation1.rotationMode = kCAAnimationRotateAuto;
    
    CABasicAnimation *animation = [ CABasicAnimation
                                   animationWithKeyPath: @"transform" ];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    // 围绕Z轴旋转，垂直与屏幕
    animation.toValue = [ NSValue valueWithCATransform3D:
                         CATransform3DMakeRotation(M_PI, 0.0, 0.0, 1.0) ];
    animation.duration = 0.15;
    // 旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
    animation.cumulative = YES;
    animation.repeatCount = 1000;
    
    CABasicAnimation *expandAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    expandAnimation.duration = 0.2f;
    expandAnimation.beginTime = 0.3f;
    expandAnimation.fromValue = [NSNumber numberWithFloat:0.3f];
    expandAnimation.toValue = [NSNumber numberWithFloat:0.4f];
    expandAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *narrowAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    narrowAnimation.beginTime = 0.2f;
    narrowAnimation.fromValue = [NSNumber numberWithFloat:0.7f];
    narrowAnimation.duration = 0.3f;
    narrowAnimation.toValue = [NSNumber numberWithFloat:0.9f];
    narrowAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[animation1,expandAnimation,animation,narrowAnimation];
    groups.duration = 0.6f;
    groups.removedOnCompletion = NO;
    groups.fillMode = kCAFillModeForwards;
    groups.delegate = self;
    [layer addAnimation:groups forKey:@"group"];
}

//动画结束后
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (anim == [layer animationForKey:@"group"]) {
        self.addShopCarBtn.enabled = YES;
        [layer removeFromSuperlayer];
        layer = nil;
        _cnt++;
        if (_cnt >= 0) {
            _numLab.hidden = YES;
        }
        
        CATransition *animation = [CATransition animation];
        animation.duration = 0.15f;
        _numLab.text = [NSString stringWithFormat:@"%ld",_cnt];
        [_numLab.layer addAnimation:animation forKey:nil];
        
        CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
        shakeAnimation.duration = 0.15f;
        shakeAnimation.fromValue = [NSNumber numberWithFloat:-5];
        shakeAnimation.toValue = [NSNumber numberWithFloat:5];
        shakeAnimation.autoreverses = YES;
        [self.shopCarBtn.layer addAnimation:shakeAnimation forKey:nil];
        
       // [self showPopup:@"加入购物车成功！"];
    }
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
    if (button.selected == NO) {
        button.selected = !button.selected;
        if (KToken) {
            [self postCollection];
        }else{
            [self logOut];
        }
    }else{
        button.selected = !button.selected;
        if (KToken) {
            [self cancelCollection];
        }else{
            [self logOut];
        }
    }
}

- (void)cancelCollection{
    [[MyAPI sharedAPI] cancelCollectGoodsWithWithToken:KToken
                                               goodsId:_model.videoId
                                                  type:_model.videoType
                                                result:^(BOOL sucess, NSString *msg) {
                                                    if (sucess) {
                                                        
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
    [self performSegueWithIdentifier:@"GoStoreSegue" sender:nil];
}

//客服
- (void)serviceClick:(UIGestureRecognizer *)ges{
    
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
        cell.detailVideoPriceLab.attributedText = [[LabelHelper alloc]attributedFontStringWithString:[NSString stringWithFormat:@"¥ %@",_model.videoPrice] firstFont:17 secFont:24 thirdFont:19];
        
        cell.authorLab.text = [NSString stringWithFormat:@"讲师：%@",_model.teacherName];
        cell.saleCountsLab.text = [NSString stringWithFormat:@"月销%@笔",_model.sellNum];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
        head0 = [[UIImageView alloc]init];
      // head0.image = [UIImage imageNamed:@"VD_class_demo"];
      [head0 sd_setImageWithURL:[NSURL URLWithString:_model.videoImage]placeholderImage:[UIImage imageNamed:@"VD_class_demo"]];
        return head0;
    }
}

- (IBAction)back:(id)sender {
     [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)buyNow:(id)sender {
   [self performSegueWithIdentifier:@"ConfirmOrderSegue" sender:self.model];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"ConfirmOrderSegue"]) {
        ConfirmOrderViewController *confirmVC = segue.destinationViewController;
        confirmVC.model = sender;
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
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


@end
