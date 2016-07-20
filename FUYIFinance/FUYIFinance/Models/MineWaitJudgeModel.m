//
//  MineWaitJudgeModel.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/19.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MineWaitJudgeModel.h"

@implementation MineWaitJudgeModel

- (id)initWithCtime:(NSString *)ctime
            Goodsid:(NSString *)goodsid
              Price:(NSString *)price
              Image:(NSString *)image
               Name:(NSString *)name
            Teacher:(NSString *)teacher
           Shopname:(NSString *)shopname
{
    MineWaitJudgeModel * model = [[MineWaitJudgeModel alloc] init];
    model.ctime = ctime;
    model.goodsid = goodsid;
    model.price = price;
    model.image = image;
    model.name = name;
    model.teacher = teacher;
    model.shopname = shopname;
    return model;
}

- (NSMutableArray *)buildWithData:(NSArray *)data
{
    NSMutableArray * waitjudgeArray = [NSMutableArray array];
    for(NSDictionary * dict in data){
        NSString * ctime = dict[@"ctime"];
        NSString * goodsid = dict[@"goodsid"];
        NSString * price = dict[@"price"];
        NSString * image = dict[@"image"];
        NSString * name = dict[@"name"];
        NSString * teacher = dict[@"teacher"];
        NSString * shopname = dict[@"shopname"];
        MineWaitJudgeModel * model = [[MineWaitJudgeModel alloc] initWithCtime:ctime Goodsid:goodsid Price:price Image:image Name:name Teacher:teacher Shopname:shopname];
        [waitjudgeArray addObject:model];
    }
    return waitjudgeArray;
}

@end
