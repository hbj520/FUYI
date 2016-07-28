//
//  PersonalUserInfo.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/28.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "PersonalUserInfo.h"

@implementation PersonalUserInfo

- (id)initWithParameters:(NSString *)userName
                     Sex:(NSString *)sex
                Imgthumb:(NSString *)imgthumb
                   Email:(NSString *)email
                   qqNum:(NSString *)qqnum
{
    PersonalUserInfo * model = [[PersonalUserInfo alloc] init];
    model.userName = userName;
    model.sex = sex;
    model.imgthumb = imgthumb;
    model.email = email;
    model.qqNum = qqnum;
    return model;
}

- (id)buildWithData:(NSDictionary *)data
{
    NSString * username = data[@"username"];
    NSString * sex = data[@"sex"];
    NSString * imgthumb = data[@"imgthumb"];
    NSString * email = data[@"email"];
    NSString * qq = data[@"qq"];
    PersonalUserInfo * model = [[PersonalUserInfo alloc] initWithParameters:username
                                                                        Sex:sex
                                                                   Imgthumb:imgthumb
                                                                      Email:email
                                                                      qqNum:qq];
    return model;
    
}

@end
