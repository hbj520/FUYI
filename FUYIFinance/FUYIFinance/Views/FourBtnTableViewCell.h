//
//  FourBtnTableViewCell.h
//  FUYIFinance
//
//  Created by 张哲 on 16/7/4.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^clickPublish)();
typedef void (^clickTreasureManage)();
typedef void (^clickOrderManage)();
typedef void (^clickShopSetting)();

@interface FourBtnTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *publishView;
@property (weak, nonatomic) IBOutlet UIView *ManageView;
@property (weak, nonatomic) IBOutlet UIView *OrderManageView;
@property (weak, nonatomic) IBOutlet UIView *ShopSettingView;

@property(nonatomic,copy) clickPublish publishBlock;
@property(nonatomic,copy) clickTreasureManage treasureManageBlock;
@property(nonatomic,copy) clickOrderManage orderManageBlock;
@property(nonatomic,copy) clickShopSetting shopSettingBlock;

@end
