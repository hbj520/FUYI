//
//  TeacherModel.h
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/7/19.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeacherModel : NSObject

@property (nonatomic,strong) NSString *teacherName;
@property (nonatomic,strong) NSString *fans;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *school;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *title;
/**
 *  讲师详情
 *
 *  @param teacherName 讲师姓名
 *  @param fans        关注人数
 *  @param type        关注类型
 *  @param school      毕业院校
 *  @param address     地址
 *  @param title       文章标题
 *
 *  @return 
 */
-(id)initWithParameters:(NSString*)teacherName
                   fans:(NSString*)fans
                   type:(NSString*)type
                 school:(NSString*)school
                address:(NSString*)address
                  title:(NSString*)title;

+ (TeacherModel*)buildWithData:(NSDictionary*)data;

@end
