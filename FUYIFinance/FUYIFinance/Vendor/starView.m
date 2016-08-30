//
//  starView.m
//  star
//
//  Created by 张哲 on 16/7/29.
//  Copyright © 2016年 张哲. All rights reserved.
//

#import "starView.h"

@implementation starView

- (id)initWithFrame:(CGRect)frame withStarLevel:(float)levels
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configWithStarLevel:levels];
    }
    return self;
}

- (void)configWithStarLevel:(float)levels{
    self.backgroundColor = [UIColor clearColor];
    CGRect frame = self.frame;
    CGFloat width = frame.size.width/5;
      for(int i = 0;i<5;i++){
          UIImageView * emptyStar = [[UIImageView alloc] initWithFrame:CGRectMake(width * i, 0, width, frame.size.height)];
          emptyStar.image = [UIImage imageNamed:@"unselect_star3"];

       [self addSubview:emptyStar];
    }
    
    int cout = (int)levels;
    for(int i = 0;i<cout;i++){
        UIImageView * wholeStar = [[UIImageView alloc] initWithFrame:CGRectMake(width * i, 0, width, frame.size.height)];
        wholeStar.image = [UIImage imageNamed:@"select_star1"];
        [self addSubview:wholeStar];
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
