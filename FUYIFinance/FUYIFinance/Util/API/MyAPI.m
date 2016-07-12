//
//  MyAPI.m
//  FUYIFinance
//
//  Created by youyou on 16/7/5.
//  Copyright © 2016年 youyou. All rights reserved.
//
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFURLResponseSerialization.h>
#import "MyAPI.h"


//models
#import "HomepageBannerModel.h"
#import "HomePageNoticeModel.h"
#import "HomePageInvestModel.h"

#import "SelectModel.h"
#import "StoreDataModel.h"
//mine models
#import "MineCollectionTreasureModel.h"
#import "MineCollectionShopModel.h"
#import "MineMyJudgeModel.h"

@interface MyAPI ()
@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;

@end
@implementation MyAPI
- (id)init{
    self = [super init];
    if (self) {
        
        self.manager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:BaseUrl]] ;
        self.manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    return self;
}
+ (MyAPI *)sharedAPI{
    static MyAPI *sharedAPIInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedAPIInstance = [[self alloc] init];
    });
    return sharedAPIInstance;
}
- (void)cancelAllOperation{
    [self.manager.operationQueue cancelAllOperations];
}

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
                   errorResult:(ErrorBlock)errorResult{
    NSDictionary *parameters = @{
                                 @"phone":phoneNum
                                 };
    [self.manager POST:@"nos_sendyzm" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *status = responseObject[@"status"];
        NSString *info = responseObject[@"info"];
        if ([status isEqualToString:@"1"]) {
            result(YES,info);
        }else{
            result(NO,info);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        errorResult(error);
    }];
}

/**
 *  注册
 *
 *  @param phoneNum    注册的手机号码
 *  @param password    注册的密码
 *  @param repassword  注册的确认密码
 *  @param yzmnum      注册的验证码
 *  @param result      正常返回结果
 *  @param errorResult 错误信息
 */
- (void)registerWithParameters:(NSString *)phoneNum Password:(NSString *)password RePassword:(NSString *)repassword YZMNum:(NSString *)yzmnum result:(StateBlock)result errorResult:(ErrorBlock)errorResult
{
    NSDictionary * parameters = @{@"phone":phoneNum,@"passwd":password,@"repasswd":repassword,@"yzm":yzmnum};
    [self.manager POST:@"nos_reg" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * status = responseObject[@"status"];
        NSString * information = responseObject[@"info"];
        if([status isEqualToString:@"1"]){
            result(YES,information);
        }else{
            result(NO,information);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        errorResult(error);
    }];
    
}

/**
 *  登录
 *
 *  @param phoneNumber 登陆的手机号码
 *  @param password    登录的密码
 *  @param result      返回登录结果
 *  @param errorResult 错误信息
 */
- (void)LoginWithNumber:(NSString *)phoneNumber password:(NSString *)password result:(StateBlock)result errorResult:(ErrorBlock)errorResult
{
    NSDictionary * parameters = @{@"phone":phoneNumber,@"userpwd":password};
    [self.manager POST:@"nos_login" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * state = responseObject[@"status"];
        NSString * information = responseObject[@"info"];
        if([state isEqualToString:@"1"]){
            result(YES,information);
        }else{
            result(NO,information);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        errorResult(error);
    }];
}

#pragma mark -首页
- (void)homePageWithResult:(ArrayBlock)result
               errorResult:(ErrorBlock)errorResult{
    [self.manager POST:@"nos_index" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *status = responseObject[@"status"];
        NSString *info = responseObject[@"info"];
        
        if ([status isEqualToString:@"1"]) {
            if ([responseObject[@"data"] isEqual:[NSNull null]]) {
                return result(YES,info,nil);
            }else{
                NSArray *bannerArray = responseObject[@"data"][@"banner"];
                NSArray *bannerModelArray = [[HomepageBannerModel alloc] buildWithData:bannerArray];
                
                NSArray *noticeArray = responseObject[@"data"][@"notice"];
                NSArray *noticeModelArray = [[HomePageNoticeModel alloc] buildWithData:noticeArray];
                
                NSArray *investArray = responseObject[@"data"][@"invest"];
                NSArray *investModelArray = [[HomePageInvestModel alloc] buildWithData:investArray
                                             ];
                
                return result(YES,info,@[bannerModelArray,noticeModelArray,investModelArray]);
            }
        }else{
            return result(NO,info,nil);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        errorResult(error);
    }];
}
#pragma mark -商城-产品类型

- (void)videoStoreWithResult:(ArrayBlock)result
                 errorResult:(ErrorBlock)errorResult{
    [self.manager POST:@"nos_select_mall" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *status = responseObject[@"status"];
        NSString *info = responseObject[@"info"];
        if ([status isEqualToString:@"1"]) {
            if ([responseObject[@"data"]isEqual:[NSNull null]]) {
                return result(YES,info,nil);
            }else{
                NSArray *typeArray = responseObject[@"data"][@"type"];
                NSArray *selectTypeArray = [[SelectModel alloc]buildWithData:typeArray];
                NSArray *labelArray = responseObject[@"data"][@"label"];
                NSArray *selectLabelArray = [[SelectModel alloc]buildWithData:labelArray];
                return result(YES,info,@[selectTypeArray,selectLabelArray]);
            }
        }else{
            return result(NO,info,nil);
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        errorResult(error);
    }];
    
}

#pragma mark -商城默认
- (void)videoStoreWithTypeSelectId:(NSString*)typeSelectId
                     labelSelectId:(NSString*)labelSelectId
                              page:(NSString*)page
                           keyWord:(NSString*)keyWord
                            result:(ArrayBlock)result
                       errorResult:(ErrorBlock)errorResult{
    NSDictionary *parameters = @{
                                 @"type":typeSelectId,
                                 @"lael":labelSelectId,
                                 @"page":page,
                                 @"key":keyWord
                                 };
    [self.manager POST:@"nos_mall" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *status = responseObject[@"status"];
        NSString *info = responseObject[@"info"];
        if ([status isEqualToString:@"1"]) {
            if ([responseObject[@"data"]isEqual:[NSNull null]]) {
                return result(YES,info,nil);
            }else{
                NSArray *newArray = responseObject[@"data"];
                StoreDataModel *model = [[StoreDataModel alloc]init];
                NSArray *storeArray = [model buildWithData:newArray];
                return result(YES,info,storeArray);
            }
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        errorResult(error);
    }];
    
}


#pragma mark -博客
#pragma mark -个人中心
- (void)requestCollectionTreasureDataWithParameters:(NSString*)page result:(ArrayBlock)result errorResult:(ErrorBlock)errorResult
{
 NSString * token = @"";
    NSDictionary * parameters = @{@"token":token};
    [self.manager POST:@"" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * status = responseObject[@"status"];
        NSString * info = responseObject[@"info"];
        
        if([status isEqualToString:@"1"]){
            if([responseObject[@"data"] isEqual:[NSNull null]]){
                result(YES,info,nil);
            }else{
                NSArray * collectionTreasureArray = responseObject[@"data"];
                NSMutableArray * collectionTreasureModelArray = [[MineCollectionTreasureModel alloc] buildWithData:collectionTreasureArray];
                
                result(YES,info,collectionTreasureModelArray);
            }
        }else{
            result(NO,info,nil);
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        errorResult(error);
    }];
}

- (void)requestCollectionShopDataWithParameters:(NSString*)page result:(ArrayBlock)result errorResult:(ErrorBlock)errorResult
{
    NSString * token = @"";
    NSDictionary * parameters = @{@"token":token,@"page":page};
    [self.manager POST:@"allstore" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * status = responseObject[@"status"];
        NSString * info = responseObject[@"info"];
        NSArray * data = responseObject[@"data"];
        
        if ([status isEqualToString:@"1"]) {
            if ([data isEqual:[NSNull null]]) {
                result(YES,info,nil);
            }else{
               NSMutableArray * MineCollectionShopModelArray = [[MineCollectionShopModel alloc] buildWithData:data];
                
                result(YES,info,MineCollectionShopModelArray);
                
            }
        }else{
            result(NO,info,nil);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        errorResult(error);
    }];
    
}

- (void)requestMyJudgeDataWithParameters:(NSString *)page result:(ArrayBlock)result errorResult:(ErrorBlock)errorResult
{
    NSString * token = @"";
    NSDictionary * parameters = @{@"token":token,@"page":page};
    [self.manager POST:@"alleva" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * status = responseObject[@"status"];
        NSString * info = responseObject[@"info"];
        NSArray * data = responseObject[@"data"];
        
        if ([status isEqualToString:@"1"]) {
            if ([data isEqual:[NSNull null]]) {
                result(YES,info,nil);
            }else{
                NSMutableArray * MyJudgeModelArray = [[MineMyJudgeModel alloc] buildWithData:data];
                result(YES,info,MyJudgeModelArray);
            }
        }else{
            result(NO,info,nil);
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        errorResult(error);
    }];
}

- (void)requestWaitpayDataWithParameters:(NSString *)page result:(ArrayBlock)result errorResult:(ErrorBlock)errorResult
{
 NSString * token = @"";
    NSDictionary * parameters = @{@"token":token,@"page":page};
    [self.manager POST:@"pendpay" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
      
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}

#pragma mark -讲师团队
@end
