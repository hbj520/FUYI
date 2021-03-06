//
//  AccountSaftyViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/8/8.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "AccountSaftyViewController.h"
#import "UIViewController+HUD.h"
#import "Config.h"
#import "Tools.h"

@interface AccountSaftyViewController ()

@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@property (weak, nonatomic) IBOutlet UITextField *oldpassword;
@property (weak, nonatomic) IBOutlet UITextField *newpassword;
@property (weak, nonatomic) IBOutlet UITextField *comfirmpassword;
@end

@implementation AccountSaftyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.commitBtn.layer.cornerRadius = 6;
    self.commitBtn.layer.masksToBounds = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (IBAction)reviseAction:(id)sender {
    [Tools hideKeyBoard];
    
    if(self.oldpassword.text.length == 0 || self.newpassword.text.length == 0 || self.comfirmpassword.text.length == 0){
        [self showHint:@"输入不能为空"];
        return;
    }
    
    if(!(self.newpassword.text.length >= 6 && self.newpassword.text.length <= 20))
    {
        [self showHint:@"密码长度不符合要求"];
        return;
    }
    if(!(self.comfirmpassword.text.length >= 6 && self.comfirmpassword.text.length <= 20)){
        [self showHint:@"密码长度不符合要求"];
        return;
    }
    if([self.newpassword.text isEqualToString:self.comfirmpassword.text]){
        [self showHudInView:self.view hint:@"修改中"];
        NSString * oldSecurityString = [Tools loginPasswordSecurityLock:self.oldpassword.text];
        NSLog(@"%@",oldSecurityString);
        NSString * newSecurityString = [Tools loginPasswordSecurityLock:self.newpassword.text];
        [[MyAPI sharedAPI] reSetPasswordWithOldPassword:oldSecurityString newPassword:newSecurityString Result:^(BOOL sucess, NSString *msg) {
            if(sucess){
                [[Config Instance] saveUserPassword:newSecurityString];
                [[Config Instance]logout];
                [self showHint:@"修改成功"];
                [self RebuildlogOut];
            }else{
                [self showHint:@"修改失败"];
            }
            [self hideHud];
        } errorResult:^(NSError *enginerError) {
            [self showHint:@"修改出错"];
        }];
    }else{
        [self showHint:@"两次密码输入不一样"];
    }

    
}

- (void)RebuildlogOut{
    if (KToken) {
        [[Config Instance] logout];
    }
//    UIStoryboard *storybord = [UIStoryboard storyboardWithName:@"Mine" bundle:nil];
//    UINavigationController *mineVC = [storybord instantiateViewControllerWithIdentifier:@"MineStoryBordId"];
//    mineVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    [self.navigationController presentModalViewController:mineVC animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
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
