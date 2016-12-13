//
//  RateView.h
//  FUYIFinance
//
//  Created by youyou on 16/12/13.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RateView : UIView
@property (nonatomic,strong) UIView *supportView;
@property (nonatomic,strong) UIView *unsupportView;
- (void)configWithSupportCount:(NSInteger)supportCount
                unSupportCount:(NSInteger)unsupportCount;
@end
