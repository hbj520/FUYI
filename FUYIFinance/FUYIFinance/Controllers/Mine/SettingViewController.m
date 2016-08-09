//
//  SettingViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/22.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "SettingViewController.h"
#import "MineTableViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MyAPI.h"
#import "Config.h"
#import "PersonalUserInfo.h"
#import "UIViewController+HUD.h"
@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIButton * logoutBtn;            //退出登录按钮
    PersonalUserInfo * userinfo;     //个人信息
    NSString * nickName;             //昵称
    NSString * sexLabel;             //性别
    NSString * qqNum;                //qq号
    NSString * emailNum;             //邮箱号
    NSString * imgthumb;             //头像
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}


#pragma mark - PrivateMethod
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self ConfigUI];
    self.navigationController.navigationBarHidden = NO;
    
}

//搭界面
- (void)ConfigUI
{
   // logoutBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, ScreenHeight-45, ScreenWidth, 45)];
    [self loadData];
    logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutBtn.frame = CGRectMake(0, ScreenHeight - 45, ScreenWidth, 45);
    logoutBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    logoutBtn.backgroundColor = [UIColor colorWithRed:217/255.0 green:29/255.0 blue:21/255.0 alpha:1];
    [logoutBtn addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
    UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2 - 88, ScreenHeight - 33, 88 * 2, 20)];
    name.backgroundColor = [UIColor colorWithRed:217/255.0 green:29/255.0 blue:21/255.0 alpha:1];
    name.textColor = [UIColor whiteColor];
    name.text = @"退出登录";
    name.textAlignment = NSTextAlignmentCenter;
    name.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:logoutBtn];
    [self.view addSubview:name];
}

//加载数据
- (void)loadData
{
    [[MyAPI sharedAPI] PersonalDetailInfoWith:^(BOOL success, NSString *msg, id object) {
        if(success){
        userinfo = object;
        nickName = userinfo.userName;
        sexLabel = userinfo.sex;
        qqNum = userinfo.qqNum;
        emailNum = userinfo.email;
        imgthumb = userinfo.imgthumb;
        [self.tableView reloadData];
        }
    } errorResult:^(NSError *enginerError) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel * desclabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 25, 60, 20)];
        desclabel.font = [UIFont systemFontOfSize:15];
        desclabel.text = @"头像";
        desclabel.textColor = [UIColor darkGrayColor];
        [cell.contentView addSubview:desclabel];
        UIImageView * headImage = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth - 8 - 13 - 8 - 48, 8, 48, 48)];
        headImage.layer.cornerRadius = 24;
        headImage.layer.masksToBounds = YES;
        [headImage sd_setImageWithURL:[NSURL URLWithString:imgthumb] placeholderImage:[UIImage imageNamed:@"defaulticon"]];
        [cell.contentView addSubview:headImage];
        return cell;
    }else if (indexPath.row == 1){
        UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel * desclabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 15, 30, 20)];
        desclabel.font = [UIFont systemFontOfSize:15];
        desclabel.text = @"昵称";
        [cell.contentView addSubview:desclabel];
        desclabel.textColor = [UIColor darkGrayColor];
        UILabel * nicklabel = [[UILabel alloc] initWithFrame:CGRectMake(12 + 30 + 20, 15, 100, 20)];
        nicklabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        nicklabel.font = [UIFont systemFontOfSize:15];
        nicklabel.text = nickName;
        [cell.contentView addSubview:nicklabel];
        return cell;
        
    }else if (indexPath.row == 2){
        UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell3"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel * desclabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 15, 30, 20)];
        desclabel.font = [UIFont systemFontOfSize:15];
        desclabel.text = @"性别";
        desclabel.textColor = [UIColor darkGrayColor];
        [cell addSubview:desclabel];
        UILabel * sexlabel = [[UILabel alloc] initWithFrame:CGRectMake(12 + 30 + 20, 15, 30, 20)];
        sexlabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        sexlabel.font = [UIFont systemFontOfSize:15];
        sexlabel.text = sexLabel;
        [cell addSubview:sexlabel];
        return cell;
        
    }else if (indexPath.row == 3){
        UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell4"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(12, 15, 60, 20)];
        label.font = [UIFont systemFontOfSize:15];
        label.text = @"qq";
        label.textColor = [UIColor darkGrayColor];
        [cell.contentView addSubview:label];
        UILabel * descLabel = [[UILabel alloc] initWithFrame:CGRectMake(12 + 30 + 20, 15, 120, 20)];
        descLabel.textAlignment = NSTextAlignmentLeft;
        descLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        descLabel.font = [UIFont systemFontOfSize:15];
        descLabel.text = qqNum;
        [cell.contentView addSubview:descLabel];
        return cell;
    }else if (indexPath.row == 4){
        UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell5"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(12, 15, 80, 20)];
        label.font = [UIFont systemFontOfSize:15];
        label.text = @"email";
        label.textColor = [UIColor darkGrayColor];
        [cell.contentView addSubview:label];
        UILabel * detaillabel = [[UILabel alloc] initWithFrame:CGRectMake(12 + 30 + 20,15, 200, 20)];
        detaillabel.textAlignment = NSTextAlignmentLeft;
        detaillabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        detaillabel.font = [UIFont systemFontOfSize:15];
        detaillabel.text = emailNum;
        [cell.contentView addSubview:detaillabel];
        return cell;
        
    }else if (indexPath.row == 5){
        UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"gestureId"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(12, 15, 80, 20)];
        label.font = [UIFont systemFontOfSize:15];
        label.text = @"安全设置";
        label.textColor = [UIColor darkGrayColor];
        [cell.contentView addSubview:label];
        UILabel *isSetGesLockLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth - 80, 15, 50, 20)];
        if (KGesturePsassword) {
            isSetGesLockLabel.text = @"已设置";
            isSetGesLockLabel.textColor = [UIColor greenColor];
        }else{
            isSetGesLockLabel.text = @"未设置";
            isSetGesLockLabel.textColor = [UIColor redColor];
        }
        isSetGesLockLabel.font = [UIFont systemFontOfSize:15];
        [cell.contentView addSubview:isSetGesLockLabel];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        return 65;
    }else{
        return 50;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 5) {//手势密码
        [self performSegueWithIdentifier:@"GestureSegue" sender:nil];
    }
}

- (void)logout:(id)sender {
    [self showHudInView:self.view hint:@"正在退出登录"];
    
    
    [[MyAPI sharedAPI]LoginOutWithResult:^(BOOL sucess, NSString *msg) {
        if(sucess){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeState" object:nil userInfo:nil];
            [self showHint:msg];
            [[Config Instance] logout];
            [self hideHud];
            [self.navigationController popViewControllerAnimated:YES];
            self.navigationController.navigationBarHidden = YES;
                   }else{
            [self.navigationController popViewControllerAnimated:YES];
            self.navigationController.navigationBarHidden = YES;

            [self showHint:msg];
            [self hideHud];
        }
    } errorResult:^(NSError *enginerError) {
        
    }];
}


- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    if([self.mortal isEqualToString:@"isTeacher"]){
        self.navigationController.navigationBarHidden = NO;
    }else{
    self.navigationController.navigationBarHidden = YES;
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
