//
//  SettingViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/22.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "SettingViewController.h"
#import "MineTableViewController.h"
#import "MyAPI.h"
#import "Config.h"
#import "UIViewController+HUD.h"
@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIButton * logoutBtn;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self ConfigUI];
    self.navigationController.navigationBarHidden = NO;
    
}

#pragma mark - PrivateMethod
- (void)ConfigUI
{
   // logoutBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, ScreenHeight-45, ScreenWidth, 45)];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel * desclabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 25, 60, 20)];
        desclabel.font = [UIFont systemFontOfSize:15];
        desclabel.text = @"头像";
        [cell.contentView addSubview:desclabel];
        UIImageView * arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth - 8 - 13, 25, 8, 14)];
        arrowView.image = [UIImage imageNamed:@"rightarrow"];
        [cell.contentView addSubview:arrowView];
        UIImageView * headImage = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth - 8 - 13 - 8 - 48, 8, 48, 48)];
        headImage.image = [UIImage imageNamed:@"person_headicon"];
        [cell.contentView addSubview:headImage];
        return cell;
    }else if (indexPath.row == 1){
        UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel * desclabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 17, 30, 20)];
        desclabel.font = [UIFont systemFontOfSize:15];
        desclabel.text = @"昵称";
        [cell.contentView addSubview:desclabel];
        UILabel * nicklabel = [[UILabel alloc] initWithFrame:CGRectMake(12 + 30 + 20, 17, 100, 20)];
        nicklabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        nicklabel.font = [UIFont systemFontOfSize:15];
        nicklabel.text = @"会飞的鱼";
        [cell.contentView addSubview:nicklabel];
        return cell;
        
    }else if (indexPath.row == 2){
        UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell3"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel * desclabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 17, 30, 20)];
        desclabel.font = [UIFont systemFontOfSize:15];
        desclabel.text = @"性别";
        [cell addSubview:desclabel];
        UILabel * sexlabel = [[UILabel alloc] initWithFrame:CGRectMake(12 + 30 + 20, 17, 30, 20)];
        sexlabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        sexlabel.font = [UIFont systemFontOfSize:15];
        sexlabel.text = @"男";
        [cell addSubview:sexlabel];
        return cell;
        
    }else if (indexPath.row == 3){
        UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell4"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(12, 17, 60, 20)];
        label.font = [UIFont systemFontOfSize:15];
        label.text = @"qq";
        [cell.contentView addSubview:label];
        UILabel * descLabel = [[UILabel alloc] initWithFrame:CGRectMake(12 + 30 + 20, 17, 120, 20)];
        descLabel.textAlignment = NSTextAlignmentLeft;
        descLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        descLabel.font = [UIFont systemFontOfSize:15];
        descLabel.text = @"232323323";
        [cell.contentView addSubview:descLabel];
        UIImageView * arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth - 8 - 13, 18, 8, 14)];
        arrowView.image = [UIImage imageNamed:@"rightarrow"];
        [cell.contentView addSubview:arrowView];
        return cell;
        
        
    }else if (indexPath.row == 4){
        UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell5"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(12, 17, 80, 20)];
        label.font = [UIFont systemFontOfSize:15];
        label.text = @"email";
        [cell.contentView addSubview:label];
        UILabel * detaillabel = [[UILabel alloc] initWithFrame:CGRectMake(12 + 30 + 20,17, 200, 20)];
        detaillabel.textAlignment = NSTextAlignmentLeft;
        detaillabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        detaillabel.font = [UIFont systemFontOfSize:15];
        detaillabel.text = @"232323223@qq.com";
        [cell.contentView addSubview:detaillabel];
        UIImageView * arrorView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth - 8 - 13, 18,8, 14)];
        arrorView.image = [UIImage imageNamed:@"rightarrow"];
        [cell.contentView addSubview:arrorView];
        return cell;
        
    }    return nil;
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
    
}

- (void)logout:(id)sender {
    [self showHudInView:self.view hint:@"正在退出登录"];
    
    [[MyAPI sharedAPI]LoginOutWithResult:^(BOOL sucess, NSString *msg) {
        if(sucess){
            [self showHint:msg];
            [[Config Instance] logout];
            [self hideHud];
            [self.navigationController popViewControllerAnimated:YES];
            self.navigationController.navigationBarHidden = YES;
                   }else{
            [self showHint:msg];
            [self hideHud];
        }
    } errorResult:^(NSError *enginerError) {
        
    }];
}


- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBarHidden = YES;
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
