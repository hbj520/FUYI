//
//  StockRecommendListDetailModel.m
//  FUYIFinance
//
//  Created by youyou on 17/1/3.
//  Copyright © 2017年 youyou. All rights reserved.
//

#import "StockRecommendListDetailModel.h"

@implementation StockRecommendListDetailModel
- (id)initWithStockName:(NSString *)stockName
          analysisTitle:(NSString *)analysisTitle
           supportCount:(NSString *)supportCount
            opposeCount:(NSString *)opposeCount
             createtime:(NSString *)createtime
                stockId:(NSString *)stockId{
    StockRecommendListDetailModel *model = [[StockRecommendListDetailModel alloc] init];
    model.stock_name = stockName;
    model.analysis_title = analysisTitle;
    model.stockId = stockId;
    if (supportCount.integerValue == 0) {
        supportCount = @"1";
    }
    if (opposeCount.integerValue == 0) {
        opposeCount = @"1"
        ;
    }
    model.supportCount = supportCount;
    model.opposeCount = opposeCount;
    model.createtime = createtime;
    return model;
}
- (NSArray *)buildWithData:(NSDictionary *)data{
    NSMutableArray *todayList = [NSMutableArray array];
    NSMutableArray *historyList = [NSMutableArray array];
    NSArray *todayStockRecommendationList = data[@"todayStockRecommendationList"];
    NSArray *historyStockRecommendationList = data[@"historyStockRecommendationList"];
    for (NSDictionary *todayDic in todayStockRecommendationList) {
        NSString *stock_name = todayDic[@"stock_name"];
        NSString *analysis_title = todayDic[@"analysis_title"];
        NSString *supportCount = todayDic[@"supportCount"];
        NSString *opposeCount = todayDic[@"opposeCount"];
        NSString *createtime = todayDic[@"createtime"];
        NSString *stockId = todayDic[@"id"];
        StockRecommendListDetailModel *model = [[StockRecommendListDetailModel alloc]
                                                initWithStockName:stock_name
                                                analysisTitle:analysis_title
                                                supportCount:supportCount
                                                opposeCount:opposeCount
                                                createtime:createtime
                                                stockId:stockId];
        [todayList addObject:model];
    }
    
    for (NSDictionary *historyDic in historyStockRecommendationList) {
        NSString *stock_name = historyDic[@"stock_name"];
        NSString *analysis_title = historyDic[@"analysis_title"];
        NSString *supportCount = historyDic[@"supportCount"];
        NSString *opposeCount = historyDic[@"opposeCount"];
        NSString *createtime = historyDic[@"createtime"];
        NSString *stockId = historyDic[@"id"];

        StockRecommendListDetailModel *model = [[StockRecommendListDetailModel alloc]
                                                initWithStockName:stock_name
                                                analysisTitle:analysis_title
                                                supportCount:supportCount
                                                opposeCount:opposeCount
                                                createtime:createtime
                                                stockId:stockId];
        [historyList addObject:model];
    }
    
    return @[todayList,historyList];
}

@end
