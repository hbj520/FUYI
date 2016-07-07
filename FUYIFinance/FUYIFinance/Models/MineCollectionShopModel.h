//
//  MineCollectionShopModel.h
//  FUYIFinance
//
//  Created by 张哲 on 16/7/7.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineCollectionShopModel : NSObject

@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * image;
@property (nonatomic,copy) NSString * teacher;

/**
 *  重写构造模型方法
 *
 *  @param name    店铺名称
 *  @param image   店铺图片
 *  @param teacher 老师名称
 *
 *  @return 用户收藏的店铺模型
 */
- (id)initWithName:(NSString *)name Image:(NSString*)image Teacher:(NSString*)teacher;


/**
 *  根据数据返回模型数组
 *
 *  @param data 后台数据
 *
 *  @return 用户收藏的店铺模型数组
 */
- (NSMutableArray *)buildWithData:(NSArray*)data;

@end
