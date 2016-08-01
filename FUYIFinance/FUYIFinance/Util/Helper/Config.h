//
//  Config.h
//  FUYIFinance
//
//  Created by 张哲 on 16/7/8.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Config : NSObject
+ (Config *)Instance;
+ (id)allocWithZone:(struct _NSZone *)zone;

/**
 *  保存用户信息
 *
 *  @param userid   用户编号
 *  @param username 用户名
 *  @param PhoneNum 用户手机号码
 *  @param token    用户登录令牌
 *  @param icon     用户头像
 */
- (void)saveUserid:(NSString*)userid
          userName:(NSString*)username
      userPhoneNum:(NSString*)PhoneNum
             token:(NSString*)token
              icon:(NSString*)icon;

- (void)saveImgthumb:(NSString *)imgthumb
               token:(NSString *)token
            username:(NSString *)username;

//保存用户名
- (void)saveUsername:(NSString *)username;

//保存待付款未读数
- (void)saveWaitPayCount:(NSString *)count;

//获得待付款未读数
- (NSString *)getWaitPayCount;

//保存待评价未读数
- (void)saveWaitJudgeCount:(NSString *)count;

//获得待评价未读数
- (NSString *)getWaitJudgeCount;

/**
 *  保存图片
 *
 *  @param icon 图片
 */
- (void)saveIcon:(NSString *)icon;
/**
 *  保存用户密码
 *
 *  @param password 用户密码
 */

- (void)saveUserPassword:(NSString*)password;

- (NSString*)getUserId;       //获取用户id
- (NSString*)getUserName;     //获取用户名
- (NSString*)getUserPhoneNum; //获取用户手机号码
- (NSString*)getToken;        //获取用户登录令牌
//- (NSString*)getUserIcon;     //获取用户头像
- (NSString*)getPassword;     //获取用户密码
- (NSString *)getIcon;               //获取图片
- (void)logout;               //退出登录

@end
