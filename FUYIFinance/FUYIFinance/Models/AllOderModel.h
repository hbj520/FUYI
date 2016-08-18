//
//  AllOderModel.h
//  FUYIFinance
//
//  Created by 张哲 on 16/7/21.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AllOderModel : NSObject
@property (nonatomic,copy)NSString * ctime;
@property (nonatomic,copy)NSString * goodsid;
@property (nonatomic,copy)NSString * goodstype;
@property (nonatomic,copy)NSString * state;
@property (nonatomic,copy)NSString * price;
@property (nonatomic,copy)NSString * image;
@property (nonatomic,copy)NSString * name;
@property (nonatomic,copy)NSString * teacher;
@property (nonatomic,copy)NSString * shopname;
@property (nonatomic,copy)NSString * ordernum;
@property (nonatomic,copy)NSString * content;
/**
 *  重写构造模型方法
 *
 *  @param ctime     时间
 *  @param goodsid   商品编号
 *  @param goodstype 商品类型
 *  @param state     商品状态
 *  @param price     商品价格
 *  @param image     商品图片
 *  @param name      商品名称
 *  @param teacher   老师名称
 *  @param shopname  商店名称
 *
 *  @return 模型
 */
- (id)initWithCtime:(NSString *)ctime
            Goodsid:(NSString *)goodsid
          Goodstype:(NSString *)goodstype
              State:(NSString *)state
              Price:(NSString *)price
              Image:(NSString *)image
               Name:(NSString *)name
            Teacher:(NSString *)teacher
           Shopname:(NSString *)shopname
           Ordernum:(NSString *)ordernum
            Content:(NSString *)content;

/**
 *  返回模型数组
 *
 *  @return 模型数组
 */
- (NSMutableArray *)buildWithData:(NSArray *)data;


@end
