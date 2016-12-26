//
//  HomepageBannerModel.m
//  FUYIFinance
//
//  Created by youyou on 16/7/6.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "HomepageBannerModel.h"

@implementation HomepageBannerModel
- (id)initWithBannerLink:(NSString *)bannerLink
            bannerImgUrl:(NSString *)imgUrl{
    HomepageBannerModel *bannerModel = [[HomepageBannerModel alloc] init];
    bannerModel.bannerLink = bannerLink;
    bannerModel.bannerImgurl = imgUrl;
    return bannerModel;
}
- (NSArray *)buildWithData:(NSArray *)data{
    NSMutableArray *modelArray = [NSMutableArray array];
    for (NSDictionary *dic in data) {
        NSString *link = dic[@"link"];
        NSString *imgUrl = dic[@"imgthumb"];
        HomepageBannerModel *model = [[HomepageBannerModel alloc]
                                      initWithBannerLink:link
                                            bannerImgUrl:imgUrl];
        [modelArray addObject:model];
    }
    return modelArray;
}
@end
