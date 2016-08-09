//
//  SystemNoticeModel.h
//  FUYIFinance
//
//  Created by 张哲 on 16/8/8.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemNoticeModel : NSObject
@property (nonatomic,copy)NSString * thumb;
@property (nonatomic,copy)NSString * title;
@property (nonatomic,copy)NSString * time;
/**
 *  模型
 *
 *  @param thumb 图片
 *  @param title 标题
 *  @param time  时间
 *
 *  @return 模型
 */
- (id)initWithThumb:(NSString *)thumb
              Title:(NSString *)title
               Time:(NSString *)time;

- (NSMutableArray *)buildWithData:(NSArray*)data;

@end
