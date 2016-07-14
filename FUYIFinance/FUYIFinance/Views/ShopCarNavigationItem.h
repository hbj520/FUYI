//
//  ShopCarNavigationItem.h
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/6/28.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^MessageBlock) ();
typedef void (^BackBlock) ();

@interface ShopCarNavigationItem : UIView

@property (weak, nonatomic) IBOutlet UIButton *messageBtn;
@property (nonatomic,copy) MessageBlock messageBlock;

@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (nonatomic,copy) BackBlock backBlock;

@end
