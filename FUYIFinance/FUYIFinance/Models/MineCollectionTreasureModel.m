//
//  MineCollectionTreasureModel.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/6.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MineCollectionTreasureModel.h"

@implementation MineCollectionTreasureModel

- (id)initWithName:(NSString *)name Image:(NSString *)image Price:(NSString *)price Type:(NSString *)type Teacher:(NSString *)teacher Num:(NSString *)num Goodsid:(NSString *)goodsid About:(NSString *)about Cart:(NSString *)cart Collect:(NSString *)collection Tid:(NSString *)tid
{
    MineCollectionTreasureModel * model = [[MineCollectionTreasureModel alloc] init];
    model.name = name;
    model.image = image;
    model.price = price;
    model.type = type;
    model.teacher = teacher;
    model.num = num;
    model.goodsid = goodsid;
    model.about = about;
    model.cart = cart;
    model.collection = collection;
    model.tid = tid;
    return model;
}

- (NSMutableArray *)buildWithData:(NSArray*)data
{
    NSMutableArray * collectionTreasureArray = [[NSMutableArray alloc] init];
    for(NSDictionary * dict in data){
        NSString * name = dict[@"name"];
        NSString * image = dict[@"image"];
        NSString * price = dict[@"price"];
        NSString * type = dict[@"type"];
        NSString * teacher = dict[@"teacher"];
        NSNumber * num = dict[@"num"];
        NSString * numStr = [NSString stringWithFormat:@"&%ld",num.integerValue];
        NSString * goodsid = dict[@"goodsid"];
        NSString * about = dict[@"about"];
        NSNumber * cart = dict[@"cart"];
        NSString * Cart = [NSString stringWithFormat:@"%ld",cart.integerValue];
        NSNumber * collect = dict[@"collect"];
        NSString * Collect = [NSString stringWithFormat:@"%ld",collect.integerValue];
        NSString * tid = dict[@"tid"];
        MineCollectionTreasureModel * model = [[MineCollectionTreasureModel alloc] initWithName:name Image:image Price:price Type:type Teacher:teacher Num:numStr Goodsid:goodsid About:about Cart:Cart Collect:Collect Tid:tid];
        [collectionTreasureArray addObject:model];
    }
    return collectionTreasureArray;
}

@end
