//
//  TeacherTeamNavigationItem.m
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/7/14.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "TeacherTeamNavigationItem.h"

@implementation TeacherTeamNavigationItem

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib{

    [self.backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.newsBtn addTarget:self action:@selector(newsClick) forControlEvents:UIControlEventTouchUpInside];
    [self setBarTintColor:RGBACOLOR(27, 124, 219, 1)];
    
}
- (void)back{
    if (self.backBlock) {
        self.backBlock();
    }
    
}
- (void)newsClick{
    if (self.newsBlock) {
        self.newsBlock();
    }
    
}

@end
