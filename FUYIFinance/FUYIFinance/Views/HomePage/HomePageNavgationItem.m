//
//  HomePageNavgationItem.m
//  FUYIFinance
//
//  Created by youyou on 16/6/16.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "HomePageNavgationItem.h"
@interface HomePageNavgationItem()<UISearchBarDelegate>

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
    [self.searchBar setSearchResultsButtonSelected:YES];
    self.searchBar.delegate = self;
}
- (void)messageAct:(id)sender{
    if (self.messageBlock) {
        self.messageBlock();
    }
    
}
#pragma mark - SearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if (self.searchResultBlock) {
        self.searchResultBlock(searchBar.text);
    }
    
}

@end
