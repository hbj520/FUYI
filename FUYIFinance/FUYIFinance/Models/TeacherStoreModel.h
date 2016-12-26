//
//  TeacherStoreModel.h
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/7/22.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeacherStoreModel : NSObject
@property (nonatomic,strong) NSString *teacherName;
@property (nonatomic,strong) NSString *teacherId;
@property (nonatomic,strong) NSArray *goodsInfo;

- (id)initWithParameters:(NSString*)teacherName
               teacherId:(NSString*)teacherId
               goodsInfo:(NSArray*)goodsInfo;

- (NSArray*)buildWithArray:(NSArray*)data;
@end
