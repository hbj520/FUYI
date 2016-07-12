//
//  VideoShopNavigationItem.h
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/7/7.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoShopNavigationItem : UINavigationBar<UISearchBarDelegate>
typedef void (^BackBlock) ();
typedef void (^SearchBlock) (NSString *);
typedef void (^SearchBtnBlock) (NSString *);

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@property (nonatomic,copy) BackBlock backBlock;
@property (nonatomic,copy) SearchBlock searchResultBlock;
@property (nonatomic,copy) SearchBtnBlock searchBtnBlock;
- (void)setBackColor;
@end
