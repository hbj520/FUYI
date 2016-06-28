//
//  ShopCarNavigationItem.h
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/6/28.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^MessageBlock) ();

@interface ShopCarNavigationItem : UIView

@property (weak, nonatomic) IBOutlet UIButton *messageBtn;
@property (nonatomic,copy) MessageBlock messageBlock;
@end
