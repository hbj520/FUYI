//
//  Good.m
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/6/30.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "Good.h"

@implementation Good

- (id)initWithParameters:(NSString*)goodId
                goodType:(NSString*)goodType
               goodPrice:(NSString*)goodPrice
                goodName:(NSString*)goodName
               goodImage:(NSString*)goodImage
             teacherName:(NSString*)teacherName
                    type:(NSString*)type{
    Good *model = [[Good alloc]init];
    model.goodId = goodId;
    model.goodType = goodType;
    model.goodPrice = goodPrice;
    model.goodName = goodName;
    model.goodImage = goodImage;
    model.teacherName = teacherName;
    model.type = type;
    
    return model;
}

- (NSArray *)buildWithData:(NSArray *)data{
    NSMutableArray *modelArr = [NSMutableArray array];
    for (NSDictionary *dic in data) {
        NSString *goodId = dic[@"goodsid"];
        NSString *goodType = dic[@"goodstype"];
        NSString *goodPrice = dic[@"price"];
        NSString *goodName = dic[@"name"];
        NSString *goodImage = dic[@"image"];
        NSString *teacherName = dic[@"teachername"];
        NSString *type = dic[@"type"];
        
        Good *model = [[Good alloc]initWithParameters:goodId
                                             goodType:goodType
                                            goodPrice:goodPrice
                                             goodName:goodName
                                            goodImage:goodImage
                                          teacherName:teacherName
                                                 type:type];
        
        [modelArr addObject:model];
    }
    return modelArr;
}

@end
