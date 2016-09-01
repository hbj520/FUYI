//
//  MineRegisterViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/7.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MineRegisterViewController.h"
#import "ModifyTradePasswordViewController.h"
#import "UIViewController+HUD.h"
#import "HexColor.h"
#import "MyAPI.h"
#import "Tools.h"

@interface MineRegisterViewController ()<UITextFieldDelegate>
{
    NSTimer *timer;
    NSInteger time;
}
@property (weak, nonatomic) IBOutlet UITextField *PhoneNum;    //手机号码
@property (weak, nonatomic) IBOutlet UITextField *testCode;    //验证码
@property (weak, nonatomic) IBOutlet UIButton *testBtn;        //发送验证码按钮
@property (weak, nonatomic) IBOutlet UITextField *password;    //密码
@property (weak, nonatomic) IBOutlet UITextField *repassword;  //确认密码
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;    //注册按钮
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toplayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *distancewithtop;

@end

@implementation MineRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.testBtn.layer.cornerRadius = 3;
    self.testBtn.layer.masksToBounds = YES;
    
    self.registerBtn.layer.cornerRadius = 6;
    self.registerBtn.layer.masksToBounds = YES;
    if(self.view.frame.size.height == 480){
        self.toplayout.constant = 10;
    }
    self.PhoneNum.delegate = self;
    self.testCode.delegate = self;
    self.password.delegate = self;
    self.repassword.delegate = self;
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(self.view.frame.size.height == 480){
    self.distancewithtop.constant = -150;
    }
    if(self.view.frame.size.height == 568){
        self.distancewithtop.constant = -70;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.distancewithtop.constant = 0;
}

- (void)setTimeSchedu{
    self.testBtn.enabled = NO;
    [self.testBtn setBackgroundColor:[UIColor lightGrayColor]];
    [self.testBtn setTitle:@"60" forState:UIControlStateNormal];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(timeAct:) userInfo:nil repeats:YES];
    time = 60;
    [timer fire];
}

- (void)timeAct:(id)sender{
    if (time == 0) {
        [timer invalidate];
        self.testBtn.enabled = YES;
        [self.testBtn setBackgroundColor:[UIColor colorWithHexString:@"FF5000"]];
        [self.testBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    }else{
        time--;
        [self.testBtn setTitle:[NSString stringWithFormat:@"%ld",time] forState:UIControlStateNormal];
        [self.testBtn setBackgroundColor:[UIColor lightGrayColor]];
    }
}

//发送验证码
- (IBAction)sendYZm:(id)sender {
    [Tools hideKeyBoard];
    if(self.PhoneNum.text.length < 11){
        [self showHint:@"请输入正确的手机号"];
        return;
    }
    [self setTimeSchedu];
    [[MyAPI sharedAPI] registerWithParameters:self.PhoneNum.text result:^(BOOL sucess, NSString *msg) {
        if(sucess){
            [self showHint:@"验证码发送成功，请注意查看短信"];
        }else{
            time = 0;
            [self showHint:@"验证码发送失败"];
        }
    } errorResult:^(NSError *enginerError) {
        [self showHint:@"验证码发送出错"];
    }];
    
}


//注册
- (IBAction)Register:(id)sender {
    NSString * phonenumber = self.PhoneNum.text;
    NSString * textcodenum = self.testCode.text;
    NSString * passwordnumber = self.password.text;
    NSString * repasswordnumber = self.repassword.text;
    [Tools hideKeyBoard];
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
    [self showHudInView:self.view hint:@"注册..."];
    NSString * securitypasswordnumber = [Tools loginPasswordSecurityLock:passwordnumber];
    NSString * securityrepasswordnumber = [Tools loginPasswordSecurityLock:repasswordnumber];
    [[MyAPI sharedAPI] registerWithParameters:phonenumber
                                     Password:securitypasswordnumber
                                   RePassword:securityrepasswordnumber
                                       YZMNum:textcodenum
                                       result:^(BOOL sucess, NSString *msg) {
        if(sucess){
            [self showHint:@"注册成功，请登录"];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            [self showHint:msg];
        }
       [self hideHud];
    } errorResult:^(NSError *enginerError) {
        [self hideHud];
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

//返回
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"modifytradeSegue"]){
        ModifyTradePasswordViewController * vc = segue.destinationViewController;
        vc.identify = sender;
    }
}


@end
