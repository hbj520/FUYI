//
//  ManageTreasureModel.h
//  FUYIFinance
//
//  Created by 张哲 on 16/7/28.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ManageTreasureModel : NSObject

@property (nonatomic,copy)NSString * goodsid;
@property (nonatomic,copy)NSString * title;
@property (nonatomic,copy)NSString * price;
@property (nonatomic,copy)NSString * thumbimg;
@property (nonatomic,copy)NSString * time;
@property (nonatomic,copy)NSString * num;

/**
 *  模型数组
 *
 *  @param goodsid  视频编号
 *  @param title    视频名称
 *  @param price    视频价格
 *  @param thumbimg 视频图片
 *  @param time     视频上传时间
 *  @param num      视频已售数目
 *
 *  @return 模型
 */
- (id)initWithGoodsid:(NSString *)goodsid
                Title:(NSString *)title
                Price:(NSString *)price
             Thumbimg:(NSString *)thumbimg
                 Time:(NSString *)time
                  Num:(NSString *)num;

/**
 *  返回模型数组
 *
 *  @param data 数据
 *
 *  @return 模型数组
 */
- (NSMutableArray *)buildWithData:(NSArray *)data;


@end
