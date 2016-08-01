//
//  ManageTreasureModel.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/28.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "ManageTreasureModel.h"

@implementation ManageTreasureModel

- (id)initWithGoodsid:(NSString *)goodsid
                Title:(NSString *)title
                Price:(NSString *)price
             Thumbimg:(NSString *)thumbimg
                 Time:(NSString *)time
                  Num:(NSString *)num
{
    ManageTreasureModel * model = [[ManageTreasureModel alloc] init];
    model.goodsid = goodsid;
    model.title = title;
    model.price = price;
    model.thumbimg = thumbimg;
    model.time = time;
    model.num = num;
    return model;
}

- (NSMutableArray *)buildWithData:(NSArray *)data
{
    NSMutableArray * ManageTreasureArray = [NSMutableArray array];
    for(NSDictionary * dict in data){
        NSString * goodsid = dict[@"goodsid"];
        NSString * title = dict[@"title"];
        NSString * price = dict[@"price"];
        NSString * thumbimg = dict[@"thumbimg"];
        NSString * time = dict[@"time"];
        NSString * num = dict[@"num"];
        ManageTreasureModel * model = [[ManageTreasureModel alloc] initWithGoodsid:goodsid Title:title Price:price Thumbimg:thumbimg Time:time Num:num];
        [ManageTreasureArray addObject:model];
    }
    return ManageTreasureArray;
}

@end
