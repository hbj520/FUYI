//
//  MyShopViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/4.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MyShopViewController.h"
#import "TreasureManageViewController.h"
#import "SettingViewController.h"
#import "MyOrderFlowViewController.h"
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
    NSString * teachername;
}
@end

@implementation MyShopViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //添加自定制导航栏按钮
    
    [self createUI];
    self.navigationController.navigationBarHidden = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh:) name:@"refreshView" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeStatus) name:@"changeState" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateImage) name:@"updateImage" object:nil];
}



- (void)refresh:(id)userinfo
{
    [_tableView reloadData];
}

- (void)changeStatus
{
    [_tableView reloadData];
}

- (void)updateImage
{
    [_tableView reloadData];
}

#pragma mark - PrivateMethod
- (void)createUI{
    [self initPickView];
    imageUrl = [[Config Instance] getBackImage];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"MyShopHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID1"];
    [_tableView registerNib:[UINib nibWithNibName:@"ShopTopTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID2"];
    [_tableView registerNib:[UINib nibWithNibName:@"FourBtnTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID3"];
    [_tableView registerNib:[UINib nibWithNibName:@"MyShopDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID4"];
    [self.view addSubview:_tableView];
    dataSource = [NSMutableArray array];
    [self loadData];
}
- (void)addRefresh
{
    __weak MyShopViewController * weakself = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself loadData];
    }];

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

#pragma mark-TableViewDelegate
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
        return 178;
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

        if(KToken){
            NSString * headimageUrl = [[Config Instance] getIcon];
            [cell.headicon sd_setImageWithURL:[NSURL URLWithString:headimageUrl] placeholderImage:[UIImage imageNamed:@"myorderthumbimage"]];
            cell.personlabel.hidden = NO;
            cell.backImg.userInteractionEnabled = YES;
            cell.teacherName.text = teacherinfo.username;
            teachername = teacherinfo.username;
            cell.totoalcount.text = teacherinfo.ordermoney;
            cell.vivstcount.text = teacherinfo.hits;
            cell.ordercount.text = teacherinfo.orders;
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choseImage)];
            cell.backImg.userInteractionEnabled = YES;
            [cell.backImg addGestureRecognizer:tap];
            if(imageUrl.length){
                [cell.backImg sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"personal_backImage"]];
            }

        }else{
            cell.backImg.userInteractionEnabled = NO;
            cell.backImg.image = [UIImage imageNamed:@"personal_backImage"];
            cell.headicon.image = [UIImage imageNamed:@"person_headicon"];
            cell.teacherName.text = @"未登录请登录";
            cell.personlabel.hidden = YES;
            cell.totoalcount.text = @"";
            cell.vivstcount.text = @"";
            cell.ordercount.text = @"";
            cell.block = ^(){
                [self logOut];
            };
        }
        [cell.loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
                return cell;
    }else if (indexPath.section==1){
        ShopTopTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID2" forIndexPath:indexPath];
        return cell;
    }else if (indexPath.section==2){
        FourBtnTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID3" forIndexPath:indexPath];
        __weak MyShopViewController * weakself = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

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
        if(indexPath.row == 0){
            UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"modifyId"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

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
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

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
                cell.selectionStyle = UITableViewCellSelectionStyleNone;

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
                cell.selectionStyle = UITableViewCellSelectionStyleNone;

                return cell;
                
            }
        }

    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section==0){
        UIView * view = [[UIView alloc] initWithFrame:CGRectZero];
        return view;
    }else{
        return nil;
    }
}

- (void)login
{
    [self logOut];
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
        if ([msg isEqualToString:@"登录超时"]) {
            [self logOut];
        }
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
    if(indexPath.section == 0){
        if(!KToken){
        [self logOut];
        }
    }
    if(indexPath.section == 3){
        if(indexPath.row == 0){
            if(!KToken){
                [self logOut];
            }else{
            [self performSegueWithIdentifier:@"MyShopModifyInfoSegue" sender:nil];
            }
        }else if (indexPath.row == 1){
            if(!KToken){
                [self logOut];
            }else{
                [self performSegueWithIdentifier:@"accountSegue" sender:nil];
            }
        }else{
            if(!KToken){
                [self logOut];
            }else{
            [self performSegueWithIdentifier:@"teachermessageSegue" sender:nil];
            }
        }
    }
    if(indexPath.section == 4){
        if(indexPath.row == 0){
            if(!KToken){
                [self logOut];
            }else{
            [self performSegueWithIdentifier:@"settingSegue" sender:@"isTeacher"];
            }
        }else{
            [self performSegueWithIdentifier:@"aboutSegue" sender:nil];
        }
    }
}

//发布宝贝
- (void)publishTreasure
{
    [self showHint:@"正在建设中"];
}

//宝贝管理
- (void)treasureManage
{
    if(!KToken){
        [self logOut];
    }else{
    [self performSegueWithIdentifier:@"treasureSegue" sender:[NSNumber numberWithBool:YES]];
    
    }
    }

//订单管理
- (void)orderManage
{
    if(!KToken){
        [self logOut];
    }else{
    [self performSegueWithIdentifier:@"ordermanageSegue" sender:teachername];
        UIView * contentView = [self.tabBarController.view.subviews objectAtIndex:0];
        contentView.frame = CGRectMake(0,0,ScreenWidth,0);
    }
}

//店铺设置
- (void)shopManage
{
    if(!KToken){
        [self logOut];
    }else{
    [self performSegueWithIdentifier:@"shopsettingSegue" sender:nil];
    }
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"refreshView" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"changeState" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"updateImage" object:nil];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"treasureSegue"]){
    TreasureManageViewController * vc = [[TreasureManageViewController alloc] init];
    vc.isGoodsSetting = sender;
    }else if ([segue.identifier isEqualToString:@"shopsettingSegue"]){
        SettingViewController * setVC = [[SettingViewController alloc] init];
        setVC.mortal = @"isTeacher";
    }else if ([segue.identifier isEqualToString:@"ordermanageSegue"]){
        MyOrderFlowViewController * vc = segue.destinationViewController;
        vc.teachername = sender;
    }
    
}


@end
