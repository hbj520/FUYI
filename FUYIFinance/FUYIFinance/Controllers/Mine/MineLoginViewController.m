//
//  MineLoginViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/7.
//  Copyright © 2016年 youyou. All rights reserved.
//             登录控制器

#import "MineLoginViewController.h"
#import "MineRegisterViewController.h"
#import "MyShopViewController.h"
#import "CHSocialService.h"

#import "UIViewController+HUD.h"
#import "MyAPI.h"
#import "Tools.h"
#import "ThirdPlatformViewController.h"

@interface MineLoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *numberInput;    //手机号码

@property (weak, nonatomic) IBOutlet UITextField *passwordInput;  //密码

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;          //登录按钮
- (IBAction)backBtn:(id)sender;

- (IBAction)loginBtn:(id)sender;

- (IBAction)forgotPassword:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *qqLogin;
@property (weak, nonatomic) IBOutlet UIButton *weiboLogin;
@property (weak, nonatomic) IBOutlet UIButton *wechatLogin;

- (IBAction)registerBtn:(id)sender;
- (IBAction)qqLogin:(id)sender;
- (IBAction)weiboLogin:(id)sender;
- (IBAction)wechatLogin:(id)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toplayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *distancewithtoplayout;
@property (weak, nonatomic) IBOutlet UILabel *otherWayLoginLabel;
@property (nonatomic,strong) UINavigationController *myNav;
@property (assign,nonatomic) BOOL isTeacher;

@end

@implementation MineLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.numberInput.delegate = self;
    self.passwordInput.delegate = self;
    self.loginBtn.enabled = NO;
    
   // self.myNav = [[UINavigationController alloc] init];
    //self.navigationController.navigationBarHidden = NO; // 省去。
    
    if(self.view.frame.size.height == 480){
        self.toplayout.constant = 30;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textfieldIsEditing:) name:UITextFieldTextDidChangeNotification object:nil];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self verifyThirdPlatform];
}
//  适配4s
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(self.view.frame.size.height==480){
    self.distancewithtoplayout.constant = -70;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(self.view.frame.size.height==480){
    self.distancewithtoplayout.constant = 0;
    }
}

#pragma mark - PrivateMethod
- (void)textfieldIsEditing:(NSNotification *)notification{
    if (self.numberInput.text.length >= 11) {
        [self.loginBtn setImage:[UIImage imageNamed:@"login_enablebtn"] forState:UIControlStateNormal];
        self.loginBtn.enabled = YES;
    }else{
        [self.loginBtn setImage:[UIImage imageNamed:@"login_unablebtn"] forState:UIControlStateNormal];
        self.loginBtn.enabled = NO;
    }
}
//   有什么作用？？
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [self.view endEditing:YES];
//}

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
#pragma mark-PrivateMethod
- (void)verifyThirdPlatform{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]])
    {
        self.qqLogin.hidden = NO;
       // NSLog(@"install--");
    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"sinaweibo://"]])
    {
        self.weiboLogin.hidden = NO;
       // NSLog(@"install--");
    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]])
    {
        self.wechatLogin.hidden = NO;
      //  NSLog(@"install--");
    }
    
}
- (void)loginSucessAct{
    //@{@"isTech":[NSNumber numberWithBool:self.isTeacher]}
   // NSNotification * notification = [NSNotification notificationWithName:@"refreshView" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshView" object:nil userInfo:@{@"isTech":[NSNumber numberWithBool:self.isTeacher],@"refresh":@"yes"}];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tabBarController setSelectedIndex:4];
}
/** 点击按钮返回上一页，让当前控制器消失。 */
- (IBAction)backBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}
//登录
- (IBAction)loginBtn:(id)sender {
    NSString * phoneNum = self.numberInput.text;
    NSString * password = self.passwordInput.text;
    NSString * securityString = [Tools loginPasswordSecurityLock:password];
    [Tools hideKeyBoard];
    [self showHudInView:self.view hint:@"正在登陆"];
    [[MyAPI sharedAPI] LoginWithNumber:phoneNum
                              password:securityString
                                result:^(BOOL sucess, NSString *msg) {
        if(sucess){
            [self showHint:@"登陆成功!"];
            NSString * IsTeacherOrNot = [[Config Instance] getisteacher];
            [[Config Instance] savePhoneNum:phoneNum];
            if([IsTeacherOrNot isEqualToString:@"1"]){
                self.isTeacher = YES;
            }else{
                self.isTeacher = NO;
            }
            [self loginSucessAct];
        }else{
            
            [self showHint:msg];
        }
       [self hideHud];

    } errorResult:^(NSError *enginerError) {
        [self showHint:@"登录出错"];
        [self hideHud];
        
    }];
}

//忘记密码
- (IBAction)forgotPassword:(id)sender {

}

//注册账号
- (IBAction)registerBtn:(id)sender {
    
}

- (IBAction)qqLogin:(id)sender {
    NSLog(@"点击qq登录！！！");
    [[CHSocialServiceCenter shareInstance]loginInAppliactionType:CHSocialQQ controller:self completion:^(CHSocialResponseData *response) {
        if (response.openId) {
            [self thirdLoginWithPlatform:@"1" openId:response.openId nickName:response.userName iconUrl:response.iconURL];
            
        }
     
        
        
    }];
}

- (IBAction)weiboLogin:(id)sender {
    NSLog(@"点击weibo登录！！！");
 
    [[CHSocialServiceCenter shareInstance]loginInAppliactionType:CHSocialSina controller:self completion:^(CHSocialResponseData *response) {
        if (response.usid) {
                [self thirdLoginWithPlatform:@"3" openId:response.usid nickName:response.userName iconUrl:response.iconURL];
        }
        
        
        
    }];
}

- (IBAction)wechatLogin:(id)sender {
    NSLog(@"点击weixin登录！！！");

    [[CHSocialServiceCenter shareInstance]loginInAppliactionType:CHSocialWeChat controller:self completion:^(CHSocialResponseData *response) {
        if (response.openId) {
            [self thirdLoginWithPlatform:@"2"
                                  openId:response.openId
                                nickName:response.userName
                                 iconUrl:response.iconURL];
            
        }

    }];
}
- (void)thirdLoginWithPlatform:(NSString *)platform
                        openId:(NSString *)openId
                      nickName:(NSString *)nickName
                       iconUrl:(NSString *)iconUrl {
    [[MyAPI sharedAPI] ThirdPlatformLoginWithParamters:platform
                                           thirdOpenId:openId
                                                result:^(BOOL success, NSString *msg, id object) {
        
        if (success) {
            //已经绑定的直接登录
            [self showHint:@"登陆成功!"];
            NSString * IsTeacherOrNot = [[Config Instance] getisteacher];
            if([IsTeacherOrNot isEqualToString:@"1"]){
                self.isTeacher = YES;
            }else{
                self.isTeacher = NO;
            }
            [self loginSucessAct];
        }else{
            //未绑定的进行账号绑定
            [self performSegueWithIdentifier:@"thirdplatformSegue" sender:@[platform,openId,nickName,iconUrl]];
        }
    } errorResult:^(NSError *enginerError) {
        
        
    }];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"thirdplatformSegue"]) {
        ThirdPlatformViewController *thirdPlatformVC = segue.destinationViewController;
        thirdPlatformVC.thirdPlatformData = (NSArray *)sender;
    }
}
@end
