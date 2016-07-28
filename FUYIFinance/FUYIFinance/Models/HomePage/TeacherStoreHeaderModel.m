//
//  TeacherStoreHeaderModel.m
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/7/28.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "TeacherStoreHeaderModel.h"
#import "StoreDataModel.h"

@implementation TeacherStoreHeaderModel

- (id)initWithParameters:(NSString*)teacherName
            teacherImage:(NSString*)teacherImage
         storeCollectNum:(NSString*)storeCollectNum
              storeImage:(NSString*)storeImage
              hotContent:(NSString*)hotContent
                   hotId:(NSString*)hotId
              videoArray:(NSArray*)videoArray{
    TeacherStoreHeaderModel *model = [[TeacherStoreHeaderModel alloc]init];
    model.teacherName = teacherName;
    model.teacherImage = teacherImage;
    model.storeCollectNum = storeCollectNum;
    model.storeImage = storeImage;
    model.hotContent = hotContent;
    model.hotId = hotId;
    model.videoArray = videoArray;
    
    
    
    return model;
}

- (TeacherStoreHeaderModel*)buildWithData:(NSDictionary*)dic{
    //NSMutableArray *modelArr = [NSMutableArray array];
    NSString *teacherName = dic[@"username"];
    NSString *teacherImage = dic[@"imgthumb"];
    NSNumber *CollectNum = dic[@"collectnum"];
    NSString *storeCollectNum = [NSString stringWithFormat:@"%ld",(long)CollectNum.integerValue];
    NSString *storeImage = dic[@"backimg"];
    NSString *hotContent = dic[@"blogTitle"];
    NSString *hotId = dic[@"blogId"];
    NSArray *videoArray = dic[@"video"];
    
    TeacherStoreHeaderModel *model = [[TeacherStoreHeaderModel alloc]initWithParameters:teacherName
                                                                           teacherImage:teacherImage
                                                                        storeCollectNum:storeCollectNum
                                                                             storeImage:storeImage
                                                                             hotContent:hotContent
                                                                                  hotId:hotId
                                                                             videoArray:videoArray];
    return model;
    
}




@end
