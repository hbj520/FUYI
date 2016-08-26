//
//  FeedBackViewController.m
//  CRM
//
//  Created by Razi on 14-10-21.
//  Copyright (c) 2014年 Razi. All rights reserved.
//

#import "FeedBackViewController.h"
#import "UIPlaceHolderTextView.h"

@interface FeedBackViewController ()


- (IBAction)cancelAction:(id)sender;

//提交
- (IBAction)commitAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIPlaceHolderTextView *textView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *leftItem;

@end

@implementation FeedBackViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.textView.placeholder = @"希望您能提出您宝贵的意见";
    //ios7.0后bug
    self.textView.layoutManager.allowsNonContiguousLayout = NO;
    self.navigationItem.hidesBackButton = YES;
//    if ([self.isHomePush boolValue]) {
        //self.leftItem.image = [UIImage imageNamed:@"leftArrow"];
   // }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [Tools hideKeyBoard];
}

- (IBAction)cancelAction:(id)sender
{
//    if ([self.isHomePush boolValue]) {
        [self.navigationController popViewControllerAnimated:YES];
      //  return;
//    }
    
    //[self dismissViewControllerAnimated:YES completion:nil];
}
//提交按钮
- (IBAction)commitAction:(id)sender
{
    [Tools hideKeyBoard];
    if (self.textView.text.length == 0) {
       // [self showHint:@"请添加反馈内容..."];
        return;
    }
//    [self showHudInView:self.view hint:@""];
//    [[MyAPI sharedAPI] feedBack:kUserId
//                          copid:kCopId
//                        content:self.textView.text
//                         result:
//     ^(BOOL success, NSString *msg) {
//        [self hideHud];
//        self.textView.text = @"";
//        [self showHint:msg];
//    } errorResult:
//     ^(NSError *enginerError) {
//        [self hideHud];
//        [self showHint:@"数据异常"];;
//    }];
}
@end
