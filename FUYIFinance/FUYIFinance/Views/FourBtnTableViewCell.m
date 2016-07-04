//
//  FourBtnTableViewCell.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/4.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "FourBtnTableViewCell.h"

@implementation FourBtnTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //发布宝贝
    UITapGestureRecognizer * publishTreasure = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPublish)];
    [self.publishView addGestureRecognizer:publishTreasure];
    
    //宝贝管理
    UITapGestureRecognizer * treasureManage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickManage)];
    [self.ManageView addGestureRecognizer:treasureManage];
    
    //订单管理
    UITapGestureRecognizer * orderManage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOrderManage)];
    [self.OrderManageView addGestureRecognizer:orderManage];
    
    //店铺设置
    UITapGestureRecognizer * shopSetting = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(settingShop)];
    [self.ShopSettingView addGestureRecognizer:shopSetting];
    
}


//点击发布宝贝
- (void)clickPublish
{
    self.publishBlock();
}


//点击宝贝管理
- (void)clickManage
{
    self.treasureManageBlock();
}


//订单管理
- (void)clickOrderManage
{
    self.orderManageBlock();
}


//店铺设置
- (void)settingShop
{
    self.shopSettingBlock();
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
