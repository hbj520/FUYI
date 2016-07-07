//
//  DefaultStoreDataModel.m
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/7/7.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "DefaultStoreDataModel.h"

@implementation DefaultStoreDataModel

- (id)initWithParameters:(NSString *)videoId
               videoName:(NSString *)videoName
             teacherName:(NSString *)teacherName
              videoImage:(NSString *)videoImage
              videoPrice:(NSString *)videoPrice
                 sellNum:(NSString *)sellNum
        videodescription:(NSString *)videodescription
               teacherId:(NSString *)teacherId
               videoType:(NSString *)videoType{
    DefaultStoreDataModel *model = [[DefaultStoreDataModel alloc]init];
    model.videoId = videoId;
    model.videoName = videoName;
    model.teacherName = teacherName;
    model.videoImage = videoImage;
    model.videoPrice = videoPrice;
    model.sellNum = sellNum;
    model.videodescription = videodescription;
    model.teacherId = teacherId;
    model.videoType = videoType;
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
        NSString *sellNum = dic[@"num"];
        NSString *videodescription = dic[@"about"];
        NSString *teacherId = dic[@"tid"];
        NSString *videoType = dic[@"type"];
        
        DefaultStoreDataModel *model = [[DefaultStoreDataModel alloc]initWithParameters:videoId videoName:videoName teacherName:teacherName videoImage:videoImage videoPrice:videoPrice sellNum:sellNum videodescription:videodescription teacherId:teacherId videoType:videoType];
        [modelArr addObject:model];
    }
    
    return modelArr;
}

@end
