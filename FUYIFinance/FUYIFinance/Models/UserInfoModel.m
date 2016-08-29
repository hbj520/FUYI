//
//  UserInfoModel.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/14.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel


- (id)initWithParams:(NSString *)userName
            imgthumb:(NSString *)imgthumb
               token:(NSString *)token
               money:(NSString *)money
               ucoin:(NSString *)ucoin
            integral:(NSString *)integral
{
    UserInfoModel * model = [[UserInfoModel alloc] init];
    model.username = userName;
    model.imgthumb = imgthumb;
    model.token = token;
    model.money = money;
    model.ucoin= ucoin;
    model.integral = integral;
    return model;
}

- (UserInfoModel *)buildWithDatas:(NSDictionary *)datas
{
    NSString * imgthumb = [datas objectForKey:@"imgthumb"];
    NSString * token = [datas objectForKey:@"token"];
    NSString * username = [datas objectForKey:@"username"];
    NSString * money = [datas objectForKey:@"money"];
    NSString * ucoin = [datas objectForKey:@"Ucoin"];
    NSString * integral = [datas objectForKey:@"integral"];
    UserInfoModel * model = [[UserInfoModel alloc] initWithParams:username
                                                         imgthumb:imgthumb
                                                            token:token
                                                            money:money
                                                            ucoin:ucoin
                                                         integral:integral];
    
    return model;
}

@end
