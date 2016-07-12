//
//  VideoShopNavigationItem.h
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/7/7.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoShopNavigationItem : UINavigationBar<UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@end
