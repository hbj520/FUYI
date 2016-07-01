//
//  ProductJudgeViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/1.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "ProductJudgeViewController.h"

@interface ProductJudgeViewController ()
{
    BOOL IsCommit;
}
@property (weak, nonatomic) IBOutlet UIButton *surebtn;

@end

@implementation ProductJudgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.surebtn.layer.cornerRadius = 3;
    self.surebtn.clipsToBounds = YES;
}

- (IBAction)Commit:(UIButton*)sender {
    IsCommit = !IsCommit;
    if(IsCommit){
        [sender setImage:[UIImage imageNamed:@"btnhighlighted"] forState:UIControlStateNormal];
    }else{
        [sender setImage:[UIImage imageNamed:@"btndark"] forState:UIControlStateNormal];
    }
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
