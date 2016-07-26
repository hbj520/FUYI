//
//  AllOderModel.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/21.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "AllOderModel.h"

@implementation AllOderModel

- (id)initWithCtime:(NSString *)ctime
            Goodsid:(NSString *)goodsid
          Goodstype:(NSString *)goodstype
              State:(NSString *)state
              Price:(NSString *)price
              Image:(NSString *)image
               Name:(NSString *)name
            Teacher:(NSString *)teacher
           Shopname:(NSString *)shopname
{
    AllOderModel * model = [[AllOderModel alloc] init];
    model.ctime = ctime;
    model.goodsid = goodsid;
    model.goodstype = goodstype;
    model.state = state;
    model.price = price;
    model.image = image;
    model.name = name;
    model.teacher = teacher;
    model.shopname = shopname;
    return model;
}

- (NSMutableArray *)buildWithData:(NSArray *)data
{
    NSMutableArray * allorderArray = [NSMutableArray array];
    for(NSDictionary * dict in data){
        NSString * ctime = dict[@"ctime"];
        NSString * goodsid = dict[@"goodsid"];
        NSString * goodstype = dict[@"goodstype"];
        NSString * state = dict[@"state"];
        NSString * price = dict[@"price"];
        NSString * image = dict[@"image"];
        NSString * name = dict[@"name"];
        NSString * teacher = dict[@"teacher"];
        NSString * shopname = dict[@"shopname"];
        AllOderModel * model = [[AllOderModel alloc] initWithCtime:ctime Goodsid:goodsid Goodstype:goodstype State:state Price:price Image:image Name:name Teacher:teacher Shopname:shopname];
        [allorderArray addObject:model];
    }
    return allorderArray;
    
}

@end
