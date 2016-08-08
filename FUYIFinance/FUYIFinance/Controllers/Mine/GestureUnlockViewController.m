//
//  GestureUnlockViewController.m
//  FUYIFinance
//
//  Created by youyou on 8/8/16.
//  Copyright © 2016 youyou. All rights reserved.
//

#import "GestureUnlockViewController.h"
#import "MRGestureBgView.h"
#import "MRGestureView.h"
#import "MRGesture.h"
@interface GestureUnlockViewController ()<MRGestureViewDelegate>
/** 背景控件 */
@property(nonatomic, strong)MRGestureBgView *bgView;
@property(nonatomic, strong)MRGestureView *gestureView;

@end

@implementation GestureUnlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 初始化
    [self setupGesture];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
/**
 *	@brief	初始化手势相关控件
 */
- (void)setupGesture {
    
    // 将控制器的view设置为手势背景图的view
    self.bgView = [[MRGestureBgView alloc] init];
    
    self.bgView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    // self.bgView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview: self.bgView];
    
    // 添加手势视图
    self.gestureView = [[MRGestureView alloc] init];
    
    self.gestureView.delegate = self;
    
    MRGesture *gesture = [[MRGesture alloc] init];
    
    // 设置密码
    // gesture.password = @"123";
    gesture.password = KGesturePsassword;
    self.gestureView.gesture = gesture;
    self.gestureView.frame = CGRectMake(0, 120, self.view.frame.size.width, self.view.frame.size.height);
    
    [self.view addSubview:self.gestureView];
    
}
#pragma mark - <MRGestureViewDelegate>
- (void)gestureViewUnlockSuccess:(MRGestureView *)gestureView{
    [[GestureHelper sharedGesture] resetData];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)gestureDidFinished:(NSString *)gesturePassword{
    
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
