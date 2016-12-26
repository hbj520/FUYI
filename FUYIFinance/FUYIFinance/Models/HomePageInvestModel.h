//
//  HomePageInvestModel.h
//  FUYIFinance
//
//  Created by youyou on 16/7/6.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomePageInvestModel : NSObject
@property (nonatomic,copy) NSString *investId;
@property (nonatomic,copy) NSString *investName;
@property (nonatomic,copy) NSString *investImage;
@property (nonatomic,copy) NSString * investWebsite;
/**
 *  首页投资模块
 *
 *  @param investId    投资项目id
 *  @param investName  投资名称
 *  @param investImage 投资图片
 *
 *  @return
 */
- (id)initWithParameters:(NSString *)investId
              investName:(NSString *)investName
             investImage:(NSString *)investImage
           investWebsite:(NSString *)investWebsite;
- (NSArray *)buildWithData:(NSArray *)data;
@end
