//
//  MineWaitPayModel.h
//  FUYIFinance
//
//  Created by 张哲 on 16/7/7.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineWaitPayModel : NSObject

@property (nonatomic,copy)NSString * ctime;
@property (nonatomic,copy)NSString * price;
@property (nonatomic,copy)NSString * ordernum;
@property (nonatomic,copy)NSString * image;
@property (nonatomic,copy)NSString * name;
@property (nonatomic,copy)NSString * teacher;
@property (nonatomic,copy)NSString * shopname;

/**
 *  重写模型的构造方法
 *
 *  @param ctime    待付款的订单的时间
 *  @param price    待付款的订单的价格
 *  @param image    待付款订单的图片
 *  @param name     待付款订单的名称
 *  @param teacher  待付款订单的老师
 *  @param shopname 待付款订单的商店名称
 *
 *  @return 待付款订单模型
 */
- (id)initWithCtime:(NSString*)ctime Price:(NSString*)price Image:(NSString*)image Name:(NSString*)name Teacher:(NSString*)teacher ShopName:(NSString*)shopname Ordernum:(NSString *)ordernum;
/**
 *  根据后台数据返回模型数组
 *
 *  @param data 后台数据
 *
 *  @return 模型数组
 */
- (NSMutableArray *)buildWithData:(NSArray*)data;

@end
