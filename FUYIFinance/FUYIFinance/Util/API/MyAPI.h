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
 *  注册
 *
 *  @param phoneNum    注册的手机号码
 *  @param password    注册的密码
 *  @param repassword  注册的确认密码
 *  @param yzmnum      验证码
 *  @param result      正常返回结果
 *  @param errorResult 返回出错
 */
- (void)registerWithParameters:(NSString*)phoneNum
                      Password:(NSString*)password
                    RePassword:(NSString*)repassword
                        YZMNum:(NSString*)yzmnum
                        result:(StateBlock)result
                   errorResult:(ErrorBlock)errorResult;

/**
 *  忘记密码发送短信验证码
 *
 *  @param phoneNum    忘记密码的手机号码
 *  @param result      正常返回结果
 *  @param errorResult 返回出错
 */
- (void)sendYZMWithParameters:(NSString *)phoneNum
                       result:(StateBlock)result
                  errorResult:(ErrorBlock)errorResult;

/**
 *  忘记密码
 *
 *  @param phonenum    忘记密码的手机号码
 *  @param yzm         验证码
 *  @param password    密码
 *  @param repassword  确认密码
 *  @param result      正常返回结果
 *  @param errorResult 返回出错
 */
- (void)forgetPasswordWithPhonenum:(NSString *)phonenum
                               YZM:(NSString *)yzm
                          Password:(NSString *)password
                        Repassword:(NSString *)repassword
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
- (void)LoginWithNumber:(NSString*)phoneNumber
               password:(NSString*)password
                 result:(StateBlock)result
            errorResult:(ErrorBlock)errorResult;



#pragma mark -首页
- (void)homePageWithResult:(ArrayBlock)result
               errorResult:(ErrorBlock)errorResult;
#pragma mark -商城-产品类型
- (void)videoStoreWithResult:(ArrayBlock)result
                 errorResult:(ErrorBlock)errorResult;

#pragma mark -id加载商城
- (void)videoStoreWithToken:(NSString*)token
               typeSelectId:(NSString*)typeSelectId
              labelSelectId:(NSString*)labelSelectId
                       page:(NSString*)page
                    keyWord:(NSString*)keyWord
                     result:(ArrayBlock)result
                errorResult:(ErrorBlock)errorResult;

#pragma mark -讲师店铺
- (void)getTeacherStoreDataWithTeacherId:(NSString*)teacherId
                                    page:(NSString*)page
                                  result:(ArrayBlock)result
                             errorResult:(ErrorBlock)errorResult;

#pragma mark -收藏商品
- (void)collectGoodsWithToken:(NSString*)token
                      goodsId:(NSString*)goodsId
                         type:(NSString*)type
                       result:(StateBlock)result
                  errorResult:(ErrorBlock)errorResult;


#pragma mark -取消收藏商品
- (void)cancelCollectGoodsWithWithToken:(NSString*)token
                                goodsId:(NSString*)goodsId
                                   type:(NSString*)type
                                 result:(StateBlock)result
                            errorResult:(ErrorBlock)errorResult;
#pragma mark -购物车界面
- (void)getShopCarDataWithToken:(NSString*)token
                           page:(NSString*)page
                         result:(ArrayBlock)result
                    errorResult:(ErrorBlock)errorResult;

#pragma mark -删除购物车商品
- (void)deleteVideoFromShopCarWithToken:(NSString*)token
                               orderNum:(NSString*)orderNum
                                 result:(StateBlock)result
                            errorResult:(ErrorBlock)errorRusult;

#pragma mark -加入购物车
- (void)addGoodIntoShopCarWithToken:(NSString*)token
                            goodsId:(NSString*)goodsId
                               type:(NSString*)type
                              money:(NSString*)money
                             result:(StateBlock)result
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
- (void)requestCollectionTreasureDataWithParameters:(NSString*)page
                                             result:(ArrayBlock)result
                                        errorResult:(ErrorBlock)errorResult;

/**
 *  用户收藏的店铺
 *
 *  @param page        页数
 *  @param result      模型数组
 *  @param errorResult 错误信息
 */
- (void)requestCollectionShopDataWithParameters:(NSString*)page
                                         result:(ArrayBlock)result
                                    errorResult:(ErrorBlock)errorResult;

/**
 *  用户的评价
 *
 *  @param page        页数
 *  @param result      模型数组
 *  @param errorResult 错误信息
 */
- (void)requestMyJudgeDataWithParameters:(NSString*)page
                                  result:(ArrayBlock)result
                             errorResult:(ErrorBlock)errorResult;

/**
 *  用户待付款的订单
 *
 *  @param page        页数
 *  @param result      模型数组
 *  @param errorResult 错误信息
 */
- (void)requestWaitpayDataWithParameters:(NSString*)page
                                  result:(ArrayBlock)result
                             errorResult:(ErrorBlock)errorResult;

- (void)requestWaitjudgeDataWithParameters:(NSString*)page
                                    result:(ArrayBlock)result
                               errorResult:(ErrorBlock)errorResult;
/**
 *  用户评价商品
 *
 *  @param score       评分
 *  @param anonymous   是否匿名
 *  @param content     评论内容
 *  @param goodstyle   当前评论的商品类型
 *  @param goodsid     商品的id
 *  @param result      模型数组
 *  @param errorResult 错误信息
 */
- (void)uploadUserJudgeWithParameters:(NSString*)score
                             OrderNum:(NSString*)ordernum
                            Anonymous:(NSString*)anonymous
                              Content:(NSString*)content
                            Goodstyle:(NSString*)goodstyle
                              Goodsid:(NSString*)goodsid
                               result:(StateBlock)result
                          errorResult:(ErrorBlock)errorResult;

/**
 *  全部的订单
 *
 *  @param page        页数
 *  @param result      模型数组
 *  @param errorResult 错误信息
 */
- (void)requestAllOrderDataWithParameters:(NSString *)page
                                   result:(ArrayBlock)result
                              errorResult:(ErrorBlock)errorResult;

/**
 *  取消订单
 *
 *  @param ordernum    订单号
 *  @param result      取消订单状态
 *  @param errorResult 错误信息
 */
- (void)cancelOrderWithOrdernum:(NSString *)ordernum
                         result:(StateBlock)result
                    errorResult:(ErrorBlock)errorResult;

/**
 *  退出登录
 *
 *  @param result      退出登录状态
 *  @param errorResult 错误信息
 */
- (void)LoginOutWithResult:(StateBlock)result
               errorResult:(ErrorBlock)errorResult;


/**
 *  修改密码
 *
 *  @param oldPassword 旧密码
 *  @param newPassword 新密码
 *  @param result      返回结果
 *  @param errorResult 错误信息
 */
- (void)reSetPasswordWithOldPassword:(NSString *)oldPassword
                         newPassword:(NSString *)newPassword
                              Result:(StateBlock)result
                         errorResult:(ErrorBlock)errorResult;

/**
 *  上传图片
 *
 *  @param imageData   图片数据
 *  @param result      上传图片状态
 *  @param errorResult 错误信息
 */
- (void)uploadImage:(NSData *)imageData
             result:(StateBlock)result
        errorResult:(ErrorBlock)errorResult;

/**
 *  修改个人资料
 *
 *  @param username    用户名
 *  @param imgthumb    用户头像
 *  @param qqnum       用户qq号
 *  @param sex         用户性别
 *  @param emailnum    用户邮箱号码
 *  @param result      返回结果
 *  @param errorResult 错误信息
 */
- (void)PersonalInfoModifyWithParameters:(NSString *)username
                                imgThumb:(NSString *)imgthumb
                                   qqNum:(NSString *)qqnum
                                     Sex:(NSString *)sex
                                emailNum:(NSString *)emailnum
                                  result:(StateBlock)result
                             errorResult:(ErrorBlock)errorResult;

/**
 *  个人资料
 *
 *  @param result      个人资料模型
 *  @param errorResult 错误信息
 */
- (void)PersonalDetailInfoWith:(ModelBlock)result
                   errorResult:(ErrorBlock)errorResult;

/**
 *  我的店铺
 *
 *  @param page        页数
 *  @param result      模型数组
 *  @param errorResult 错误信息
 */
- (void)RequestTeacherPersonalShopDataWithPage:(NSString *)page
                                        result:(ArrayBlock)result
                                   errorResult:(ErrorBlock)errorResult;
/**
 *
 *宝贝管理
 *  @param page        页数
 *  @param result      模型数组
 *  @param errorResult 错误信息
 */
- (void)RequestManageTreasureDataWithPage:(NSString *)page
                                   result:(ArrayBlock)result
                              errorResult:(ErrorBlock)errorResult;


#pragma mark -讲师团队
- (void)getTeacherTeamDataWithToken:(NSString*)token
                               page:(NSString*)page
                             result:(ArrayBlock)result
                        errorResult:(ErrorBlock)errorResult;

#pragma mark -取消关注讲师
- (void)cancelFocusTeacherWithToken:(NSString*)token
                          teacherId:(NSString*)teacherId
                             result:(StateBlock)result
                        errorResult:(ErrorBlock)errorResult;

#pragma mark -关注讲师
- (void)focusTeacherWithToken:(NSString*)token
                    teacherId:(NSString*)teacherId
                       result:(StateBlock)result
                  errorResult:(ErrorBlock)errorResult;

#pragma mark -讲师详情
- (void)getTeacherDetailDataWithToken:(NSString*)token
                            teacherId:(NSString*)teacherId
                               result:(ModelBlock)result
                          errorResult:(ErrorBlock)errorResult;
@end
