//
//  StarView.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/1.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "StarView.h"

@implementation StarView
- (id)initWithFrame:(CGRect)frame withStarLevel:(float)levels
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configWithStarLevel:levels];
    }
    return self;
}

- (void)configWithStarLevel:(float)levels{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
