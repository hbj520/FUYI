//
//  OrderNoticeModel.m
//  FUYIFinance
//
//  Created by 张哲 on 16/8/8.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "OrderNoticeModel.h"

@implementation OrderNoticeModel

- (id)initWithThumb:(NSString *)thumb
              Title:(NSString *)title
              About:(NSString *)about
               Time:(NSString *)time
{
    OrderNoticeModel * model = [[OrderNoticeModel alloc] init];
    model.thumb = thumb;
    model.title = title;
    model.about = about;
    model.time = time;
    return model;
}

- (NSMutableArray *)buildWithData:(NSArray *)data
{
    NSMutableArray * array = [NSMutableArray array];
    for(NSDictionary * dict in data){
        NSString * thumb = dict[@"thumb"];
        NSString * title = dict[@"title"];
        NSString * about = dict[@"about"];
        NSString * time = dict[@"time"];
        OrderNoticeModel * model = [[OrderNoticeModel alloc] initWithThumb:thumb Title:title About:about Time:time];
        [array addObject:model];
    }
    return array;
}

@end
