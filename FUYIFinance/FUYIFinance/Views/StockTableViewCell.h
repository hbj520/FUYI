//
//  StockTableViewCell.h
//  FUYIFinance
//
//  Created by youyou on 16/12/12.
//  Copyright © 2016年 youyou. All rights reserved.
//  股票推荐cell

#import <UIKit/UIKit.h>
#define stockReuseId @"stockCellReuseId"
#import "StockRecommendListModel.h"
@interface StockTableViewCell : UITableViewCell
- (void)configWithData:(StockRecommendListModel *)model;
@end
