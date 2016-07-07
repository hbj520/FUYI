//
//  TreasureJudgeStarView.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/4.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "TreasureJudgeStarView.h"

@implementation TreasureJudgeStarView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if(self){
        UIImageView * imgback = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 136, 18)];
        imgback.contentMode = UIViewContentModeLeft;
        imgback.clipsToBounds = YES;
        imgback.image = [UIImage imageNamed:@"darkstar"];
        UIImageView * imgStar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 136, 18)];
        imgStar.contentMode = UIViewContentModeLeft;
        imgStar.tag = 1;
        imgStar.clipsToBounds = YES;
        imgStar.image = [UIImage imageNamed:@"highlightstar"];
        [self addSubview:imgback];
        [self addSubview:imgStar];
        
    }
    return self;
}

- (void)configWithStarLevel:(float)levels
{
    UIImageView * imgStar = (UIImageView*)[self viewWithTag:1];
    imgStar.clipsToBounds = YES;
    imgStar.frame = CGRectMake(0, 0, 136 * levels/5, 18);
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
