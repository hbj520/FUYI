//
//  Good.h
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/6/30.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Good : NSObject

@property (nonatomic,strong) NSString *goodId;
@property (nonatomic,strong) NSString *goodType;
@property (nonatomic,strong) NSString *goodPrice;
@property (nonatomic,strong) NSString *goodName;
@property (nonatomic,strong) NSString *goodImage;
@property (nonatomic,strong) NSString *teacherName;
@property (nonatomic,strong) NSString *type;

/**
 *  购物车列表
 *
 *  @param goodId      商品id
 *  @param goodType    商品类型
 *  @param goodPrice   商品价格
 *  @param goodName    商品名称
 *  @param goodImage   商品图片
 *  @param teacherName 讲师姓名
 *  @param type        类型
 *
 *  @return 
 */
- (id)initWithParameters:(NSString*)goodId
                goodType:(NSString*)goodType
               goodPrice:(NSString*)goodPrice
                goodName:(NSString*)goodName
               goodImage:(NSString*)goodImage
             teacherName:(NSString*)teacherName
                    type:(NSString*)type;

- (NSArray *)buildWithData:(NSArray *)data;
@end
