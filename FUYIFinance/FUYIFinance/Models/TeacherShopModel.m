//
//  TeacherShopModel.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/28.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "TeacherShopModel.h"

@implementation TeacherShopModel

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
                  Num:(NSString *)num
{
    TeacherShopModel * model = [[TeacherShopModel alloc] init];
    model.goodsid = goodsid;
    model.title = title;
    model.price = price;
    model.thumbimg = thumbimg;
    model.about = about;
    model.tid = tid;
    model.teachername = teachername;
    model.type = type;
    model.collection = collection;
    model.cart = cart;
    model.num = num;
    return model;
}

- (NSMutableArray *)buildWithData:(NSArray *)data
{
    NSMutableArray * teachershopArray = [NSMutableArray array];
    for(NSDictionary * dict in data){
        NSString * goodsid = dict[@"goodsid"];
        NSString * title = dict[@"title"];
        NSString * price = dict[@"price"];
        NSString * thumbimg = dict[@"thumbimg"];
        NSString * about = dict[@"about"];
        NSString * tid = dict[@"tid"];
        NSString * teachername = dict[@"teachername"];
        NSNumber * type = dict[@"type"];
        NSString * typeStr = [NSString stringWithFormat:@"%ld",type.integerValue];
        NSNumber * collection = dict[@"collect"];
        NSString * collectStr = [NSString stringWithFormat:@"%ld",collection.integerValue];
        NSNumber * cart = dict[@"cart"];
        NSString * cartStr = [NSString stringWithFormat:@"%ld",cart.integerValue];
        NSNumber * num = dict[@"num"];
        NSString * numStr = [NSString stringWithFormat:@"%ld",num.integerValue];
        TeacherShopModel * model = [[TeacherShopModel alloc] initWithGoodsid:goodsid
                                                                       Title:title
                                                                       Price:price
                                                                    thumbImg:thumbimg
                                                                       About:about
                                                                         Tid:tid
                                                                 teacherName:teachername
                                                                        Type:typeStr
                                                                  collection:collectStr
                                                                        Cart:cartStr
                                                                         Num:numStr];
        [teachershopArray addObject:model];
    }
    return teachershopArray;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
