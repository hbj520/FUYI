//
//  StockRecommendListModel.h
//  FUYIFinance
//
//  Created by youyou on 16/12/19.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StockRecommendListModel : NSObject
@property (copy,nonatomic) NSString *createUserId;
@property (copy,nonatomic) NSString *teacherId;
@property (copy,nonatomic) NSString *imgthumb;
@property (copy,nonatomic) NSString *name;
@property (copy,nonatomic) NSArray *articleList;


- (id)initWithcreateUserId:(NSString *)createUserId
                teacherId:(NSString *)teacherId
                  imgthumb:(NSString *)imgthumb
                name:(NSString *)name
                articleList:(NSArray *)articleList;
- (NSArray *)buildWithData:(NSArray *)data;
@end
