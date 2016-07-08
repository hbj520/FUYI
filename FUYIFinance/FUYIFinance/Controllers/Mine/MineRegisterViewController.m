//
//  MineRegisterViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/7.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MineRegisterViewController.h"

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
