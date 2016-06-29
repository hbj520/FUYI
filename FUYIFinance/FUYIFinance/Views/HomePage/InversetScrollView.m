//
//  InversetScrollView.m
//  FUYIFinance
//
//  Created by youyou on 16/6/23.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "InversetScrollView.h"

@implementation InversetScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (void)setUIWithData:(NSArray *)data{
    for (NSInteger i = 0; i < data.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        if (i == 0) {
            imageView.frame = CGRectMake(0, 0, 140, 205);
        }else{
            NSInteger list = (i - 1)/2;//列
            NSInteger line = (i - 1)%2;//行
            imageView.frame = CGRectMake((list)*117 + 140, line*102, 117, 102);
        }
        imageView.image = [UIImage imageNamed:data[i]];
        [self addSubview:imageView];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
