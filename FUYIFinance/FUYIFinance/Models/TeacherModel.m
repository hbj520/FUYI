//
//  TeacherModel.m
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/7/19.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "TeacherModel.h"

@implementation TeacherModel

-(id)initWithParameters:(NSString*)teacherName
                   fans:(NSString*)fans
                   type:(NSString*)type
                 school:(NSString*)school
                address:(NSString*)address
                  title:(NSString*)title{
    TeacherModel *model = [[TeacherModel alloc]init];
    model.teacherName = teacherName;
    model.fans = fans;
    model.type = type;
    model.school = school;
    model.address = address;
    model.title = title;
    return model;
}


+ (TeacherModel*)buildWithData:(NSDictionary*)data{
  //  NSMutableArray *modelArr = [NSMutableArray array];

        NSString *teacherName = data[@"turename"];
        NSNumber *fansNum = data[@"fans"];
        NSString *fans = [NSString stringWithFormat:@"%ld",(long)fansNum.integerValue];
        NSNumber *typeId = data[@"type"];
        NSString *type = [NSString stringWithFormat:@"%ld",(long)typeId.integerValue];
        NSString *school = data[@"school"];
        NSString *address = data[@"address"];
        NSString *title = data[@"title"];
        
        TeacherModel *model = [[TeacherModel alloc]initWithParameters:teacherName
                                                                 fans:fans
                                                                 type:type
                                                               school:school
                                                              address:address
                                                                title:title];
        
    return model;
        
  

}

@end
