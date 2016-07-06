//
//  TreasureJudgeStarView.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/4.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "TreasureJudgeStarView.h"

@implementation TreasureJudgeStarView

-(id)initWithFrame:(CGRect)frame withStarLevel:(float)levels
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self configWithStarLevel:levels];
    }
    return self;
}
- (void)configWithStarLevel:(float)levels{
    CGRect frame = self.frame;
    CGFloat with = frame.size.width/5;
    //创建底部空星星
    UIImageView *emptyStar = [[UIImageView alloc] initWithFrame:self.bounds];
    emptyStar.image = [UIImage imageNamed:@"stardark"];
   // [self addSubview:emptyStar];
    //截取浮点取整
    int cout = (int)levels;
    for (int i = 0; i < cout ; i++)
    {
        UIImageView *wholeStar = [[UIImageView alloc] initWithFrame:CGRectMake(with*i, 0, with, frame.size.height)];
        wholeStar.image = [UIImage imageNamed:@"star_light"];
        [self addSubview:wholeStar];
    }
    if (cout - levels < 0)
    {
        UIImageView *halfStar = [[UIImageView alloc] initWithFrame:CGRectMake(with*cout, 0, with, frame.size.height)];
        halfStar.image = [UIImage imageNamed:@"star_light"];
        [self addSubview:halfStar];
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
