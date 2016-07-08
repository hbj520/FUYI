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
/**
 *  发送短信验证码
 *
 *  @param phoneNum    注册的手机号码
 *  @param result      正常返回结果
 *  @param errorResult 返回出错
 */
- (void)registerWithParameters:(NSString *)phoneNum
                        result:(StateBlock)result
                   errorResult:(ErrorBlock)errorResult;

/**
 *  登录
 *
 *  @param phoneNumber 登陆的手机号码
 *  @param password    登录的密码
 *  @param result      返回登录结果
 *  @param errorResult 错误信息
 */
- (void)LoginWithNumber:(NSString*)phoneNumber password:(NSString*)password
                 result:(StateBlock)result errorResult:(ErrorBlock)errorResult;

#pragma mark -首页
- (void)homePageWithResult:(ArrayBlock)result
               errorResult:(ErrorBlock)errorResult;
#pragma mark -商城-产品类型
- (void)videoStoreWithResult:(ArrayBlock)result
                 errorResult:(ErrorBlock)errorResult;
#pragma mark -商城默认
- (void)videoStoreDefaultDataWithResult:(ArrayBlock)result
                             erroResult:(ErrorBlock)erroResult;
#pragma mark -id加载商城
- (void)videoStoreWithSelectId:(NSString*)SelectId
                        result:(ArrayBlock)result
                   errorResult:(ErrorBlock)errorResult;
- (void)videoStoreWithRightSelectId:(NSString*)RightSelectId
                        result:(ArrayBlock)result
                   errorResult:(ErrorBlock)errorResult;
#pragma mark -博客
#pragma mark -个人中心
/**
 *  用户收藏的宝贝
 *
 *  @param page        页数
 *  @param result      模型数组
 *  @param errorResult 错误信息
 */
- (void)requestCollectionTreasureDataWithParameters:(NSString*)page result:(ArrayBlock)result errorResult:(ErrorBlock)errorResult;

/**
 *  用户收藏的店铺
 *
 *  @param page        页数
 *  @param result      模型数组
 *  @param errorResult 错误信息
 */
- (void)requestCollectionShopDataWithParameters:(NSString*)page result:(ArrayBlock)result errorResult:(ErrorBlock)errorResult;

/**
 *  用户的评价
 *
 *  @param page        页数
 *  @param result      模型数组
 *  @param errorResult 错误信息
 */
- (void)requestMyJudgeDataWithParameters:(NSString*)page result:(ArrayBlock)result errorResult:(ErrorBlock)errorResult;

/**
 *  用户待付款的订单
 *
 *  @param page        页数
 *  @param result      模型数组
 *  @param errorResult 错误信息
 */
- (void)requestWaitpayDataWithParameters:(NSString*)page result:(ArrayBlock)result errorResult:(ErrorBlock)errorResult;


#pragma mark -讲师团队




@end
