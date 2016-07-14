//
//  UserInfoModel.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/14.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel


- (id)initWithParams:(NSString *)userName imgthumb:(NSString *)imgthumb token:(NSString *)token
{
    UserInfoModel * model = [[UserInfoModel alloc] init];
    model.username = userName;
    model.imgthumb = imgthumb;
    model.token = token;
    return model;
}

- (UserInfoModel *)buildWithDatas:(NSDictionary *)datas
{
    NSString * imgthumb = [datas objectForKey:@"imgthumb"];
    NSString * token = [datas objectForKey:@"token"];
    NSString * username = [datas objectForKey:@"username"];
    UserInfoModel * model = [[UserInfoModel alloc] initWithParams:username imgthumb:imgthumb token:token];
    return model;
}

@end
