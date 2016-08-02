//
//  MyShopViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/4.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MyShopViewController.h"
#import "TreasureManageViewController.h"
#import "MyShopHeaderTableViewCell.h"
#import "ShopTopTableViewCell.h"
#import "FourBtnTableViewCell.h"
#import "MyShopDetailTableViewCell.h"
#import <MJRefresh/MJRefresh.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "BBBadgeBarButtonItem.h"
#import "TeacherInfo.h"
#import "TeacherShopModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIViewController+HUD.h"
#import "ChangeHeadView.h"
#import "KGModal.h"
#import "MyAPI.h"
#import "Config.h"
#import "LabelHelper.h"
@interface MyShopViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UITableView * _tableView;
    NSString * imageUrl;
    NSMutableArray * dataSource;
    TeacherInfo * teacherinfo;
     UIImagePickerController * _picker;
    BBBadgeBarButtonItem * _chatBtn;         //自定制导航栏按钮
    BBBadgeBarButtonItem * _chatBtn1;        //自定制导航栏按钮

}
@end

@implementation MyShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //添加自定制导航栏按钮
    [self addChatBtn];
    [self initPickView];
    imageUrl = [[Config Instance] getBackImage];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
      _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"MyShopHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID1"];
    [_tableView registerNib:[UINib nibWithNibName:@"ShopTopTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID2"];
    [_tableView registerNib:[UINib nibWithNibName:@"FourBtnTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID3"];
    [_tableView registerNib:[UINib nibWithNibName:@"MyShopDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID4"];
    [self.view addSubview:_tableView];
    dataSource = [NSMutableArray array];
    [self addRefresh];
    [self loadData];
}


#pragma mark - PrivateMethod
- (void)addRefresh
{
    __weak MyShopViewController * weakself = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself loadData];
    }];
//    MJRefreshAutoNormalFooter * footerRefresh = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        [weakself loadData];
//    }];
//    footerRefresh.automaticallyRefresh = NO;
//    _tableView.mj_footer = footerRefresh;
}


- (void)loadData
{
    [[MyAPI sharedAPI] RequestTeacherPersonalShopDataWithPage:@"0" result:^(BOOL success, NSString *msg, NSMutableArray *arrays) {
        teacherinfo = arrays[0];
        dataSource = arrays[1];
        [_tableView reloadData];
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    } errorResult:^(NSError *enginerError) {
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    }];
}
//添加自定制导航栏按钮
- (void)addChatBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 31, 27);
    [btn setImage:[UIImage imageNamed:@"messageBtn"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(chatAct:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 0,20,20);
    [btn1 addTarget:self action:@selector(btnclick1:) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setImage:[UIImage imageNamed:@"barimage"] forState:UIControlStateNormal];
    
    _chatBtn = [[BBBadgeBarButtonItem alloc] initWithCustomUIButton:btn];
    _chatBtn.badgeFont = [UIFont systemFontOfSize:10.0f];
    _chatBtn.badgeOriginX = 15.5;
    _chatBtn.badgeOriginY = -2.5;
    _chatBtn.badgePadding = 2;
    _chatBtn.badgeValue = @"0";
    
    _chatBtn1 = [[BBBadgeBarButtonItem alloc] initWithCustomUIButton:btn1];
    _chatBtn1.badgeFont = [UIFont systemFontOfSize:10.0f];
    _chatBtn1.badgeOriginX = 15.5;
    _chatBtn1.badgeOriginY = -2.5;
    _chatBtn1.badgePadding = 2;
    _chatBtn1.badgeValue = @"0";
    
    NSMutableArray *arryBtn = [NSMutableArray arrayWithObjects:_chatBtn,_chatBtn1, nil];
    self.navigationItem.rightBarButtonItems = arryBtn;
}

//自定制导航栏信息按钮的事件响应方法
- (void)chatAct:(id)sender{
    
}

- (void)btnclick1:(id)sender
{
    [_tableView.mj_header beginRefreshing];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else if (section==1){
        return 1;
    }else if (section==2){
        return 1;
    }else if(section==3){
        return 3;
    }else{
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 135;
    }else if (indexPath.section==1){
        return 40;
    }else if (indexPath.section==2){
        return 110;
    }else{
        return 50;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else if (section==1){
        return 1;
    }else if (section==2){
        return 8;
    }else{
        return 8;
    }
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        MyShopHeaderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID1" forIndexPath:indexPath];
        cell.teacherName.text = teacherinfo.username;
        cell.totoalcount.text = teacherinfo.ordermoney;
        cell.vivstcount.text = teacherinfo.hits;
        cell.ordercount.text = teacherinfo.orders;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choseImage)];
        cell.backImg.userInteractionEnabled = YES;
        [cell.backImg addGestureRecognizer:tap];
        if(imageUrl.length){
        [cell.backImg sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"placeimage"]];
        }
        return cell;
    }else if (indexPath.section==1){
        ShopTopTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID2" forIndexPath:indexPath];
        return cell;
    }else if (indexPath.section==2){
        FourBtnTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID3" forIndexPath:indexPath];
        __weak MyShopViewController * weakself = self;
        

        cell.publishBlock = ^(){
            [weakself publishTreasure];      //进入发送宝贝界面
        };
        
        cell.treasureManageBlock = ^(){
            [weakself treasureManage];       //进入宝贝管理界面
        };
        
        cell.orderManageBlock = ^(){
            [weakself orderManage];          //进入订单管理界面
        };
        
        cell.shopSettingBlock = ^(){
            [weakself shopManage];           //进入店铺设置界面
        };
        
        return cell;
    }else if(indexPath.section == 3){
//        MyShopDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID4" forIndexPath:indexPath];
//        TeacherShopModel * model = [[TeacherShopModel alloc] init];
//        model = dataSource[indexPath.row];
//        cell.model = model;
//        return cell;
        if(indexPath.row == 0){
            UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"modifyId"];
            UIImageView * iconImg = [[UIImageView alloc] initWithFrame:CGRectMake(30, 11, 25, 25)];
            iconImg.image = [UIImage imageNamed:@"personal_modify"];
            [cell.contentView addSubview:iconImg];
            UILabel * descLabel = [[UILabel alloc] initWithFrame:CGRectMake(68, 14, 68, 21)];
            descLabel.textAlignment = NSTextAlignmentLeft;
            descLabel.font = [UIFont systemFontOfSize:14];
            descLabel.textColor = [UIColor blackColor];
            descLabel.text = @"修改资料";
            [cell.contentView addSubview:descLabel];
            return cell;
        }else if (indexPath.row == 1){
            UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"countId"];
            UIImageView * iconImg = [[UIImageView alloc] initWithFrame:CGRectMake(30, 11, 25, 25)];
            iconImg.image = [UIImage imageNamed:@"personal_account"];
            [cell.contentView addSubview:iconImg];
            UILabel * descLabel = [[UILabel alloc] initWithFrame:CGRectMake(68, 14, 75, 21)];
            descLabel.textAlignment = NSTextAlignmentLeft;
            descLabel.font = [UIFont systemFontOfSize:14];
            descLabel.textColor = [UIColor blackColor];
            descLabel.text = @"账户与安全";
            [cell.contentView addSubview:descLabel];
            return cell;

        }else{
            UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"messageId"];
            UIImageView * iconImg = [[UIImageView alloc] initWithFrame:CGRectMake(30, 11, 25, 25)];
            iconImg.image = [UIImage imageNamed:@"personal_messagecenter"];
            [cell.contentView addSubview:iconImg];
            UILabel * descLabel = [[UILabel alloc] initWithFrame:CGRectMake(68, 14, 68, 21)];
            descLabel.textAlignment = NSTextAlignmentLeft;
            descLabel.font = [UIFont systemFontOfSize:14];
            descLabel.textColor = [UIColor blackColor];
            descLabel.text = @"消息中心";
            [cell.contentView addSubview:descLabel];
            return cell;

        }
    }else{
            if(indexPath.row == 0){
                UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"settingId"];
                UIImageView * iconImg = [[UIImageView alloc] initWithFrame:CGRectMake(30, 11, 25, 25)];
                iconImg.image = [UIImage imageNamed:@"personal_mysetting"];
                [cell.contentView addSubview:iconImg];
                UILabel * descLabel = [[UILabel alloc] initWithFrame:CGRectMake(68, 14, 68, 21)];
                descLabel.textAlignment = NSTextAlignmentLeft;
                descLabel.font = [UIFont systemFontOfSize:14];
                descLabel.textColor = [UIColor blackColor];
                descLabel.text = @"设置";
                [cell.contentView addSubview:descLabel];
                return cell;
                
            }else{
                UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"favoriteId"];
                UIImageView * iconImg = [[UIImageView alloc] initWithFrame:CGRectMake(30, 11, 25, 25)];
                iconImg.image = [UIImage imageNamed:@"favorite"];
                [cell.contentView addSubview:iconImg];
                UILabel * descLabel = [[UILabel alloc] initWithFrame:CGRectMake(68, 14, 68, 21)];
                descLabel.textAlignment = NSTextAlignmentLeft;
                descLabel.font = [UIFont systemFontOfSize:14];
                descLabel.textColor = [UIColor blackColor];
                descLabel.text = @"关于我们";
                [cell.contentView addSubview:descLabel];
                return cell;
                
            }
        }

    return nil;
}

- (void)choseImage
{
    [self showModalView];
}

- (void)showModalView
{
    
    [[KGModal sharedInstance] setCloseButtonType:KGModalCloseButtonTypeNone];
    [KGModal sharedInstance].modalBackgroundColor = [UIColor whiteColor];
    
    ChangeHeadView * modifyView = [[[NSBundle mainBundle] loadNibNamed:@"ChangeHeadView" owner:self options:nil] lastObject];
    
    [[KGModal sharedInstance] showWithContentView:modifyView andAnimated:YES];
    
    modifyView.LibraryBlock = ^(){
        [self openPhotoAlbun];
        [[KGModal sharedInstance] hideAnimated:YES];
    };
    modifyView.TakeBlock = ^(){
        [self openCamera];
        [[KGModal sharedInstance] hideAnimated:YES];
    };
    
    
}

- (void)initPickView
{
    _picker = [[UIImagePickerController alloc] init];
    _picker.delegate = self;
}


- (void)openCamera
{
    _picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:_picker animated:YES completion:nil];
}

- (void)openPhotoAlbun
{
    _picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:_picker animated:YES completion:nil];
}

#pragma mark-UINavigationControllerDelegate & UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage * image = info[UIImagePickerControllerOriginalImage];
    
    NSData * data = UIImageJPEGRepresentation(image, 0.1);
    
    [self showHudInView:self.view hint:@"上传图片中"];
    [[MyAPI sharedAPI] uploadImage:data result:^(BOOL sucess, NSString *msg) {
        if(sucess){
            [_tableView reloadData];
            imageUrl = msg;
      
           [[MyAPI sharedAPI] changeMyShopBackImgWithImage:msg result:^(BOOL sucess, NSString *msg) {
             
           } errorResult:^(NSError *enginerError) {
               
           }];
            [self hideHud];
        }else{
          
        }
    } errorResult:^(NSError *enginerError) {
        
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//发布宝贝
- (void)publishTreasure
{
    [self showHint:@"正在建设中"];
}

//宝贝管理
- (void)treasureManage
{
    
    [self performSegueWithIdentifier:@"treasureSegue" sender:[NSNumber numberWithBool:YES]];
}

//订单管理
- (void)orderManage
{
    [self performSegueWithIdentifier:@"treasureSegue" sender:[NSNumber numberWithBool:NO]];
}

//店铺设置
- (void)shopManage
{
    [self performSegueWithIdentifier:@"shopsettingSegue" sender:nil];
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

//退回到上级界面
- (IBAction)back:(id)sender {
   
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    TreasureManageViewController * vc = [[TreasureManageViewController alloc] init];
    vc.isGoodsSetting = sender;
  
}


@end
