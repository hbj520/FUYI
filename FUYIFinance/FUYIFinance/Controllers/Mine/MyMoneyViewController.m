//
//  MyMoneyViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/8/23.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MyMoneyViewController.h"
#import "Config.h"

@interface MyMoneyViewController ()
{
    NSString * ucoinValue;
}
@property (weak, nonatomic) IBOutlet UILabel *YouBiCount;

@end

@implementation MyMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.YouBiCount.layer.cornerRadius = 76.5;
    //self.YouBiCount.layer.masksToBounds = YES;
    self.YouBiCount.layer.borderWidth = 2;
    self.YouBiCount.layer.borderColor = [UIColor colorWithRed:222/255.0 green:94/255.0 blue:136/255.0 alpha:1].CGColor;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateucoin:) name:@"changeucoin" object:nil];
    if(ucoinValue){
        NSInteger ucoin = ucoinValue.integerValue;
        NSInteger newucoin = ucoin/1000;
        NSString * ucoinstring = [NSString stringWithFormat:@"%ldk",newucoin];
        self.YouBiCount.text = ucoinstring;
    }else{
        NSString * ucoin = [[Config Instance] getUcoin];
        NSInteger uCoin = ucoin.integerValue;
        NSInteger newucoin = uCoin/1000;
        NSString * ucoinstring = [NSString stringWithFormat:@"%ldk",newucoin];
        self.YouBiCount.text = ucoinstring;
    }
 
    if(self.YouBiCount.text.length>3){
        self.YouBiCount.font = [UIFont systemFontOfSize:25];
    }
    self.navigationController.navigationBarHidden = NO;
}

- (void)updateucoin:(NSNotification *)noti
{
    NSString * ucoinvalue = noti.userInfo[@"ucoin"];
    NSLog(@"ucoinvalue = %@",ucoinvalue);
    ucoinValue = ucoinvalue;
}

- (IBAction)ConvertYouBi:(id)sender {
    [self performSegueWithIdentifier:@"convertSegue" sender:nil];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBar.hidden = YES;
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
