//
//  PublishStockViewController.m
//  FUYIFinance
//
//  Created by youyou on 17/1/5.
//  Copyright © 2017年 youyou. All rights reserved.
//

#import "PublishStockViewController.h"

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
    // Do any additional setup after loading the view.
    self.stockContentTextView.delegate = self;
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
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [Tools hideKeyBoard];
}
#pragma mark -UITextViewDelegate

- (void)insertText:(NSString *)text{
    
    
}
@end
