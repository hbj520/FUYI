//
//  PublishStockViewController.m
//  FUYIFinance
//
//  Created by youyou on 17/1/5.
//  Copyright © 2017年 youyou. All rights reserved.
//

#import "PublishStockViewController.h"
#import "UIViewController+HUD.h"
@interface PublishStockViewController ()<UITextInput>
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *stockCodeTextfield;
@property (weak, nonatomic) IBOutlet UITextField *stockNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *stockAnalyzeTileTextField;
@property (weak, nonatomic) IBOutlet UITextView *stockContentTextView;
@property (weak, nonatomic) IBOutlet UIButton *confirmStockBtn;
- (IBAction)confirmStockBtn:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLayoutConstraint;

@end

@implementation PublishStockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewChanged:) name:UITextViewTextDidBeginEditingNotification  object:self.stockContentTextView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewEndChanged:) name:UITextViewTextDidEndEditingNotification  object:self.stockContentTextView];
    // Do any additional setup after loading the view.
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

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)confirmStockBtn:(id)sender {
    if (self.stockNameTextField.text.length > 0 && self.stockCodeTextfield.text.length > 0 && self.stockAnalyzeTileTextField.text.length > 0 && self.stockContentTextView.text.length > 0) {
        [[MyAPI sharedAPI] publishStockWithStockCode:self.stockCodeTextfield.text
                                           stockName:self.stockNameTextField.text
                                       analysisTitle:self.stockAnalyzeTileTextField.text
                                     analysisContent:self.stockContentTextView.text
                                              result:^(BOOL sucess, NSString *msg) {
                                                  [self showHint:@"提交成功"];
                                                  [self.navigationController popViewControllerAnimated:YES];
                                              } errorResult:^(NSError *enginerError) {
                                                  [self showHint:@"提交出错"];
                                              }];
    }else{
    [self showHint:@"请填写完整股票内容..."];
    }

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [Tools hideKeyBoard];
}
- (void)textViewChanged:(UITextView *)textView{
    self.topLayoutConstraint.constant = - 100;
}
- (void)textViewEndChanged:(UITextView *)textView{
    self.topLayoutConstraint.constant =  25;
}
@end
