//
//  TeachStockAnalyzeTableViewCell.h
//  FUYIFinance
//
//  Created by youyou on 16/12/12.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StockRecommendListDetailModel.h"
#define teachStockReuseId @"teachStockReuseId"
typedef void (^ClickZanBlock)(BOOL);
@interface TeachStockAnalyzeTableViewCell : UITableViewCell
@property (nonatomic,copy) ClickZanBlock clickZanBlock;
@property (nonatomic,copy) ClickZanBlock clickAgainstBlock;
- (void)configWithData:(StockRecommendListDetailModel *)model;
@end
