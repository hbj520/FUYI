//
//  MineRegisterViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/7.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MineRegisterViewController.h"
#import "UIViewController+HUD.h"
#import "MyAPI.h"
#import "Tools.h"

@interface MineRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *PhoneNum;    //手机号码
@property (weak, nonatomic) IBOutlet UITextField *testCode;    //验证码
@property (weak, nonatomic) IBOutlet UIButton *testBtn;        //发送验证码按钮
@property (weak, nonatomic) IBOutlet UITextField *password;    //密码
@property (weak, nonatomic) IBOutlet UITextField *repassword;  //确认密码
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;    //注册按钮

@end

@implementation MineRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.testBtn.layer.cornerRadius = 3;
    self.testBtn.layer.masksToBounds = YES;
    
    self.registerBtn.layer.cornerRadius = 6;
    self.registerBtn.layer.masksToBounds = YES;

}


//注册
- (IBAction)Register:(id)sender {
    NSString * phonenumber = self.PhoneNum.text;
    NSString * textcodenum = self.testCode.text;
    NSString * passwordnumber = self.password.text;
    NSString * repasswordnumber = self.repassword.text;
    if(![self.password.text isEqualToString:self.repassword.text]){
        [self showHint:@"请确认两次密码相同"];
        return;
    }
    if(self.testCode.text.length == 0){
        [self showHint:@"请输入验证码"];
        return;
    }else if (self.password.text.length<6){
        [self showHint:@"请输入不少于6位的密码"];
        return;
    }
    NSString * securitypasswordnumber = [Tools loginPasswordSecurityLock:passwordnumber];
    NSString * securityrepasswordnumber = [Tools loginPasswordSecurityLock:repasswordnumber];
    [[MyAPI sharedAPI] registerWithParameters:phonenumber Password:securitypasswordnumber RePassword:securityrepasswordnumber YZMNum:textcodenum result:^(BOOL sucess, NSString *msg) {
        if(sucess){
            [self showHint:@"注册成功，请登录"];
            
        }else{
            [self showHint:@"注册失败"];
        }
    } errorResult:^(NSError *enginerError) {
        
    }];
    
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
