//
//  ModfyNickNameViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/21.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "ModfyNickNameViewController.h"

@interface ModfyNickNameViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nicknamefield;

@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@end

@implementation ModfyNickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nicknamefield.delegate = self;
    self.saveBtn.layer.cornerRadius = 6;
    self.saveBtn.layer.masksToBounds = YES;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

//保存昵称
- (IBAction)saveNickname:(id)sender {
    NSDictionary * dict = [[NSDictionary alloc] initWithObjectsAndKeys:self.nicknamefield.text,@"nickname" ,nil];
    NSNotification * notification = [NSNotification notificationWithName:@"returnnick" object:nil userInfo:dict];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    [self.navigationController popViewControllerAnimated:YES];
}

//返回
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
