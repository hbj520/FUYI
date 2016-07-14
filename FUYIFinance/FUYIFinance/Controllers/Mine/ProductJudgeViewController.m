//
//  ProductJudgeViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/1.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "ProductJudgeViewController.h"
#import "TreasureJudgeStarView.h"
#import "MyAPI.h"

@interface ProductJudgeViewController ()<UITextViewDelegate>

{
    BOOL IsCommit;                                                     //是否匿名评价
    NSString * starNum;
}
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet TreasureJudgeStarView *starView;  //星级评价视图
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UIButton *surebtn;                //确定按钮

@end

@implementation ProductJudgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //给星级评价视图评分
   // [self.starView configWithStarLevel:3];
    //给确定按钮画圆角
    self.surebtn.layer.cornerRadius = 3;
    self.surebtn.clipsToBounds = YES;
 //   self.surebtn.enabled = NO;
    //给星级评价视图添加手势
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(renewStar:)];
    [self.starView addGestureRecognizer:tapGesture];
    self.textView.delegate = self;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.label1.hidden = YES;
    self.label2.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(textView.text.length){
        self.label1.hidden = YES;
        self.label2.hidden = YES;
    }else{
    self.label1.hidden = NO;
    self.label2.hidden = NO;
    }
}
//手势方法的实现
- (void)renewStar:(UIGestureRecognizer *)sender
{
    CGPoint point = [sender locationInView:self.starView];
    CGFloat pointX = point.x;
    
    float scale = pointX/136;
    int starnumber = scale * 5 + 1;
    starNum = [NSString stringWithFormat:@"%d",starnumber];
    UIImageView * imgStar = (UIImageView*)[self.starView viewWithTag:1];
    imgStar.clipsToBounds = YES;
    imgStar.frame = CGRectMake(0, 0, 136 * scale, 18);
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.textView endEditing:YES];
}
//确定按钮的事件响应方法
- (IBAction)Commit:(UIButton*)sender {
    IsCommit = !IsCommit;
    if(IsCommit){
       [sender setImage:[UIImage imageNamed:@"btnhighlighted"] forState:UIControlStateNormal];
        //self.surebtn.enabled = YES;
    }else{
        [sender setImage:[UIImage imageNamed:@"btndark"] forState:UIControlStateNormal];
       // self.surebtn.enabled = NO;
    }
}

- (IBAction)sureJudge:(id)sender {
    
}


//退回到上级界面
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
