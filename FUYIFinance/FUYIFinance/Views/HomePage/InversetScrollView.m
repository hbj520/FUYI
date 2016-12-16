//
//  InversetScrollView.m
//  FUYIFinance
//
//  Created by youyou on 16/6/23.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "InversetScrollView.h"
#import "HomePageInvestModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
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
            imageView.frame = CGRectMake(0, 0, 140/375.*ScreenWidth, 205/375.*ScreenWidth);
            imageView.image = [UIImage imageNamed:data[i]];
            UIView *lineView = [[UIView alloc] init];
            lineView.frame = CGRectMake(140/375.*ScreenWidth-1, 0, 1, 205/375.*ScreenWidth);
            lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [self addSubview:imageView];
            [self addSubview:lineView];
        }else{
            NSInteger list = (i - 1)/2;//列
            NSInteger line = (i - 1)%2;//行
            //HomePageInvestModel *model = [data objectAtIndex:i];
            imageView.frame = CGRectMake((list*117)/375.*ScreenWidth + 140/375.*ScreenWidth, line*102/375.*ScreenWidth, 117/375.*ScreenWidth, 102/375.*ScreenWidth);
            imageView.image = [UIImage imageNamed:data[i]];
            [self addSubview:imageView];
        }
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAct:)];
        [imageView addGestureRecognizer:tap];
        imageView.tag = 100 + i;
        imageView.userInteractionEnabled = YES;
        [self addLines];
      
    }
}
- (void)addLines{
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.frame = CGRectMake(0, 205/375.*ScreenWidth, ScreenWidth, 1);
    lineView1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:lineView1];
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.frame = CGRectMake(140/375.*ScreenWidth, 102/375.*ScreenWidth, 235/375.*ScreenWidth, 1);
    lineView2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:lineView2];
    UIView *lineView3 = [[UIView alloc] init];
    lineView3.frame = CGRectMake(257/375.*ScreenWidth, 0, 1, 205/375.*ScreenWidth);
    lineView3.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:lineView3];
    UIView *lineView4 = [[UIView alloc] init];
    lineView4.frame = CGRectMake(ScreenWidth, 0, 1, 205/375.*ScreenWidth);
    lineView4.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:lineView4];
}
- (void)tapAct:(UITapGestureRecognizer *)ges{
    if (self.tapBlock) {
        self.tapBlock(ges.view.tag);
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
