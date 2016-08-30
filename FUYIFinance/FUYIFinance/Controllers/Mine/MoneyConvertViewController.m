//
//  MoneyConvertViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/8/23.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MoneyConvertViewController.h"
#import "UIViewController+HUD.h"
#import "MyAPI.h"
@interface MoneyConvertViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *accountname;
@property (weak, nonatomic) IBOutlet UILabel *treasure;
@property (weak, nonatomic) IBOutlet UITextField *convertmoney;
@property (weak, nonatomic) IBOutlet UIButton *convertBtn;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation MoneyConvertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.convertBtn.layer.cornerRadius = 8;
    self.convertmoney.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification  object:self.convertmoney];
    
}

- (void)textFieldChanged:(NSNotification *)noti
{
    UITextField * textfield = noti.object;
    NSString * value = [NSString stringWithFormat:@"%@k优币",textfield.text];
    self.label.text = value;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:self.convertmoney];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.label.hidden = YES;
     NSString * account = [[Config Instance] getUserName];
    self.accountname.text = account;
    NSString * treasure = [[Config Instance] getMoney];
    self.treasure.text = treasure;
}

- (IBAction)SureConvertMoney:(id)sender {
    [Tools hideKeyBoard];
    if(self.convertmoney.text.length == 0){
        [self showHint:@"请输入兑换优币值"];
        return;
    }
    NSString * moneyvalue = self.convertmoney.text;
    NSInteger realucoinvalue = moneyvalue.integerValue * 1000;
    NSString * realucoin = [NSString stringWithFormat:@"%ld",realucoinvalue];
    [[MyAPI sharedAPI] convertUcoinWithUcoin:moneyvalue Result:^(BOOL sucess, NSString *msg) {
        if(sucess){
            [self showHint:@"充值成功"];
            NSString * olducoin = [[Config Instance] getUcoin];
            NSInteger olducoinvalue = olducoin.integerValue;
            NSInteger newucoinvalue = olducoinvalue + realucoinvalue;
            NSString * newucoin = [NSString stringWithFormat:@"%ld",newucoinvalue];
            [[Config Instance] saveUcoin:newucoin];
            NSDictionary * dict = [[NSDictionary alloc] init];
            dict = @{@"ucoin":newucoin};
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeucoin" object:nil userInfo:dict];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            if([msg isEqualToString:@"-1"]){
                [self logOut];
            }else{
                [self showHint:msg];
            }
        }
    } ErrorResult:^(NSError *enginerError) {
        
    }];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.label.hidden = NO;
    textField.placeholder = @"";
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [Tools hideKeyBoard];
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
