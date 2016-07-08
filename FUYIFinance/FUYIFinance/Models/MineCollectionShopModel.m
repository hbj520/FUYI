//
//  MineCollectionShopModel.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/7.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MineCollectionShopModel.h"

@implementation MineCollectionShopModel

- (id)initWithName:(NSString *)name Image:(NSString *)image Teacher:(NSString *)teacher
{
    MineCollectionShopModel * model = [[MineCollectionShopModel alloc] init];
    model.name = name;
    model.image = image;
    model.teacher = teacher;
    return model;
}

- (NSMutableArray*)buildWithData:(NSArray *)data
{
    NSMutableArray * MineCollectionShopModelArray = [[NSMutableArray alloc] init];
    for(NSDictionary * dict in data){
        NSString * name = dict[@"name"];
        NSString * image = dict[@"image"];
        NSString * teacher = dict[@"teacher"];
        MineCollectionShopModel * model = [[MineCollectionShopModel alloc] initWithName:name Image:image Teacher:teacher];
        [MineCollectionShopModelArray addObject:model];
    }
    return MineCollectionShopModelArray;
}

@end
