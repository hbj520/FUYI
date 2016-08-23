//
//  MoneyConvertViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/8/23.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MoneyConvertViewController.h"

@interface MoneyConvertViewController ()
@property (weak, nonatomic) IBOutlet UILabel *accountname;
@property (weak, nonatomic) IBOutlet UILabel *treasure;
@property (weak, nonatomic) IBOutlet UITextField *convertmoney;
@property (weak, nonatomic) IBOutlet UIButton *convertBtn;

@end

@implementation MoneyConvertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.convertBtn.layer.cornerRadius = 8;
}


- (IBAction)SureConvertMoney:(id)sender {
    
}

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
