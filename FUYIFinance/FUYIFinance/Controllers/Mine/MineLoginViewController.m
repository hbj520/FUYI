//
//  MineLoginViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/7.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MineLoginViewController.h"
#import "UIViewController+HUD.h"
#import "MyAPI.h"
#import "Tools.h"

@interface MineLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *numberInput;    //手机号码

@property (weak, nonatomic) IBOutlet UITextField *passwordInput;  //密码

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;          //登录按钮

- (IBAction)loginBtn:(id)sender;

- (IBAction)forgotPassword:(id)sender;

- (IBAction)registerBtn:(id)sender;


@end

@implementation MineLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

//登录
- (IBAction)loginBtn:(id)sender {
    NSString * phoneNum = self.numberInput.text;
    NSString * password = self.passwordInput.text;
    NSString * securityString = [Tools loginPasswordSecurityLock:password];
    [[MyAPI sharedAPI] LoginWithNumber:phoneNum password:securityString result:^(BOOL sucess, NSString *msg) {
        if(sucess){
            [self showHint:@"登陆成功!"];
        }else{
            [self showHint:msg];
        }
    } errorResult:^(NSError *enginerError) {
        [self showHint:@"登录出错"];
        [self hideHud];
    }];
}

//忘记密码
- (IBAction)forgotPassword:(id)sender {
    
    [self performSegueWithIdentifier:@"forgetSegue" sender:nil];

}

//注册账号
- (IBAction)registerBtn:(id)sender {
    
    [self performSegueWithIdentifier:@"registerSegue" sender:nil];

}

@end
