//
//  StoreDataModel.h
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/7/7.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreDataModel : NSObject
@property (nonatomic,copy) NSString *videoId;
@property (nonatomic,strong) NSString *videoName;
@property (nonatomic,strong) NSString *teacherName;
@property (nonatomic,strong) NSString *videoImage;
@property (nonatomic,strong) NSString *videoPrice;
@property (nonatomic,strong) NSString *sellNum;
@property (nonatomic,strong) NSString *videodescription;
@property (nonatomic,strong) NSString *teacherId;
@property (nonatomic,strong) NSString *videoType;
@property (nonatomic,strong) NSString *videoCollect;
/**
 *  商城列表详情
 *
 *  @param videoId          视频id
 *  @param videoName        视频名称
 *  @param teacherName      讲师名称
 *  @param videoImage       视频图片
 *  @param videoPrice       视频价格
 *  @param sellNum          销售数量
 *  @param videodescription 视频描述
 *  @param teacherId        讲师id
 *  @param videoType        视频类型
 *
 *  @return
 */
- (id)initWithParameters:(NSString *)videoId
               videoName:(NSString *)videoName
             teacherName:(NSString *)teacherName
              videoImage:(NSString *)videoImage
              videoPrice:(NSString *)videoPrice
                 sellNum:(NSString *)sellNum
        videodescription:(NSString *)videodescription
               teacherId:(NSString *)teacherId
               videoType:(NSString *)videoType
            videoCollect:(NSString*)videoCollect;



- (NSArray *)buildWithData:(NSArray *)data;

@end
