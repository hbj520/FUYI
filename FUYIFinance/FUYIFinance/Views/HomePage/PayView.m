//
//  PayView.m
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/7/6.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "PayView.h"

@implementation PayView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    self.payBtn.layer.cornerRadius = 3;
    self.payBtn.layer.masksToBounds = YES;
}


@end
