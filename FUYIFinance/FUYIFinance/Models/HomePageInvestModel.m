//
//  HomePageInvestModel.m
//  FUYIFinance
//
//  Created by youyou on 16/7/6.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "HomePageInvestModel.h"

@implementation HomePageInvestModel
- (id)initWithParameters:(NSString *)investId
              investName:(NSString *)investName
             investImage:(NSString *)investImage
           investWebsite:(NSString *)investWebsite{
    HomePageInvestModel *model = [[HomePageInvestModel alloc] init];
    model.investId = investId;
    model.investName = investName;
    model.investImage = investImage;
    model.investWebsite = investWebsite;
    return model;
}
- (NSArray *)buildWithData:(NSArray *)data{
    NSMutableArray *modelArray = [NSMutableArray array];
    for (NSDictionary *dic in data) {
        NSString *investId = dic[@"id"];
        NSString *investName = dic[@"name"];
        NSString *investImage = dic[@"image"];
        NSString * website = dic[@"website"];
        HomePageInvestModel *model = [[HomePageInvestModel alloc] initWithParameters:investId
                                                                          investName:investName
                                                                         investImage:investImage
                                                                       investWebsite:website];
        [modelArray addObject:model];
    }
    return modelArray;
}
@end
