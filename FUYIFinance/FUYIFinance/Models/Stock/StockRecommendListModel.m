//
//  StockRecommendListModel.m
//  FUYIFinance
//
//  Created by youyou on 16/12/19.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "StockRecommendListModel.h"
#import "ArticleListModel.h"
@implementation StockRecommendListModel
- (id)initWithcreateUserId:(NSString *)createUserId
                 teacherId:(NSString *)teacherId
                  imgthumb:(NSString *)imgthumb
                      name:(NSString *)name
               articleList:(NSArray *)articleList{
    StockRecommendListModel *model = [[StockRecommendListModel alloc] init];
    model.createUserId = createUserId;
    model.teacherId = teacherId;
    model.imgthumb = imgthumb;
    model.name = name;
    model.articleList = articleList;
    return model;
    
}
- (NSArray *)buildWithData:(NSArray *)data{
    NSMutableArray *modelArray = [NSMutableArray array];
    for (NSDictionary *dic in data) {
        NSString *createUserId = dic[@"createUserId"];
        NSString *teacherId = dic[@"teacherId"];
        NSString *imgthumb = dic[@"teacherInfo"][@"imgthumb"];
        NSString *name = dic[@"teacherInfo"][@"name"];
        NSArray *articleList = dic[@"recList"];
        NSMutableArray *aritleModelArray = [NSMutableArray array];
        for (NSDictionary *articleDic in articleList) {
            ArticleListModel *articleModel = [[ArticleListModel alloc]init];
            articleModel.analysis_title = articleDic[@"analysis_title"];
            articleModel.createtime = articleDic[@"createtime"];
            articleModel.stock_name = articleDic[@"stock_name"];
            [aritleModelArray addObject:articleModel];
        }
        StockRecommendListModel *model = [[StockRecommendListModel alloc] initWithcreateUserId:createUserId
                                                                                     teacherId:teacherId
                                                                                      imgthumb:imgthumb
                                                                                          name:name
                                                                                   articleList:aritleModelArray];
        [modelArray addObject:model];
    }
    return modelArray;
}
@end
