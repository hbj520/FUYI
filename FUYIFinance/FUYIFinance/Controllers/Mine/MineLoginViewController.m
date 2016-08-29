//
//  MineLoginViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/7.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MineLoginViewController.h"
#import "MineRegisterViewController.h"
#import "MyShopViewController.h"

#import "UIViewController+HUD.h"
#import "MyAPI.h"
#import "Tools.h"

@interface MineLoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *numberInput;    //手机号码

@property (weak, nonatomic) IBOutlet UITextField *passwordInput;  //密码

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;          //登录按钮
- (IBAction)backBtn:(id)sender;

- (IBAction)loginBtn:(id)sender;

- (IBAction)forgotPassword:(id)sender;

- (IBAction)registerBtn:(id)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toplayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *distancewithtoplayout;
@property (nonatomic,strong) UINavigationController *myNav;
@property (assign,nonatomic) BOOL isTeacher;

@end

@implementation MineLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.numberInput.delegate = self;
    self.passwordInput.delegate = self;
   // self.myNav = [[UINavigationController alloc] init];
    self.navigationController.navigationBarHidden = NO;
    if(self.view.frame.size.height == 480){
        self.toplayout.constant = 30;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textfieldIsEditing:) name:UITextFieldTextDidChangeNotification object:nil];
}

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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
#pragma mark-PrivateMethod
- (void)loginSucessAct{
    //@{@"isTech":[NSNumber numberWithBool:self.isTeacher]}
   // NSNotification * notification = [NSNotification notificationWithName:@"refreshView" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshView" object:nil userInfo:@{@"isTech":[NSNumber numberWithBool:self.isTeacher],@"refresh":@"yes"}];
   [self dismissModalViewControllerAnimated:YES];
    [self.tabBarController setSelectedIndex:3];
}
- (IBAction)backBtn:(id)sender {
    [self dismissModalViewControllerAnimated:YES];

}
//登录

- (IBAction)loginBtn:(id)sender {
    NSString * phoneNum = self.numberInput.text;
    NSString * password = self.passwordInput.text;
    NSString * securityString = [Tools loginPasswordSecurityLock:password];
    [self showHudInView:self.view hint:@"正在登陆"];
    [[MyAPI sharedAPI] LoginWithNumber:phoneNum
                              password:securityString
                                result:^(BOOL sucess, NSString *msg) {
        if(sucess){
            [self showHint:@"登陆成功!"];
            NSString * IsTeacherOrNot = [[Config Instance] getisteacher];
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

@end
