//
//  ModifyTradePasswordViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/8/25.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "ModifyTradePasswordViewController.h"
#import "UIViewController+HUD.h"
#import "Tools.h"
#import "MyAPI.h"
@interface ModifyTradePasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *oldtradepassword;   //旧的交易密码
@property (weak, nonatomic) IBOutlet UITextField *newtradepassword;   //新的交易密码
@property (weak, nonatomic) IBOutlet UITextField *committradepassword; //确认交易密码
@property (weak, nonatomic) IBOutlet UITextField *yzmword;    //手机验证码
@property (weak, nonatomic) IBOutlet UIButton *sendyzmbtn;
@property (weak, nonatomic) IBOutlet UIButton *surebtn;

@end

@implementation ModifyTradePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.surebtn.layer.cornerRadius = 8;
    self.surebtn.layer.masksToBounds = YES;
    
    self.sendyzmbtn.layer.cornerRadius = 3;
    self.sendyzmbtn.layer.masksToBounds = YES;
   
}


- (IBAction)sendYZM:(id)sender {
    
}


- (IBAction)sure:(id)sender {
    [Tools hideKeyBoard];
    if(self.oldtradepassword.text.length==0){
        [self showHint:@"交易密码不能为空"];
    }else if (self.newtradepassword.text.length == 0){
        [self showHint:@"交易密码不能为空"];
    }else if (self.committradepassword.text.length == 0){
        [self showHint:@"交易密码不能为空"];
    }else if(self.yzmword.text.length == 0){
        [self showHint:@"验证码输入不能为空"];
    }
    NSString * SecurityOldTradeWord = [Tools loginPasswordSecurityLock:self.oldtradepassword.text];
    NSString * SecurityNewTradeWord = [Tools loginPasswordSecurityLock:self.newtradepassword.text];
    NSString * SecurityCommitTradeWord = [Tools loginPasswordSecurityLock:self.committradepassword.text];
    
    
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
