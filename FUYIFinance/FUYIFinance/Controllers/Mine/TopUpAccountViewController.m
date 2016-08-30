//
//  TopUpAccountViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/8/23.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "TopUpAccountViewController.h"

@interface TopUpAccountViewController ()
@property (weak, nonatomic) IBOutlet UIButton *topupBtn;
@property (weak, nonatomic) IBOutlet UITextField *accountname;
@property (weak, nonatomic) IBOutlet UITextField *money;

@end

@implementation TopUpAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.topupBtn.layer.cornerRadius = 7;
    self.navigationController.navigationBarHidden = NO;
}

//确认充值
- (IBAction)sureTopUp:(id)sender {
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [Tools hideKeyBoard];
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
