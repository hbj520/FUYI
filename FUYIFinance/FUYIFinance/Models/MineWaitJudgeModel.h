//
//  MineWaitJudgeModel.h
//  FUYIFinance
//
//  Created by 张哲 on 16/7/19.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineWaitJudgeModel : NSObject
@property (nonatomic,copy)NSString * ctime;
@property (nonatomic,copy)NSString * goodsid;
@property (nonatomic,copy)NSString * goodstyle;
@property (nonatomic,copy)NSString * price;
@property (nonatomic,copy)NSString * image;
@property (nonatomic,copy)NSString * name;
@property (nonatomic,copy)NSString * teacher;
@property (nonatomic,copy)NSString * shopname;
/**
 *
 *
 *  @param ctime    时间
 *  @param goodsid  商品Id
 *  @param price    价格
 *  @param image    图片
 *  @param name     名称
 *  @param teacher  老师名称
 *  @param shopname 店铺名称
 *
 *  @return 模型
 */
- (id)initWithCtime:(NSString *)ctime
            Goodsid:(NSString *)goodsid
          Goodstyle:(NSString *)goodstyle
              Price:(NSString *)price
              Image:(NSString *)image
               Name:(NSString *)name
            Teacher:(NSString *)teacher
           Shopname:(NSString *)shopname;
/**
 *  返回模型数组
 *
 *  @param data 数据
 *
 *  @return 模型数组
 */
- (NSMutableArray *)buildWithData:(NSArray*)data;

@end
