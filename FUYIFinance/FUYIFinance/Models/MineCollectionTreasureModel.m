//
//  MineCollectionTreasureModel.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/6.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MineCollectionTreasureModel.h"

@implementation MineCollectionTreasureModel

- (id)initWithName:(NSString *)name Image:(NSString *)image Price:(NSString *)price Type:(NSString *)type Teacher:(NSString *)teacher
{
    MineCollectionTreasureModel * model = [[MineCollectionTreasureModel alloc] init];
    model.name = name;
    model.image = image;
    model.price = price;
    model.type = type;
    model.teacher = teacher;
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
        MineCollectionTreasureModel * model = [[MineCollectionTreasureModel alloc] initWithName:name Image:image Price:price Type:type Teacher:teacher];
        [collectionTreasureArray addObject:model];
    }
    return collectionTreasureArray;
}

@end
