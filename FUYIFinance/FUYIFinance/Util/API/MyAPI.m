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
#import "Config.h"

//models
#import "HomepageBannerModel.h"
#import "HomePageNoticeModel.h"
#import "HomePageInvestModel.h"

#import "SelectModel.h"
#import "StoreDataModel.h"
#import "TeacherTeamModel.h"
#import "TeacherModel.h"
#import "TeacherStoreHeaderModel.h"


#import "Good.h"
#import "TeacherStoreModel.h"

//mine models
#import "MineCollectionTreasureModel.h"
#import "MineCollectionShopModel.h"
#import "MineMyJudgeModel.h"
#import "MineWaitPayModel.h"
#import "MineWaitJudgeModel.h"
#import "UserInfoModel.h"
#import "AllOderModel.h"
#import "PersonalUserInfo.h"
#import "TeacherShopModel.h"
#import "TeacherInfo.h"
#import "ManageTreasureModel.h"
#import "OrderManageModel.h"
#import "TeacherShopInfoModel.h"
#import "SystemNoticeModel.h"
#import "OrderNoticeModel.h"
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

- (void)sendYZMWithParameters:(NSString *)phoneNum
                       result:(StateBlock)result
                  errorResult:(ErrorBlock)errorResult
{
    NSDictionary *parameters = @{
                                 @"phone":phoneNum
                                 };
[self.manager POST:@"nos_sendzhyzm" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
    NSString * status = responseObject[@"status"];
    NSString * info = responseObject[@"info"];
    if([status isEqualToString:@"1"]){
        result(YES,info);
    }else{
        result(NO,info);
    }
} failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
    errorResult(error);
}];
    
}

- (void)forgetPasswordWithPhonenum:(NSString *)phonenum
                               YZM:(NSString *)yzm
                          Password:(NSString *)password
                        Repassword:(NSString *)repassword
                            result:(StateBlock)result
                       errorResult:(ErrorBlock)errorResult;
{
    NSDictionary * parameters = @{@"phone":phonenum,
                                  @"yzm":yzm,
                                  @"passwd":password,
                                  @"repasswd":repassword};
    [self.manager POST:@"nos_getpwd" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * status = responseObject[@"status"];
        NSString * info = responseObject[@"info"];
        if([status isEqualToString:@"1"]){
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
    NSDictionary * parameters = @{@"phone":phoneNum,
                                  @"passwd":password,
                                  @"repasswd":repassword,
                                  @"yzm":yzmnum};
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
- (void)LoginWithNumber:(NSString *)phoneNumber
               password:(NSString *)password
                 result:(StateBlock)result
            errorResult:(ErrorBlock)errorResult{
    NSDictionary * parameters = @{@"phone":phoneNumber,@"userpwd":password};
    [self.manager POST:@"nos_login" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * state = responseObject[@"status"];
        NSString * information = responseObject[@"info"];
        if([state isEqualToString:@"1"]){
            NSDictionary * data = responseObject[@"data"];
            UserInfoModel * userinfo = [[UserInfoModel alloc] buildWithDatas:data];
            
            [[Config Instance] saveImgthumb:userinfo.imgthumb
                                      token:userinfo.token
                                   username:userinfo.username
                                      Money:userinfo.money
                                      Ucoin:userinfo.ucoin
                                   Integral:userinfo.integral];
            NSString * isTeacher = data[@"isteacher"];
            if([isTeacher isEqualToString:@"1"]){
                NSString * backimg = data[@"backimg"];
                [[Config Instance] saveBackImg:backimg];
            }
            [[Config Instance] saveIsteacher:isTeacher];
            result(YES,information);
        }else{
            result(NO,information);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        errorResult(error);
    }];
}


/**
 *  发送修改交易密码验证码
 *
 *  @param result 发送信息
 *  @param error  错误信息
 */

- (void)sendTradeYZMWithResult:(StateBlock)result
                   ErrorResult:(ErrorBlock)errorResult
{
    NSDictionary * parameter = @{@"token":KToken};
    [self.manager POST:@"nos_sendexcodeyzm" parameters:parameter success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * status = responseObject[@"status"];
        NSString * info = responseObject[@"info"];
        if([status isEqualToString:@"1"]){
            result(YES,info);
        }else{
            result(NO,info);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        errorResult(error);
    }];
}

/**
 *  修改交易密码
 *
 *  @param excode      原始交易密码
 *  @param newxcode    新的交易密码
 *  @param renewxcode  确认交易密码
 *  @param result      返回修改结果
 *  @param errorResult 错误信息
 */
- (void)ModifyTradePasswordWithExcode:(NSString *)excode
                             NewXcode:(NSString *)newxcode
                           ReNewXcode:(NSString *)renewxcode
                                  Yzm:(NSString *)yzm
                               Result:(StateBlock)result
                          ErrorResult:(ErrorBlock)errorResult
{
    NSDictionary * parameters = @{@"token":KToken,
                                  @"excode":excode,
                                  @"newexcode":newxcode,
                                  @"renewexcode":renewxcode,
                                  @"yzm":yzm};
    [self.manager POST:@"changeexcode" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * status = responseObject[@"status"];
        NSString * info = responseObject[@"info"];
        if([status isEqualToString:@"1"]){
            result(YES,info);
        }else{
            result(NO,info);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        errorResult(error);
    }];
    
}

/**
 *  意见反馈
 *
 *  @param content 反馈内容
 *  @param result  反馈结果
 *  @param error   错误信息
 */
- (void)FeedbackWithContent:(NSString *)content
                     Result:(StateBlock)result
                ErrorResult:(ErrorBlock)errorResult
{
    NSDictionary * parameters = @{@"token":KToken,
                                  @"content":content};
    [self.manager POST:@"feedback" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * status = responseObject[@"status"];
        NSString * info = responseObject[@"info"];
        if([status isEqualToString:@"1"]){
            result(YES,info);
        }else{
            result(NO,info);
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
                NSArray *sortArray = responseObject[@"data"][@"sort"];
                NSArray *sortKindArray = [[SelectModel alloc]buildWithData:sortArray];
                return result(YES,info,@[selectTypeArray,selectLabelArray,sortKindArray]);
            }
        }else{
            return result(NO,info,nil);
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        errorResult(error);
    }];
    
}

#pragma mark -商城
- (void)videoStoreWithToken:(NSString*)token
               typeSelectId:(NSString*)typeSelectId
              labelSelectId:(NSString*)labelSelectId
                       Sort:(NSString *)sort
                       page:(NSString*)page
                    keyWord:(NSString*)keyWord
                     result:(ArrayBlock)result
                errorResult:(ErrorBlock)errorResult{
    NSDictionary *parameters = @{
                                 @"token":token,
                                 @"type":typeSelectId,
                                 @"lable":labelSelectId,
                                 @"sort":sort,
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
        }else{
            return result(NO,info,nil);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        errorResult(error);
    }];
    
}

#pragma mark -讲师店铺
- (void)getTeacherStoreDataWithTeacherId:(NSString*)teacherId
                                page:(NSString*)page
                              result:(ArrayBlock)result
                         errorResult:(ErrorBlock)errorResult{
    
    NSDictionary *parameters = @{
                                 @"tid":teacherId,
                                 @"page":page
                                 };
    [self.manager POST:@"nos_teacherStore" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *status = responseObject[@"status"];
        NSString *info = responseObject[@"info"];
        if ([status isEqualToString:@"1"]) {
            NSDictionary *dic = responseObject[@"data"];
            TeacherStoreHeaderModel *model = [[TeacherStoreHeaderModel alloc]init];
            TeacherStoreHeaderModel *headModel = [model buildWithData:dic];
            StoreDataModel *storeModel = [[StoreDataModel alloc]init];
            NSArray *TeacherStoreArr = [storeModel buildWithData:headModel.videoArray];
            
            return result(YES,info,@[headModel,TeacherStoreArr]);
        }else{
            return result(NO,info,nil);
        }
        
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        errorResult(error);
    }];
    
}


#pragma mark -收藏商品
- (void)collectGoodsWithToken:(NSString*)token
                      goodsId:(NSString*)goodsId
                         type:(NSString*)type
                       result:(StateBlock)result
                  errorResult:(ErrorBlock)errorResult{
    NSDictionary *parameters = @{
                                 @"token":KToken,
                                 @"goods":goodsId,
                                 @"type":type
                                 };
    [self.manager POST:@"addcollect" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * state = responseObject[@"status"];
        NSString * information = responseObject[@"info"];
        

        
        if ([state isEqualToString:@"-1"]) {
           result(NO,@"登录超时");
        }
        
        if([state isEqualToString:@"1"]){
            result(YES,information);
        }else{
            result(NO,information);
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        errorResult(error);
    }];
}

#pragma mark -取消收藏商品
- (void)cancelCollectGoodsWithWithToken:(NSString*)token
                                goodsId:(NSString*)goodsId
                                   type:(NSString*)type
                                 result:(StateBlock)result
                            errorResult:(ErrorBlock)errorResult{
    
    NSDictionary *parameters = @{
                                 @"token":KToken,
                                 @"goods":goodsId,
                                 @"type":type
                                 };
    [self.manager POST:@"re_collect" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
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

#pragma mark -购物车界面
- (void)getShopCarDataWithToken:(NSString*)token
                           page:(NSString*)page
                         result:(ArrayBlock)result
                    errorResult:(ErrorBlock)errorResult{
    
    NSDictionary *parameters = @{
                                 @"token":KToken,
                                 @"page":page
                                 };
    
    [self.manager POST:@"cart" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *state = responseObject[@"status"];
        NSString *info = responseObject[@"info"];
        if ([state isEqualToString:@"-1"]) {
            return result(NO,info,nil);
        }
        if ([state isEqualToString:@"0"]) {
            return result(NO,info,nil);
        }
        if ([state isEqualToString:@"1"]) {
            NSArray *newArray = responseObject[@"data"];
            
            TeacherStoreModel *model = [[TeacherStoreModel alloc]init];
            NSArray *teacherArray = [model buildWithArray:newArray];//老师》区头数组
            
            NSMutableArray *allGoodArray = [NSMutableArray array];
            for (TeacherStoreModel *model in teacherArray) {
                NSArray *goodArr = model.goodsInfo;
                Good *goodModel = [[Good alloc]init];
                NSArray *goodArray = [goodModel buildWithGoodData:goodArr];//每个区对应的商品数组
                [allGoodArray addObject:goodArray];//商品总数组
            }
             return result(YES,info,@[teacherArray,allGoodArray]);
        }else{
            return result(NO,info,nil);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        errorResult(error);
    }];
}

#pragma mark -删除购物车商品
- (void)deleteVideoFromShopCarWithToken:(NSString*)token
                               orderNum:(NSString*)orderNum
                                 result:(StateBlock)result
                            errorResult:(ErrorBlock)errorRusult{
    
    NSDictionary *parameters = @{
                                 @"token":KToken,
                                 @"ordernum":orderNum
                                 };
    [self.manager POST:@"re_cart" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *state = responseObject[@"status"];
        NSString *information = responseObject[@"info"];
        
        if ([state isEqualToString:@"-1"]) {
            result(NO,@"登录超时");
        }
        if([state isEqualToString:@"1"]){
            result(YES,information);
        }else{
            result(NO,information);
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
    
    
}

#pragma mark -加入购物车
- (void)addGoodIntoShopCarWithToken:(NSString*)token
                            goodsId:(NSString*)goodsId
                               type:(NSString*)type
                              money:(NSString*)money
                             result:(StateBlock)result
                        errorResult:(ErrorBlock)errorResult{
    NSDictionary *parameters = @{
                                 @"token":KToken,
                                 @"goodsid":goodsId,
                                 @"type":type,
                                 @"money":money
                                 };
    [self.manager POST:@"addcart" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * state = responseObject[@"status"];
        NSString * information = responseObject[@"info"];
        
        if ([state isEqualToString:@"-1"]) {
            result(NO,@"登录超时");
        }
        
        
        if([state isEqualToString:@"1"]){
            result(YES,information);
        }else{
            result(NO,information);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
         errorResult(error);
    }];
    
    
}
#pragma mark -取消关注讲师
- (void)cancelFocusTeacherWithToken:(NSString*)token
                          teacherId:(NSString*)teacherId
                             result:(StateBlock)result
                        errorResult:(ErrorBlock)errorResult{
    NSDictionary *parameters = @{
                                 @"token":KToken,
                                 @"tid":teacherId
                                 };
    [self.manager POST:@"delAttention" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
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

#pragma mark -关注讲师
- (void)focusTeacherWithToken:(NSString*)token
                    teacherId:(NSString*)teacherId
                       result:(StateBlock)result
                  errorResult:(ErrorBlock)errorResult{
    NSDictionary *parameters = @{
                                 @"token":KToken,
                                 @"tid":teacherId
                                 };
    [self.manager POST:@"addAttention" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
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

#pragma mark -讲师详情
- (void)getTeacherDetailDataWithToken:(NSString*)token
                            teacherId:(NSString*)teacherId
                               result:(ModelBlock)result
                          errorResult:(ErrorBlock)errorResult{
    NSDictionary *parameters = @{
                                 @"token":KToken,
                                 @"tid":teacherId
                                 };
    [self.manager POST:@"teacherinfo" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *state = responseObject[@"status"];
        NSString *info = responseObject[@"info"];
        if ([state isEqualToString:@"1"]) {
            NSDictionary *newDic = responseObject[@"data"];
            TeacherModel *model = [TeacherModel buildWithData:newDic];
         //   TeacherModel *newModel = [model buildWithData:newDic];
            return result(YES,info,model);
        }

    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        errorResult(error);
    }];
    
}

#pragma mark -讲师团队
- (void)getTeacherTeamDataWithToken:(NSString*)token
                               page:(NSString*)page
                             result:(ArrayBlock)result
                        errorResult:(ErrorBlock)errorResult{
    NSDictionary *parameters = @{
                                 @"token":KToken,
                                 @"page":page
                                 };
    [self.manager POST:@"teacherlist" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *status = responseObject[@"status"];
        NSString *info = responseObject[@"info"];
        
        if ([status isEqualToString:@"-1"]) {
          return result(NO,info,nil);
        }
        
        if ([status isEqualToString:@"1"]) {
            if ([responseObject[@"data"][@"teacherlist"]isEqual:[NSNull null]]) {
                return result(YES,info,nil);
           }else{
                NSArray *newArray = responseObject[@"data"][@"teacherlist"];
                
                TeacherTeamModel *model = [[TeacherTeamModel alloc]init];
                NSArray *techerTeamArray = [model buildWithData:newArray];
                return result(YES,info,techerTeamArray);
              //  NSLog(@"+++++++++%lu",(unsigned long)techerTeamArray.count);
            }
        }else{
            return result(NO,info,nil);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
         errorResult(error);
    }];
    
    
}

#pragma mark -博客
#pragma mark -个人中心
- (void)requestCollectionTreasureDataWithParameters:(NSString*)page
                                             result:(ArrayBlock)result
                                        errorResult:(ErrorBlock)errorResult
{
    NSString *token ;
    if (KToken) {
        token = KToken;
    }else{
        token = @"";
    }
    NSDictionary * parameters = @{@"token":token,
                                  @"page":page};
    [self.manager POST:@"allcollect" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
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
            if([status isEqualToString:@"-1"]){
                result(NO,@"-1",nil);
            }else{
            result(NO,status,nil);
            }
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        errorResult(error);
    }];
}

- (void)requestCollectionShopDataWithParameters:(NSString*)page
                                         result:(ArrayBlock)result
                                    errorResult:(ErrorBlock)errorResult
{
    NSDictionary * parameters = @{@"token":KToken,
                                  @"page":page};
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
            if([status isEqualToString:@"-1"]){
                result(NO,@"-1",nil);
            }else{
            result(NO,info,nil);
            }
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        errorResult(error);
    }];
    
}

- (void)requestMyJudgeDataWithParameters:(NSString *)page
                                  result:(ArrayBlock)result
                             errorResult:(ErrorBlock)errorResult
{
    NSDictionary * parameters = @{@"token":KToken,
                                  @"page":page};
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
            if([status isEqualToString:@"-1"]){
                result(NO,@"-1",nil);
            }else{
            result(NO,info,nil);
            }
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        errorResult(error);
    }];
}

- (void)requestWaitpayDataWithParameters:(NSString *)page
                                  result:(ArrayBlock)result
                             errorResult:(ErrorBlock)errorResult
{
    NSString *token ;
    if (KToken) {
        token = KToken;
    }else{
        token = @"";
    }
    NSDictionary * parameters = @{@"token":token,
                                  @"page":page};
    [self.manager POST:@"pendpay" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * status = responseObject[@"status"];
        NSString * info = responseObject[@"info"];
        NSArray * data = responseObject[@"data"];
        
        if([status isEqualToString:@"1"]){
            if([data isEqual:[NSNull null]]){
                result(YES,info,nil);
            }else{
                NSMutableArray * WaitPayModelArray = [[MineWaitPayModel alloc] buildWithData:data];
                result(YES,info,WaitPayModelArray);
            }
        }else{
            if([status isEqualToString:@"-1"]){
                result(NO,@"-1",nil);
            }else{
            result(NO,status,nil);
            }
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        errorResult(error);
    }];
}

- (void)requestWaitjudgeDataWithParameters:(NSString *)page
                                    result:(ArrayBlock)result
                               errorResult:(ErrorBlock)errorResult
{
    NSDictionary * parameters = @{@"page":page,
                                  @"token":KToken};
    [self.manager POST:@"reva" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * status = responseObject[@"status"];
        NSString * info = responseObject[@"info"];
        NSArray * data = responseObject[@"data"];
        if([status isEqualToString:@"1"]){
            if([data isEqual:[NSNull null]]){
                result(YES,info,nil);
            }else{
                NSMutableArray * waitJudgeModelArray = [[MineWaitJudgeModel alloc] buildWithData:data];
                result(YES,info,waitJudgeModelArray);
            }
        }else{
            
            if([status isEqualToString:@"-1"]){
                result(NO,@"-1",nil);
            }else{
                result(NO,status,nil);
            }
        }

    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        errorResult(error);
    }];
    
}

- (void)uploadUserJudgeWithParameters:(NSString*)score
                             OrderNum:(NSString*)ordernum
                            Anonymous:(NSString*)anonymous
                              Content:(NSString*)content
                            Goodstyle:(NSString*)goodstyle
                              Goodsid:(NSString*)goodsid
                               result:(StateBlock)result
                          errorResult:(ErrorBlock)errorResult{
    NSDictionary * parameters = @{@"token":KToken,
                                  @"ordernum":ordernum,
                                  @"score":score,
                                  @"anonymous":anonymous,
                                  @"content":content,
                                  @"goodstype":goodstyle,
                                  @"goodsid":goodsid};
    [self.manager POST:@"replygood" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
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

- (void)GoodsJudgeWithParameters:(NSString *)describe_score
                    Manner_score:(NSString *)manner_score
                   Quality_score:(NSString *)quality_score
                  Rational_score:(NSString *)rational_score
                   Satisfy_score:(NSString *)satisfy_score
                        OrderNum:(NSString *)ordernum
                       Anonymous:(NSString *)anonymous
                         Content:(NSString *)content
                       Goodstype:(NSString *)goodstype
                         Goodsid:(NSString *)goodsid
                          result:(StateBlock)result
                     errorResult:(ErrorBlock)errorResult
{
    NSDictionary * parameters = @{@"describe_score":describe_score,
                                  @"token":KToken,
                                  @"manner_score":manner_score,
                                  @"quality_score":quality_score,
                                  @"rational_score":rational_score,
                                  @"satisfy_score":satisfy_score,
                                  @"ordernum":ordernum,
                                  @"anonymous":anonymous,
                                  @"content":content,
                                  @"goodstype":goodstype,
                                  @"goodsid":goodsid};
    [self.manager POST:@"replygood" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * status = responseObject[@"status"];
        NSString * info = responseObject[@"info"];
        if([status isEqualToString:@"1"]){
            result(YES,info);
        }else{
            result(NO,info);
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        errorResult(error);
    }];
    
}

- (void)PersonalInfoModifyWithParameters:(NSString *)username
                                imgThumb:(NSString *)imgthumb
                                   qqNum:(NSString *)qqnum
                                     Sex:(NSString *)sex
                                emailNum:(NSString *)emailnum
                                  result:(StateBlock)result
                             errorResult:(ErrorBlock)errorResult
{

    NSDictionary * parameters = @{@"token":KToken,
                                  @"username":username,
                                  @"imgthumb":imgthumb,
                                  @"qq":qqnum,
                                  @"sex":sex,
                                  @"email":emailnum};
    [self.manager POST:@"changeinfo" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * status = responseObject[@"status"];
        NSString * info = responseObject[@"info"];
        if([status isEqualToString:@"1"]){
            result(YES,info);
        }else{
            result(NO,info);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        errorResult(error);
        
    }];
}

- (void)PersonalDetailInfoWith:(ModelBlock)result
                   errorResult:(ErrorBlock)errorResult
{
    NSDictionary * parameter = @{@"token":KToken};
    [self.manager POST:@"information" parameters:parameter success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * status = responseObject[@"status"];
        NSString * info = responseObject[@"info"];
        if([status isEqualToString:@"1"]){
            NSDictionary * data= responseObject[@"data"];
            PersonalUserInfo * model = [[PersonalUserInfo alloc] buildWithData:data];
            result(YES,info,model);
        }else{
            result(NO,status,nil);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        errorResult(error);
    }];
}

- (void)RequestTeacherPersonalShopDataWithPage:(NSString *)page
                                        result:(ArrayBlock)result
                                   errorResult:(ErrorBlock)errorResult
{
    NSString *mtoken;
    if (KToken) {
        mtoken = KToken;
    }else{
        mtoken = @"";
    }
    NSDictionary * parameters = @{@"token":mtoken,
                                  @"page":page};
    [self.manager POST:@"teacherStore" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * status = responseObject[@"status"];
        NSString * info = responseObject[@"info"];
        if([status isEqualToString:@"1"]){
            NSDictionary * data= responseObject[@"data"];
            NSString * userid =data[@"userid"];
            NSString * username = data[@"username"];
            NSString * name = data[@"name"];
            NSString * imgthumb = data[@"imgthumb"];
            NSString * backing = data[@"backing"];
            NSNumber * hits = data[@"hits"];
            NSString * hitsStr= [NSString stringWithFormat:@"%ld",hits.integerValue];
            NSNumber * ordermoney = data[@"ordermoney"];
            NSString * ordermoneyStr= [NSString stringWithFormat:@"%ld",ordermoney.integerValue];
            NSNumber * orders = data[@"orders"];
            NSString * orderStr = [NSString stringWithFormat:@"%ld",orders.integerValue];
            NSString * blogId = data[@"blogId"];
            NSString * blogTitle = data[@"blogTitle"];
            TeacherInfo * teacherinfo = [[TeacherInfo alloc] init];
            teacherinfo.userid = userid;
            teacherinfo.username = username;
            teacherinfo.name = name;
            teacherinfo.imgthumb = imgthumb;
            teacherinfo.backimg = backing;
            teacherinfo.hits = hitsStr;
            teacherinfo.ordermoney = ordermoneyStr;
            teacherinfo.orders = orderStr;
            teacherinfo.blogId = blogId;
            teacherinfo.blogTitle = blogTitle;
            NSArray * videodata = data[@"video"];
           NSMutableArray * array1 = [[TeacherShopModel alloc] buildWithData:videodata];
            result(YES,info,@[teacherinfo,array1]);
            
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}

- (void)RequestManageTreasureDataWithPage:(NSString *)page
                                   result:(ArrayBlock)result
                              errorResult:(ErrorBlock)errorResult
{
    NSDictionary * parameters = @{@"token":KToken,
                                  @"page":page};
    [self.manager POST:@"videoManage" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * status = responseObject[@"status"];
        NSString * info = responseObject[@"info"];
        if([status isEqualToString:@"1"]){
        NSDictionary * data= responseObject[@"data"];
        NSArray * video = data[@"video"];
        NSMutableArray * videoData = [[ManageTreasureModel alloc] buildWithData:video];
        result(YES,info,videoData);
        }else{
            result(NO,info,nil);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        errorResult(error);
    }];
}

- (void)EditTreasureWithTreausreId:(NSString *)treasureid
                              Name:(NSString *)name
                             About:(NSString *)about
                             Price:(NSString *)price
                          ThumbImg:(NSString *)thumbimg
                            result:(StateBlock)result
                       errorResult:(ErrorBlock)errorResult
{
    NSDictionary * parameters = @{@"token":KToken,
                                  @"id":treasureid,
                                  @"name":name,
                                  @"about":about,
                                  @"price":price,
                                  @"thumbimg":thumbimg};
    
[self.manager POST:@"teacherEditVideo" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
    NSString * status = responseObject[@"status"];
    NSString * info = responseObject[@"info"];
    if([status isEqualToString:@"1"]){
        result(YES,info);
    }else{
        if([status isEqualToString:@"-1"]){
            result(NO,status);
        }else{
        result(NO,info);
        }
    }
} failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
    errorResult(error);
}];
    
}

- (void)DeleteTreasureWithTreasureid:(NSString *)treasureid
                              result:(StateBlock)result
                         errorResult:(ErrorBlock)errorResult
{
    NSDictionary * parameters = @{@"token":KToken,
                                  @"id":treasureid};
    [self.manager POST:@"teacherDelVideo" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * status = responseObject[@"status"];
        NSString * info = responseObject[@"info"];
        if([status isEqualToString:@"1"]){
            result(YES,info);
        }else{
            if([status isEqualToString:@"-1"]){
                result(NO,status);
            }else{
            result(NO,info);
            }
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        errorResult(error);
    }];
}

- (void)requestOrderManageRequestWithResult:(ArrayBlock)result
                                errorResult:(ErrorBlock)errorResult
{
    NSDictionary * parameter = @{@"token":KToken};
    [self.manager POST:@"teacherOrderManage" parameters:parameter success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * status = responseObject[@"status"];
        NSString * info = responseObject[@"info"];
        if([status isEqualToString:@"1"]){
            NSArray * data = responseObject[@"data"];
            NSMutableArray * array = [[OrderManageModel alloc] buildWithData:data];
            result(YES,info,array);
        }else{
            if([status isEqualToString:@"-1"]){
                result(NO,status,nil);
            }else{
            result(NO,info,nil);
            }
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        errorResult(error);
    }];
}

- (void)requestAllOrderDataWithParameters:(NSString *)page
                                   result:(ArrayBlock)result
                              errorResult:(ErrorBlock)errorResult
{
    NSDictionary * parameters = @{@"token":KToken,
                                  @"page":page};
    [self.manager POST:@"ordermanage" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * status = responseObject[@"status"];
        NSString * info = responseObject[@"info"];
        NSArray * data = responseObject[@"data"];
        if([status isEqualToString:@"1"]){
            if([data isEqual:[NSNull null]]){
                result(YES,info,nil);
            }else{
                NSMutableArray * allorderArray = [[AllOderModel alloc] buildWithData:data];
                result(YES,info,allorderArray);
            }
        }else{
            if([status isEqualToString:@"-1"]){
                result(NO,@"-1",nil);
            }else{
                result(NO,status,nil);
            }
        }

    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        errorResult(error);
    }];
}


- (void)cancelOrderWithOrdernum:(NSString *)ordernum
                         result:(StateBlock)result
                    errorResult:(ErrorBlock)errorResult
{
    NSDictionary * parameters = @{@"token":KToken,
                                  @"ordernum":ordernum};
[self.manager POST:@"reorder" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
    NSString * status = responseObject[@"status"];
    NSString * info = responseObject[@"info"];
    if([status isEqualToString:@"1"]){
        result(YES,info);
    }else{
        if([status isEqualToString:@"-1"]){
            result(NO,status);
        }else{
        result(NO,info);
        }
    }
} failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
    errorResult(error);
}];
    
}

- (void)LoginOutWithResult:(StateBlock)result
               errorResult:(ErrorBlock)errorResult
{
    NSDictionary * parameter = @{@"token":KToken};
    [self.manager POST:@"userexit" parameters:parameter success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * status = responseObject[@"status"];
        NSString * info = responseObject[@"info"];
        if([status isEqualToString:@"1"]){
            result(YES,info);
        }else{
            result(NO,status);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        errorResult(error);
    }];
}

- (void)reSetPasswordWithOldPassword:(NSString *)oldPassword
                         newPassword:(NSString *)newPassword
                              Result:(StateBlock)result
                         errorResult:(ErrorBlock)errorResult
{
    NSDictionary * parameters = @{@"token":KToken,
                                  @"oldpassword":oldPassword,
                                  @"newpassword":newPassword};
    [self.manager POST:@"modipassword" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * status = responseObject[@"status"];
        NSString * info = responseObject[@"info"];
        if([status isEqualToString:@"1"]){
            result(YES,@"修改成功");
        }else{
            result(NO,status);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        errorResult(error);
    }];
}

- (void)uploadImage:(NSData *)imageData
             result:(StateBlock)result
        errorResult:(ErrorBlock)errorResult
{
    NSDictionary * parameters = @{@"token":KToken,
                                  @"width":@"153",
                                  @"height":@"86",
                                  @"image":imageData};
    [self.manager POST:@"nos_uploadimage" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * status = responseObject[@"status"];
        if([status isEqualToString:@"1"]){
            NSDictionary * data = responseObject[@"data"];
            NSString * imageUrl = data[@"image"];
            result(YES,imageUrl);
        }else{
            
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        errorResult(error);
    }];
}

- (void)changeMyShopBackImgWithImage:(NSString *)image
                              result:(StateBlock)result
                         errorResult:(ErrorBlock)errorResult
{
    NSDictionary * parameters = @{@"token":KToken,
                                  @"backimg":image};
    [self.manager POST:@"modBackimg" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * status = responseObject[@"status"];
        NSString * info = responseObject[@"info"];
        if([status isEqualToString:@"1"]){
            result(YES,info);
        }else{
            result(NO,info);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        errorResult(error);
    }];
}

- (void)modifyTeacherInfoWithName:(NSString *)name
                            About:(NSString *)about
                           Result:(StateBlock)result
                      ErrorResult:(ErrorBlock)errorResult
{
    NSDictionary * parameters = @{@"token":KToken,
                                  @"name":name,
                                  @"about":about};
    [self.manager POST:@"teacherStoreUpdate" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * status = responseObject[@"status"];
        NSString * info = responseObject[@"info"];
        if([status isEqualToString:@"1"]){
            result(YES,info);
        }else{
            result(NO,info);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        errorResult(error);
    }];
}

- (void)requestTeacherShopInfoWithResult:(ModelBlock)result
                             ErrorResult:(ErrorBlock)errorResult
{
    NSDictionary * parameter = @{@"token":KToken};
    [self.manager POST:@"teacherStoreShow" parameters:parameter success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * status = responseObject[@"status"];
        NSString * info = responseObject[@"info"];
        NSDictionary * data = responseObject[@"data"];
        if([status isEqualToString:@"1"]){
            TeacherShopInfoModel * model = [[TeacherShopInfoModel alloc] buildWithData:data];
            result(YES,info,model);
        }else{
            result(NO,info,nil);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        errorResult(error);
    }];
}

- (void)requestSystemNoticeWithResult:(ArrayBlock)result
                          ErrorResult:(ErrorBlock)errorResult
{
    NSDictionary * parameter = @{@"token":KToken};
    [self.manager POST:@"userSystemSms" parameters:parameter success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * status = responseObject[@"status"];
        NSString * info = responseObject[@"info"];
        NSArray * data= responseObject[@"data"];
        if([status isEqualToString:@"1"]){
            NSMutableArray * array = [[SystemNoticeModel alloc] buildWithData:data];
            result(YES,info,array);
        }else{
            result(NO,info,nil);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        errorResult(error);
    }];
}

- (void)requestOrderNoticeWithResult:(ArrayBlock)result
                         ErrorResult:(ErrorBlock)errorResult
{
    NSDictionary * parameter = @{@"token":KToken};
    [self.manager POST:@"userOrderSms" parameters:parameter success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * status = responseObject[@"status"];
        NSString * info = responseObject[@"info"];
        NSArray * data = responseObject[@"data"];
        if([status isEqualToString:@"1"]){
            NSMutableArray * array = [[OrderNoticeModel alloc] buildWithData:data];
            result(YES,info,array);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}

- (void)getOrderNumWithGoodsid:(NSString *)goodsid
                         Money:(NSString *)money
                        Result:(StateBlock)result ErrorResult:(ErrorBlock)errorResult
{
    NSDictionary * parameters = @{@"token":KToken,
                                  @"goodsid":goodsid,
                                  @"money":money};
    [self.manager POST:@"readyorder" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * status = responseObject[@"status"];
        if([status isEqualToString:@"1"]){
            NSDictionary * data = responseObject[@"data"];
            NSString * ordernum = data[@"ordernum"];
            result(YES,ordernum);
        }else{
            result(NO,status);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        errorResult(error);
    }];
}

- (void)payOrderWithOrderNum:(NSString *)ordernum
                      Excode:(NSString *)excode
                      Result:(StateBlock)result
                 ErrorResult:(ErrorBlock)errorResult
{
    NSDictionary *parameters = @{
                                 @"token":KToken,
                                 @"ordernum":ordernum,
                                 @"excode":excode
                                 };
    [self.manager POST:@"orderPay" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * status = responseObject[@"status"];
        NSString * info = responseObject[@"info"];
        if([status isEqualToString:@"1"]){
            result(YES,info);
        }else{
            if([status isEqualToString:@"-1"]){
                result(NO,status);
            }else{
            result(NO,info);
            }
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        errorResult(error);
    }];
    
}

- (void)getOrderFlowDataWithIdentify:(NSString *)identify
                                Page:(NSString *)page
                              Result:(ArrayBlock)result
                         ErrorResult:(ErrorBlock)errorResult
{
    NSDictionary * parameters = @{@"token":KToken,
                                  @"identify":identify,
                                  @"page":page};
    [self.manager POST:@"teacherOrderManage" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * status = responseObject[@"status"];
        NSString * info = responseObject[@"info"];
        NSArray * data = responseObject[@"data"];
        if([status isEqualToString:@"1"]){
            NSMutableArray * array = [[OrderManageModel alloc] buildWithData:data];
            result(YES,info,array);
        }else{
            if([status isEqualToString:@"-1"]){
                result(NO,status,nil);
            }else{
            result(NO,info,nil);
            }
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        errorResult(error);
    }];
}

- (void)getOrderFlowWaitPayDataWithPage:(NSString *)page
                                 Result:(ArrayBlock)result
                              ErrorResult:(ErrorBlock)errorResult
{
    NSDictionary * parameters = @{@"token":KToken,
                                  @"page":page,
                                  @"identify":@"2"};
    [self.manager POST:@"teacherOrderManage" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * status = responseObject[@"status"];
        NSString * info = responseObject[@"info"];
        NSArray * data = responseObject[@"data"];
        if([status isEqualToString:@"1"]){
            NSMutableArray * array = [[OrderManageModel alloc] buildWithData:data];
            result(YES,info,array);
        }else{
            if([status isEqualToString:@"-1"]){
                result(NO,status,nil);
            }else{
            result(NO,info,nil);
            }
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        errorResult(error);
    }];
    
}

- (void)convertUcoinWithUcoin:(NSString *)ucoin
                       Result:(StateBlock)result
                  ErrorResult:(ErrorBlock)errorResult
{
    NSDictionary * parameters = @{@"token":KToken,
                                  @"ucoin":ucoin};
    [self.manager POST:@"ucoin_scale" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * status = responseObject[@"status"];
        NSString * info = responseObject[@"info"];
        if([status isEqualToString:@"1"]){
            result(YES,info);
        }else{
            if([status isEqualToString:@"-1"]){
                result(NO,status);
            }else{
                result(NO,info);
            }
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}

- (void)payVideoOrderWithOrderNum:(NSString *)ordernum Excode:(NSString *)excode Result:(StateBlock)result ErrorResult:(ErrorBlock)errorResult
{
    NSDictionary *parameters = @{
                                 @"token":KToken,
                                 @"ordernum":ordernum,
                                 @"excode":excode
                                 };
    [self.manager POST:@"orderPay" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * status = responseObject[@"status"];
        NSString * info = responseObject[@"info"];
        if([status isEqualToString:@"1"]){
            result(YES,info);
        }else{
            result(NO,info);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        errorResult(error);
    }];
    

}

@end
