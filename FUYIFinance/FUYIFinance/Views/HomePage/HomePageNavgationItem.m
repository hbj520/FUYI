//
//  HomePageNavgationItem.m
//  FUYIFinance
//
//  Created by youyou on 16/6/16.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "HomePageNavgationItem.h"
@interface HomePageNavgationItem()

@end

@implementation HomePageNavgationItem

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib{
    [self.messateBtn addTarget:self action:@selector(messageAct:) forControlEvents:UIControlEventTouchUpInside];
    [self.searchBar setPlaceholder:@"请输入关键词"];
    
}
- (void)messageAct:(id)sender{
    if (self.messageBlock) {
        self.messageBlock();
    }
    
}
@end
