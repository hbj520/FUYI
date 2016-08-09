//
//  OrderNoticeModel.h
//  FUYIFinance
//
//  Created by 张哲 on 16/8/8.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderNoticeModel : NSObject
@property (nonatomic,copy)NSString * thumb;
@property (nonatomic,copy)NSString * title;
@property (nonatomic,copy)NSString * about;
@property (nonatomic,copy)NSString * time;

/**
 *  模型
 *
 *  @param thumb 图片
 *  @param title 标题
 *  @param about 简介
 *  @param time  时间
 *
 *  @return 模型
 */
- (id)initWithThumb:(NSString *)thumb
              Title:(NSString *)title
              About:(NSString *)about
               Time:(NSString *)time;

/**
 *  模型数组
 *
 *  @param data 数据
 *
 *  @return 
 */
- (NSMutableArray *)buildWithData:(NSArray *)data;
@end
