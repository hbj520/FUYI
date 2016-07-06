//
//  HomepageBannerModel.h
//  FUYIFinance
//
//  Created by youyou on 16/7/6.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomepageBannerModel : NSObject
@property (nonatomic,copy) NSString *bannerLink;
@property (nonatomic,copy) NSString *bannerImgurl;
/**
 *  创建homepagemodel
 *
 *  @param bannerLink 首页滚动视图跳转链接
 *  @param imgUrl     图片url
 */
- (id)initWithBannerLink:(NSString *)bannerLink
              bannerImgUrl:(NSString *)imgUrl;
- (NSArray *)buildWithData:(NSArray *)data;
@end
