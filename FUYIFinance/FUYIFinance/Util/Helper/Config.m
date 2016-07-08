//
//  Config.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/8.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "Config.h"

@implementation Config

static Config * instance = nil;
+ (Config *)Instance
{
    @synchronized (self) {
        if(instance == nil){
            [self new];
        }
    }
    return  instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    @synchronized (self) {
        if (instance == nil) {
            instance = [super allocWithZone:zone];
            return instance;
        }
    }
    return nil;
}

/**
 *  保存用户信息
 *
 *  @param userid   用户编号
 *  @param username 用户名
 *  @param PhoneNum 用户手机号码
 *  @param token    用户登录令牌
 *  @param icon     用户头像
 */
- (void)saveUserid:(NSString *)userid userName:(NSString *)username userPhoneNum:(NSString *)PhoneNum token:(NSString *)token icon:(NSString *)icon
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults]
    ;
    [settings removeObjectForKey:@"userid"];
    [settings setObject:userid forKey:@"userid"];
    
    [settings removeObjectForKey:@"username"];
    [settings setObject:username forKey:@"username"];
    
    [settings removeObjectForKey:@"phonenum"];
    [settings setObject:PhoneNum forKey:@"phonenum"];
    
    [settings removeObjectForKey:@"token"];
    [settings setObject:token forKey:@"token"];
    
    [settings removeObjectForKey:@"icon"];
    [settings setObject:icon forKey:@"icon"];
    
    [settings synchronize];
}

/**
 *  保存密码
 *
 *  @param password 用户密码
 */
- (void)saveUserPassword:(NSString *)password
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:@"password"];
    [settings setObject:password forKey:@"password"];
    
    [settings synchronize];
    
}

- (NSString*)getUserId
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings stringForKey:@"userid"];
}

- (NSString*)getUserName
{
    NSUserDefaults * settings =[NSUserDefaults standardUserDefaults];
    return [settings stringForKey:@"username"];
}

- (NSString*)getPassword
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings stringForKey:@"password"];
}

- (NSString*)getToken
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings stringForKey:@"token"];
}

- (NSString *)getUserPhoneNum
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings stringForKey:@"phonenum"];
}


@end
