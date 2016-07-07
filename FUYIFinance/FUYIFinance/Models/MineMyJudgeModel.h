//
//  MineMyJudgeModel.h
//  FUYIFinance
//
//  Created by 张哲 on 16/7/7.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineMyJudgeModel : NSObject

@property (nonatomic,copy)NSString * image;
@property (nonatomic,copy)NSString * name;
@property (nonatomic,copy)NSString * ctime;
@property (nonatomic,copy)NSString * content;

/**
 *  重写模型构造方法
 *
 *  @param image   我的评价图片
 *  @param name    我的评价名称
 *  @param ctime   我的评价时间
 *  @param content 我的评价内容
 *
 *  @return 我的评价模型
 */
- (id)initWithImage:(NSString*)image Name:(NSString*)name Ctime:(NSString*)ctime Content:(NSString*)content;

/**
 *  根据后台数据返回模型数组
 *
 *  @param data 后台数据
 *
 *  @return 我的评价模型数组
 */
- (NSMutableArray*)buildWithData:(NSArray*)data;

@end
