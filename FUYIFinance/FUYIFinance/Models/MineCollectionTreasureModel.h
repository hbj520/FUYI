//
//  MineCollectionTreasureModel.h
//  FUYIFinance
//
//  Created by 张哲 on 16/7/6.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineCollectionTreasureModel : NSObject

@property (nonatomic,copy)NSString * name;          //宝贝名称
@property (nonatomic,copy)NSString * image;         //宝贝图片
@property (nonatomic,copy)NSString * price;         //宝贝价格
@property (nonatomic,copy)NSString * type;          //宝贝类型
@property (nonatomic,copy)NSString * teacher;       //讲师名称
@property (nonatomic,copy)NSString * num;
@property (nonatomic,copy)NSString * goodsid;
@property (nonatomic,copy)NSString * about;
@property (nonatomic,copy)NSString * cart;
@property (nonatomic,copy)NSString * collection;
@property (nonatomic,copy)NSString * tid;
/**
 *  重写模型的构造方法
 *
 *  @param name    宝贝名称
 *  @param image   宝贝图片
 *  @param price   宝贝价格
 *  @param type    宝贝类型
 *  @param teacher 讲师名称
 *
 *  @return        模型
 */
- (id)initWithName:(NSString*)name Image:(NSString*)image Price:(NSString*)price Type:(NSString*)type Teacher:(NSString*)teacher Num:(NSString *)num Goodsid:(NSString *)goodsid About:(NSString *)about Cart:(NSString *)cart Collect:(NSString *)collection Tid:(NSString *)tid;

/**
 *  根据返回的数据返回模型数组
 *
 *  @param data 数据
 *
 *  @return 模型数组
 */
- (NSMutableArray*)buildWithData:(NSArray*)data;

@end
