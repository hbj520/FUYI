//
//  HomePageNoticeModel.m
//  FUYIFinance
//
//  Created by youyou on 16/7/6.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "HomePageNoticeModel.h"

@implementation HomePageNoticeModel
- (id)initWithNoticeId:(NSString *)noticeId
           NoticeTitle:(NSString *)noticeTitle{
    HomePageNoticeModel *model = [[HomePageNoticeModel alloc] init];
    model.noticeId = noticeId;
    model.noticeTitle = noticeTitle;
    return model;
}
- (NSArray *)buildWithData:(NSArray *)data{
    NSMutableArray *modelArray = [NSMutableArray array];
    for (NSDictionary *dic in data) {
        NSString *noticeId = dic[@"id"];
        NSString *noticeTitle = dic[@"title"];
        HomePageNoticeModel *model = [[HomePageNoticeModel alloc]
                                      initWithNoticeId:noticeId
                                           NoticeTitle:noticeTitle];
        [modelArray addObject:model];
    }
    return modelArray;
}
@end
