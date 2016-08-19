//
//  ReGetViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/8.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "ReGetViewController.h"
#import "UIViewController+HUD.h"
#import "MyAPI.h"
#import "Tools.h"
#import "HexColor.h"

@interface ReGetViewController ()<UITextFieldDelegate>
{
    NSTimer *timer;
    NSInteger time;
}
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;            //手机号码
@property (weak, nonatomic) IBOutlet UITextField *yzmNum;              //验证码
@property (weak, nonatomic) IBOutlet UITextField *passwordNum;         //密码
@property (weak, nonatomic) IBOutlet UITextField *confirmpasswordNum;  //确定密码
@property (weak, nonatomic) IBOutlet UIButton *testBtn;                //发送验证码按钮
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;                //确定按钮
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *distancewithtoplayout;

@end

@implementation ReGetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.testBtn.layer.cornerRadius = 3;
    self.testBtn.layer.masksToBounds = YES;
    
    self.sureBtn.layer.cornerRadius = 6;
    self.sureBtn.layer.masksToBounds = YES;
    
    self.phoneNum.delegate = self;
    self.yzmNum.delegate = self;
    self.passwordNum.delegate = self;
    self.confirmpasswordNum.delegate = self;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    //self.distancewithtoplayout.constant = 210;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
  //  self.distancewithtoplayout.constant = 0;
}


//发送验证码
- (IBAction)testCode:(id)sender {
    [Tools hideKeyBoard];
    if(self.phoneNum.text.length<11){
        [self showHint:@"请输入正确的手机号"];
        return;
    }
    [self setTimeSchedu];
    [[MyAPI sharedAPI] sendYZMWithParameters:self.phoneNum.text result:^(BOOL sucess, NSString *msg) {
        if(sucess){
            [self showHint:@"发送验证码成功"];
        }else{
            [self showHint:msg];
        }
    } errorResult:^(NSError *enginerError) {
        [self showHint:@"发送验证码失败"];
    }];
}


//确定按钮
- (IBAction)sureBtn:(id)sender {
    [Tools hideKeyBoard];
    if(self.passwordNum.text.length==0||self.confirmpasswordNum.text.length==0){
        [self showHint:@"输入不能为空"];
        return;
    }
    
  
    if(![self.passwordNum.text isEqualToString:self.confirmpasswordNum.text]){
        [self showHint:@"输入密码不同"];
        return;
    }
    NSString * passwordnum = [Tools loginPasswordSecurityLock:self.passwordNum.text];
    NSString * repasswordnum = [Tools loginPasswordSecurityLock:self.confirmpasswordNum.text];
   [[MyAPI sharedAPI] forgetPasswordWithPhonenum:self.phoneNum.text YZM:self.yzmNum.text Password:passwordnum Repassword:repasswordnum result:^(BOOL sucess, NSString *msg) {
       if(sucess){
           [self showHint:msg];
           [self.navigationController popViewControllerAnimated:YES];
       }else{
           [self showHint:msg];
       }
   } errorResult:^(NSError *enginerError) {
       
   }];
    
}

- (void)setTimeSchedu
{
    self.testBtn.enabled = NO;
    [self.testBtn setBackgroundColor:[UIColor lightGrayColor]];
    [self.testBtn setTitle:@"60" forState:UIControlStateNormal];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(timeAct:) userInfo:nil repeats:YES];
    time = 60;
    [timer fire];
}
- (void)timeAct:(id)sender
{
    if(time == 0){
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
