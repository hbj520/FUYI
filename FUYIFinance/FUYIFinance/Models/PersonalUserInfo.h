//
//  PersonalUserInfo.h
//  FUYIFinance
//
//  Created by 张哲 on 16/7/28.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonalUserInfo : NSObject
@property (nonatomic,copy) NSString * userName;
@property (nonatomic,copy) NSString * sex;
@property (nonatomic,copy) NSString * imgthumb;
@property (nonatomic,copy) NSString * email;
@property (nonatomic,copy) NSString * qqNum;

/**
 *  个人信息
 *
 *  @param userName 用户昵称
 *  @param sex      用户性别
 *  @param imgthumb 用户头像
 *  @param email    用户邮箱
 *  @param qqnum    用户qq号
 *
 *  @return 用户个人信息模型
 */
- (id)initWithParameters:(NSString *)userName
                     Sex:(NSString *)sex
                Imgthumb:(NSString *)imgthumb
                   Email:(NSString *)email
                   qqNum:(NSString *)qqnum;
- (id)buildWithData:(NSDictionary *)data;
@end
