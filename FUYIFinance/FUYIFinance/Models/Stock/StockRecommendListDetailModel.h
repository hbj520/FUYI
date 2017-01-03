//
//  StockRecommendListDetailModel.h
//  FUYIFinance
//
//  Created by youyou on 17/1/3.
//  Copyright © 2017年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StockRecommendListDetailModel : NSObject
@property (nonatomic,copy) NSString *stock_name;
@property (nonatomic,copy) NSString *analysis_title;
@property (nonatomic,copy) NSString *supportCount;
@property (nonatomic,copy) NSString *opposeCount;
@property (nonatomic,copy) NSString *createtime;
@property (nonatomic,copy) NSString *stockId;
- (id)initWithStockName:(NSString *)stockName
          analysisTitle:(NSString *)analysisTitle
           supportCount:(NSString *)supportCount
            opposeCount:(NSString *)opposeCount
             createtime:(NSString *)createtime
                stockId:(NSString *)stockId;
- (NSArray *)buildWithData:(NSDictionary *)data;
@end
