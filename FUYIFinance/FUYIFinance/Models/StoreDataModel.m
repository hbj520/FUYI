//
//  StoreDataModel.m
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/7/7.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "StoreDataModel.h"

@implementation StoreDataModel
- (id)initWithParameters:(NSString *)videoId
               videoName:(NSString *)videoName
             teacherName:(NSString *)teacherName
              videoImage:(NSString *)videoImage
              videoPrice:(NSString *)videoPrice
                 sellNum:(NSString *)sellNum
        videodescription:(NSString *)videodescription
               teacherId:(NSString *)teacherId
               videoType:(NSString *)videoType
            videoCollect:(NSString*)videoCollect
                    cart:(NSString*)cart
                videoUrl:(NSString *)videourl
                         {
    StoreDataModel *model = [[StoreDataModel alloc]init];
    model.videoId = videoId;
    model.videoName = videoName;
    model.teacherName = teacherName;
    model.videoImage = videoImage;
    model.videoPrice = videoPrice;
    model.sellNum = sellNum;
    model.videodescription = videodescription;
    model.teacherId = teacherId;
    model.videoType = videoType;
    model.videoCollect = videoCollect;
    model.cart = cart;
    model.videoUrl = videourl;
    return model;
}

- (NSArray *)buildWithData:(NSArray *)data{
    NSMutableArray *modelArr = [NSMutableArray array];
    for (NSDictionary *dic in data) {
        NSString *videoId = dic[@"goodsid"];
        NSString *videoName = dic[@"title"];
        NSString *teacherName = dic[@"teachername"];
        NSString *videoImage = dic[@"thumbimg"];
        NSString *videoPrice = dic[@"price"];
        NSNumber *Num = dic[@"num"];
        NSString *sellNum = [NSString stringWithFormat:@"%ld",Num.integerValue];
        NSString *videodescription = dic[@"about"];
        NSString *teacherId = dic[@"tid"];
        NSNumber *Type = dic[@"type"];
        NSString *videoType = [NSString stringWithFormat:@"%ld",Type.integerValue];
        NSNumber *collect = dic[@"collect"];
        NSString *videoCollect = [NSString stringWithFormat:@"%ld",collect.integerValue];
        NSNumber *videoCart = dic[@"cart"];
        NSString *cart = [NSString stringWithFormat:@"%ld",(long)videoCart.integerValue];
        NSString * videourl = dic[@"videourl"];
        StoreDataModel *model = [[StoreDataModel alloc]initWithParameters:videoId
                                                                videoName:videoName
                                                              teacherName:teacherName
                                                               videoImage:videoImage
                                                               videoPrice:videoPrice
                                                                  sellNum:sellNum
                                                         videodescription:videodescription
                                                                teacherId:teacherId
                                                                videoType:videoType
                                                             videoCollect:videoCollect
                                                                     cart:cart
                                                                 videoUrl:videourl
                                                                ];
        [modelArr addObject:model];
    }
    return modelArr;
}


@end
