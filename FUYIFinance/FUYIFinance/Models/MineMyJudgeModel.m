//
//  MineMyJudgeModel.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/7.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MineMyJudgeModel.h"

@implementation MineMyJudgeModel

- (id)initWithImage:(NSString *)image Name:(NSString *)name Ctime:(NSString *)ctime Content:(NSString *)content
{
    MineMyJudgeModel * model = [[MineMyJudgeModel alloc] init];
    model.image = image;
    model.name = name;
    model.ctime = ctime;
    model.content = content;
    return model;
}

- (NSMutableArray *)buildWithData:(NSArray *)data
{
    NSMutableArray * MineMyJudgeModelArray = [[NSMutableArray alloc] init];
    for(NSDictionary * dict in data){
        NSString * image = dict[@"image"];
        NSString * name = dict[@"name"];
        NSString * ctime = dict[@"ctime"];
        NSString * content = dict[@"content"];
        MineMyJudgeModel * model = [[MineMyJudgeModel alloc] initWithImage:image Name:name Ctime:ctime Content:content];
        [MineMyJudgeModelArray addObject:model];
    }
    return MineMyJudgeModelArray;
}

@end
