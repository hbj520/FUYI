//
//  GestureHelper.h
//  FUYIFinance
//
//  Created by youyou on 8/8/16.
//  Copyright © 2016 youyou. All rights reserved.
//    手势解锁

#import <Foundation/Foundation.h>

@interface GestureHelper : NSObject
@property (nonatomic,assign) NSInteger durationTime;//间隔时间
+ (GestureHelper *)sharedGesture;
- (void)startTime;//开始计时
- (void)endTime;//结束计时
- (BOOL)isTimeOut;//是否大于规定时间
- (void)showGestureUnlockViewFromNowVC:(UIViewController *)NowVC;//显示手势解锁界面
- (void)resetData;//重制配置

@end
