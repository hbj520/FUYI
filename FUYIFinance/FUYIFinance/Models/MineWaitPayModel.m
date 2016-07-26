//
//  MineWaitPayModel.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/7.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MineWaitPayModel.h"

@implementation MineWaitPayModel

- (id)initWithCtime:(NSString *)ctime Price:(NSString *)price Image:(NSString *)image Name:(NSString *)name Teacher:(NSString *)teacher ShopName:(NSString *)shopname Ordernum:(NSString *)ordernum
{
    MineWaitPayModel * model = [[MineWaitPayModel alloc] init];
    model.ctime = ctime;
    model.price = price;
    model.ordernum = ordernum;
    model.image = image;
    model.name = name;
    model.teacher = teacher;
    model.shopname = shopname;
    return model;
}

- (NSMutableArray*)buildWithData:(NSArray *)data
{
    NSMutableArray * MineWaitPayModelArray = [[NSMutableArray alloc] init];
    for(NSDictionary * dict in data){
        NSString * ctime = dict[@"ctime"];
        NSString * price = dict[@"price"];
        NSString * ordernum = dict[@"ordernum"];
        NSString * image = dict[@"image"];
        NSString * name = dict[@"name"];
        NSString * teacher = dict[@"teacher"];
        NSString * shopname = dict[@"shopname"];
        MineWaitPayModel * model = [[MineWaitPayModel alloc] initWithCtime:ctime Price:price Image:image Name:name Teacher:teacher ShopName:shopname Ordernum:ordernum];
        [MineWaitPayModelArray addObject:model];
    }
    return MineWaitPayModelArray;
}

@end
