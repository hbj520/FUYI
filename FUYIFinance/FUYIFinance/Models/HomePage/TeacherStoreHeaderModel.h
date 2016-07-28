//
//  TeacherStoreHeaderModel.h
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/7/28.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeacherStoreHeaderModel : NSObject

@property (nonatomic,strong) NSString *teacherName;
@property (nonatomic,strong) NSString *teacherImage;
@property (nonatomic,strong) NSString *storeCollectNum;
@property (nonatomic,strong) NSString *storeImage;
@property (nonatomic,strong) NSString *hotContent;
@property (nonatomic,strong) NSString *hotId;
@property (nonatomic,retain) NSArray *videoArray;

/**
 *  讲师店铺
 *
 *  @param teacherName     讲师姓名
 *  @param teacherImage    讲师头像
 *  @param storeCollectNum 收藏数
 *  @param storeImage      店铺图片
 *  @param hotContent      头条内容
 *  @param hotId           头条Id
 *  @param videoArray      视频数据
 *
 *  @return 
 */
- (id)initWithParameters:(NSString*)teacherName
            teacherImage:(NSString*)teacherImage
         storeCollectNum:(NSString*)storeCollectNum
              storeImage:(NSString*)storeImage
              hotContent:(NSString*)hotContent
                   hotId:(NSString*)hotId
              videoArray:(NSArray*)videoArray;

- (TeacherStoreHeaderModel*)buildWithData:(NSDictionary*)dic;
@end
