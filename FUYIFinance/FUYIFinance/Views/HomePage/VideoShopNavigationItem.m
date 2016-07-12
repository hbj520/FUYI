//
//  VideoShopNavigationItem.m
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/7/7.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "VideoShopNavigationItem.h"

@implementation VideoShopNavigationItem

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib{
    self.searchBar.delegate = self;
     UITextField *searchField=[_searchBar valueForKey:@"_searchField"];
    searchField.borderStyle = UITextBorderStyleNone;
    searchField.backgroundColor = RGBACOLOR(224, 225, 226, 1);
}


@end
