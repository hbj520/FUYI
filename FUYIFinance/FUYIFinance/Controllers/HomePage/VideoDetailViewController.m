//
//  VideoDetailViewController.m
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/7/4.
//  Copyright © 2016年 youyou. All rights reserved.
//

//view
#import "VideoDetailFirstTableViewCell.h"
#import "VideoDetailSecTableViewCell.h"
#import "VideoDetailThirdtTableViewCell.h"

#import "VideoDetailViewController.h"

#import "StoreDataModel.h"

#import "LabelHelper.h"
#import "LPPopup.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface VideoDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) UIBezierPath *path;

@end

@implementation VideoDetailViewController
{
    CALayer     *layer;
    UILabel     *_cntLabel;// 购物车总数量显示文本
    NSInteger    _cnt;// 总数量
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatUI];
      _cnt = 0;

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    
}

-(void)creatUI{
    self.navigationItem.hidesBackButton = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"VideoDetailFirstTableViewCell" bundle:nil] forCellReuseIdentifier:@"detailFirstReuseID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"VideoDetailSecTableViewCell" bundle:nil] forCellReuseIdentifier:@"detailSecReuseID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"VideoDetailThirdtTableViewCell" bundle:nil] forCellReuseIdentifier:@"detailThirdReuseID"];
    [self addBottomTapGesAndButton];//添加底部点击事件
    
//    // label
//    _cntLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-30, 25, 20, 20)];
//    _cntLabel.textColor = customColor;
//    _cntLabel.textAlignment = NSTextAlignmentCenter;
//    _cntLabel.font = [UIFont boldSystemFontOfSize:13];
//    _cntLabel.backgroundColor = [UIColor whiteColor];
//    _cntLabel.layer.cornerRadius = CGRectGetHeight(_cntLabel.bounds)/2;
//    _cntLabel.layer.masksToBounds = YES;
//    _cntLabel.layer.borderWidth = 1.0f;
//    _cntLabel.layer.borderColor = customColor.CGColor;
//    [self.view addSubview:_cntLabel];
//    
//    if (_cnt == 0) {
//        _cntLabel.hidden = YES;
//    }
//    
//    _path = [UIBezierPath bezierPath];
//    [_path moveToPoint:CGPointMake(50, SCREEN_HEIGHT * 0.7)];
//    [_path addQuadCurveToPoint:CGPointMake(SCREEN_WIDTH-50-10, 5)
//                  controlPoint:CGPointMake(156, 100)];
    
    
}

- (void)addBottomTapGesAndButton{

    [self.collectBtn addTarget:self action:@selector(collectClick:) forControlEvents:UIControlEventTouchUpInside];
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
        UIColor *customColor  = [UIColor colorWithRed:237/255.0 green:20/255.0 blue:91/255.0 alpha:1.0f];
        
        button.enabled = NO;
        layer = [CALayer layer];
        layer.contents = (__bridge id)[UIImage imageNamed:@"test01.jpg"].CGImage;
        layer.contentsGravity = kCAGravityResizeAspectFill;
        layer.bounds = CGRectMake(0, 0, 50, 50);
        
        layer.masksToBounds = YES;
        layer.position = CGPointMake(50, 150);
        layer.borderColor = customColor.CGColor;
        [self.view.layer addSublayer:layer];
    }
    
    [self groupAnimation];
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








//收藏
- (void)collectClick:(UIButton*)button{
    button.selected = !button.selected;
    

}


//店铺
- (void)shopClick:(UIGestureRecognizer *)ges{
    
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
        //cell.detailVideoPriceLab.text = [NSString stringWithFormat:@"¥%@",_model.videoPrice];
        cell.detailVideoPriceLab.attributedText = [[LabelHelper alloc] attributedFontStringWithString:[NSString stringWithFormat:@"¥ %@",_model.videoPrice]];
        cell.authorLab.text = [NSString stringWithFormat:@"讲师： %@",_model.teacherName];
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
        UIImageView *head0 = [[UIImageView alloc]init];
       // head0.image = [UIImage imageNamed:@"VD_class_demo"];
      [head0 sd_setImageWithURL:[NSURL URLWithString:_model.videoImage]placeholderImage:[UIImage imageNamed:@"VD_class_demo"]];
        return head0;
    }
    
}
- (IBAction)back:(id)sender {
     [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)buyNow:(id)sender {
   [self performSegueWithIdentifier:@"ConfirmOrderSegue" sender:nil];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
