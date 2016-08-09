//
//  TeacherShopInfoModel.h
//  FUYIFinance
//
//  Created by 张哲 on 16/8/8.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeacherShopInfoModel : NSObject
@property (nonatomic,copy)NSString * uid;
@property (nonatomic,copy)NSString * name;
@property (nonatomic,copy)NSString * about;
@property (nonatomic,copy)NSString * imagethumb;

/**
 *  数据模型
 *
 *  @param uid        店铺编号
 *  @param name       店铺名称
 *  @param about      店铺介绍
 *  @param imagethumb 店铺头像
 *
 *  @return 数据模型
 */
- (id)initWithId:(NSString *)uid
            Name:(NSString *)name
             About:(NSString *)about
        Imagethumb:(NSString *)imagethumb;
/**
 *  构造数据模型
 *
 *  @param data 数据
 *
 *  @return 数据模型
 */
- (id)buildWithData:(NSDictionary *)data;
@end
