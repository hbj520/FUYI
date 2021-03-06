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
           OrderNum:(NSString *)ordernum
            Goodsid:(NSString *)goodsid
          Goodstyle:(NSString *)goodstyle
              Price:(NSString *)price
              Image:(NSString *)image
               Name:(NSString *)name
            Teacher:(NSString *)teacher
           Shopname:(NSString *)shopname
{
    MineWaitJudgeModel * model = [[MineWaitJudgeModel alloc] init];
    model.ctime = ctime;
    model.ordernum = ordernum;
    model.goodsid = goodsid;
    model.goodstyle = goodstyle;
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
        NSString * ordernum = dict[@"ordernum"];
        NSString * goodsid = dict[@"goodsid"];
        NSString * goodstyle = dict[@"goodstype"];
        NSString * price = dict[@"price"];
        NSString * image = dict[@"image"];
        NSString * name = dict[@"name"];
        NSString * teacher = dict[@"teacher"];
        NSString * shopname = dict[@"shopname"];
        MineWaitJudgeModel * model = [[MineWaitJudgeModel alloc] initWithCtime:ctime OrderNum:ordernum Goodsid:goodsid Goodstyle:goodstyle Price:price Image:image Name:name Teacher:teacher Shopname:shopname];
        [waitjudgeArray addObject:model];
    }
    return waitjudgeArray;
}

@end
