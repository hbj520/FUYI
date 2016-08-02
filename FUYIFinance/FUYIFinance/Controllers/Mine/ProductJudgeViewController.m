//
//  ProductJudgeViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/1.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "ProductJudgeViewController.h"
#import "UIViewController+HUD.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "starView.h"
#import "MyAPI.h"

@interface ProductJudgeViewController ()<UITextViewDelegate>

{
    BOOL IsCommit;                                                     //是否匿名评价
    NSString * starNum;
}
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet starView *starView;
  //星级评价视图
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UIImageView *thumbImg;
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
    [self.thumbImg sd_setImageWithURL:[NSURL URLWithString:self.image] placeholderImage:[UIImage imageNamed:@"placeimage"]];
    //给星级评价视图添加手势
    [self.starView configWithStarLevel:0];
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
    [self.starView configWithStarLevel:starnumber];
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
       
    }else{
        [sender setImage:[UIImage imageNamed:@"btndark"] forState:UIControlStateNormal];
       
    }
}

//确认评价
- (IBAction)sureJudge:(id)sender {
    if(!KToken){
        [self logOut];
    }else{
    NSString * anonymous = [NSString stringWithFormat:@"%d",IsCommit];
        if (self.deleteblock) {
            self.deleteblock(self.indexpath);
        }
        
    [[MyAPI sharedAPI] uploadUserJudgeWithParameters:starNum
                                            OrderNum:self.ordernum
                                           Anonymous:anonymous
                                             Content:self.textView.text
                                           Goodstyle:self.ustyle
                                             Goodsid:self.uid
                                              result:^(BOOL sucess, NSString *msg) {
        if (sucess) {
            [self showHint:@"评价成功"];
      //     self.deleteblock(self.indexpath);
            [self.navigationController popViewControllerAnimated:YES];
        }
    } errorResult:^(NSError *enginerError) {
        
    }];
    }
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
