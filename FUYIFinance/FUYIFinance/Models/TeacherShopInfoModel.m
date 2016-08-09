//
//  TeacherShopInfoModel.m
//  FUYIFinance
//
//  Created by 张哲 on 16/8/8.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "TeacherShopInfoModel.h"

@implementation TeacherShopInfoModel

- (id)initWithId:(NSString *)uid
            Name:(NSString *)name
           About:(NSString *)about
      Imagethumb:(NSString *)imagethumb
{
    TeacherShopInfoModel * model = [[TeacherShopInfoModel alloc] init];
    model.uid = uid;
    model.name = name;
    model.about = about;
    model.imagethumb = imagethumb;
    return model;
}

- (id)buildWithData:(NSDictionary *)data
{
    NSString * uid = data[@"id"];
    NSString * name = data[@"name"];
    NSString * about = data[@"about"];
    NSString * thumb = data[@"thumb"];
    TeacherShopInfoModel * model = [[TeacherShopInfoModel alloc] initWithId:uid Name:name About:about Imagethumb:thumb];
    return model;
}

@end
