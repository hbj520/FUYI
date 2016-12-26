//
//  HomePageNoticeModel.h
//  FUYIFinance
//
//  Created by youyou on 16/7/6.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomePageNoticeModel : NSObject
@property (nonatomic,copy) NSString *noticeId;
@property (nonatomic,copy) NSString *noticeTitle;
/**
 *  首页公告消息－富谊头条
 *
 *  @param noticeId    消息id
 *  @param noticeTitle 消息标题
 *
 *  @return
 */
- (id)initWithNoticeId:(NSString *)noticeId
           NoticeTitle:(NSString *)noticeTitle;
- (NSArray *)buildWithData:(NSArray *)data;
@end
