//
//  TeacherShopModel.h
//  FUYIFinance
//
//  Created by 张哲 on 16/7/28.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TeacherShopModel : NSObject

@property (nonatomic,copy)NSString * goodsid;
@property (nonatomic,copy)NSString * title;
@property (nonatomic,copy)NSString * price;
@property (nonatomic,copy)NSString * thumbimg;
@property (nonatomic,copy)NSString * about;
@property (nonatomic,copy)NSString * tid;
@property (nonatomic,copy)NSString * teachername;
@property (nonatomic,copy)NSString * type;
@property (nonatomic,copy)NSString * collection;
@property (nonatomic,copy)NSString * cart;
@property (nonatomic,copy)NSString * num;

/**
 *  模型
 *
 *  @param goodsid     视频编号
 *  @param title       视频标题
 *  @param price       视频价格
 *  @param thumbimg    视频图片
 *  @param about       描述
 *  @param tid         讲师编号
 *  @param teachername 讲师名称
 *  @param type        视频类型
 *  @param cart        是否收藏
 *  @param num         付款人数
 *
 *  @return 数据模型
 */
- (id)initWithGoodsid:(NSString *)goodsid
                Title:(NSString *)title
                Price:(NSString *)price
             thumbImg:(NSString *)thumbimg
                About:(NSString *)about
                  Tid:(NSString *)tid
          teacherName:(NSString *)teachername
                 Type:(NSString *)type
           collection:(NSString *)collection
                 Cart:(NSString *)cart
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
