//
//  GestureHelper.m
//  FUYIFinance
//
//  Created by youyou on 8/8/16.
//  Copyright © 2016 youyou. All rights reserved.
//

#import "GestureHelper.h"
#import "GestureUnlockViewController.h"
@interface GestureHelper ()
{
    NSTimer *timer;

}
@end
@implementation GestureHelper
- (id)init{
    self = [super init];
    if (self) {
        [self configTime];
    }
    return self;
}
+ (GestureHelper *)sharedGesture{
    static GestureHelper *helper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      helper =  [[self alloc] init];
    });
    return helper;
}
- (void)configTime{
    timer = [NSTimer scheduledTimerWithTimeInterval:1. target:self selector:@selector(timeAct:) userInfo:nil repeats:YES];
    self.durationTime = 0;
}
//开始计时
- (void)startTime{
    [timer fire];
}
//结束计时
- (void)endTime{
    [timer invalidate];
}
//是否大于规定时间
- (BOOL)isTimeOut{
    
    return self.durationTime > 10;
}
//显示手势解锁界面
- (void)showGestureUnlockViewFromNowVC:(UIViewController *)NowVC{
    GestureUnlockViewController *gestureUnlockVC = [[GestureUnlockViewController alloc] init];
    [NowVC presentViewController:gestureUnlockVC animated:YES completion:^{
        
    }];
}
- (void)resetData{
    [timer invalidate];
    self.durationTime = 0;
}
- (void)timeAct:(id)sender{
    self.durationTime++;
}
@end
