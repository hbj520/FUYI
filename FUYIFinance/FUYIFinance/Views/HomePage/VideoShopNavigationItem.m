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
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:searchField.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft cornerRadii:CGSizeMake(200 ,10)];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = searchField.bounds;
//    maskLayer.path = maskPath.CGPath;
//    searchField.layer.mask = maskLayer;
    //searchField.layer.cornerRadius = 10;
    [self.backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.searchBtn addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
    [self.searchBar setSearchResultsButtonSelected:YES];
    
    
}

- (void)back{
    if (self.backBlock) {
        self.backBlock();
    }
    
}

#pragma mark - SearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if (self.searchResultBlock) {
        self.searchResultBlock(searchBar.text);
    }
    
}


@end
