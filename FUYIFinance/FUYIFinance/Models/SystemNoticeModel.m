//
//  SystemNoticeModel.m
//  FUYIFinance
//
//  Created by 张哲 on 16/8/8.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "SystemNoticeModel.h"

@implementation SystemNoticeModel

- (id)initWithThumb:(NSString *)thumb
              Title:(NSString *)title
               Time:(NSString *)time
{
    SystemNoticeModel * model = [[SystemNoticeModel alloc] init];
    model.thumb = thumb;
    model.title = title;
    model.time = time;
    return model;
}

- (NSMutableArray *)buildWithData:(NSArray *)data
{
    NSMutableArray * array = [NSMutableArray array];
    for(NSDictionary * dict in data){
        NSString * thumb = dict[@"thumb"];
        NSString * title = dict[@"title"];
        NSString * time = dict[@"time"];
        SystemNoticeModel * model = [[SystemNoticeModel alloc] initWithThumb:thumb Title:title Time:time];
        [array addObject:model];
    }
    return array;
}

@end
