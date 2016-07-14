//
//  UserInfoModel.h
//  FUYIFinance
//
//  Created by 张哲 on 16/7/14.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject
@property (nonatomic,strong) NSString * username;
@property (nonatomic,strong) NSString * imgthumb;
@property (nonatomic,strong) NSString * token;

- (id)initWithParams:(NSString *)userName
            imgthumb:(NSString *)imgthumb
               token:(NSString *)token;
- (UserInfoModel *)buildWithDatas:(NSDictionary *)datas;
@end
