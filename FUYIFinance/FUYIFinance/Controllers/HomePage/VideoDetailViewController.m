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

#import <SDWebImage/UIImageView+WebCache.h>

@interface VideoDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation VideoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatUI];

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

//收藏
- (void)collectClick:(UIButton*)button{
    button.selected = !button.selected;
    

}

//加入购物车
- (void)addShopCarClick:(UIButton*)button{
    [UIView animateWithDuration:1.0 animations:^{
       // _cartAnimView.frame=CGRectMake(self.screenWidth-55, -(self.screenHeight - CGRectGetHeight(self.view.frame) - 40), 0, 0);
    } completion:^(BOOL finished) {
      
    }];
    
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
