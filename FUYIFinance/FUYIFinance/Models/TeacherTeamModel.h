//
//  TeacherTeamModel.h
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/7/18.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeacherTeamModel : NSObject

@property (nonatomic,strong) NSString *teacherName;
@property (nonatomic,strong) NSString *teacherImage;
@property (nonatomic,strong) NSString *teacherFansNum;
@property (nonatomic,strong) NSString *teacherDescription;
@property (nonatomic,strong) NSString *teacherId;
@property (nonatomic,strong) NSString *teacherType;

/**
 *  讲师团队列表
 *
 *  @param teacherName        讲师姓名
 *  @param teacherImage       讲师头像
 *  @param teacherFansNum     关注人数
 *  @param teacherDescription 教师描述
 *  @param teacherId          讲师id
 *  @param teacherType        讲师类型
 *
 *  @return 
 */
- (id)initWithParameters:(NSString*)teacherName
              teacherImage:(NSString*)teacherImage
            teacherFansNum:(NSString*)teacherFansNum
        teacherDescription:(NSString*)teacherDescription
                 teacherId:(NSString*)teacherId
               teacherType:(NSString*)teacherType;


- (NSArray *)buildWithData:(NSArray *)data;

@end
