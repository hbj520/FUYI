//
//  SelectModel.m
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/7/6.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "SelectModel.h"

@implementation SelectModel

- (id)initWithParameters:(NSString *)selectId
              selectName:(NSString *)selectName{
    
    SelectModel *model = [[SelectModel alloc]init];
    model.selectName = selectName;
    model.selectId = selectId;
    return model;
    
}

- (NSArray *)buildWithData:(NSArray *)data{
    NSMutableArray *modelArr = [NSMutableArray array];
    for (NSDictionary *dic in data) {
        NSString *selectId = dic[@"id"];
        NSString *selectName = dic[@"name"];
        SelectModel *model = [[SelectModel alloc]initWithParameters:selectId selectName:selectName];
        [modelArr addObject:model];
    }
    
    return modelArr;
}


@end
