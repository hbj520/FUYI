//
//  DefaultStoreDataModel.h
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/7/7.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DefaultStoreDataModel : NSObject
@property (nonatomic,copy) NSString *videoId;
@property (nonatomic,copy) NSString *videoName;
@property (nonatomic,copy) NSString *teacherName;
@property (nonatomic,copy) NSString *videoImage;
@property (nonatomic,copy) NSString *videoPrice;
@property (nonatomic,copy) NSString *sellNum;
@property (nonatomic,copy) NSString *videodescription;
@property (nonatomic,copy) NSString *teacherId;
@property (nonatomic,copy) NSString *videoType;

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
               videoType:(NSString *)videoType;
- (NSArray *)buildWithData:(NSArray *)data;
@end
