//
//  HomePageNavgationItem.h
//  FUYIFinance
//
//  Created by youyou on 16/6/16.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^MessageBlock) ();
typedef void (^SearchBlock) (NSString *);
@interface HomePageNavgationItem : UINavigationBar
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *messateBtn;
@property (nonatomic,copy) MessageBlock messageBlock;
@property (nonatomic,copy) SearchBlock searchResultBlock;
@end
