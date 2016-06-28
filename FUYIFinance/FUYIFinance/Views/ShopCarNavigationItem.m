//
//  ShopCarNavigationItem.m
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/6/28.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "ShopCarNavigationItem.h"

@implementation ShopCarNavigationItem

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib{
    [self.messageBtn addTarget:self action:@selector(messageAct:) forControlEvents:UIControlEventTouchUpInside];

}
- (void)messageAct:(id)sender{
    if (self.messageBlock) {
        self.messageBlock();
    }
    
}


@end
