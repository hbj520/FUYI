//
//  MyAPI.h
//  FUYIFinance
//
//  Created by youyou on 16/7/5.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^VoidBlock) (void);
typedef void (^StateBlock) (BOOL sucess, NSString *msg);
typedef void (^ModelBlock) (BOOL success, NSString *msg, id object);
typedef void (^ArrayBlock) (BOOL success, NSString *msg, NSMutableArray *arrays);
typedef void (^ErrorBlock) (NSError *enginerError);
@interface MyAPI : NSObject
+ (MyAPI *)sharedAPI;
//取消所有网路全部请求
- (void)cancelAllOperation;

#pragma mark -富谊财经接口
#pragma mark -注册/登陆/密码修改
#pragma mark -商城
#pragma mark -博客
#pragma mark -个人中心
#pragma mark -讲师团队




@end
