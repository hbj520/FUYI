//
//  TeacherTeamModel.m
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/7/18.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "TeacherTeamModel.h"

@implementation TeacherTeamModel


- (id)initWithParameters:(NSString*)teacherName
            teacherImage:(NSString*)teacherImage
          teacherFansNum:(NSString*)teacherFansNum
      teacherDescription:(NSString*)teacherDescription
               teacherId:(NSString*)teacherId
             teacherType:(NSString*)teacherType{
    TeacherTeamModel *model = [[TeacherTeamModel alloc]init];
    model.teacherName = teacherName;
    model.teacherImage = teacherImage;
    model.teacherFansNum = teacherFansNum;
    model.teacherDescription = teacherDescription;
    model.teacherId = teacherId;
    model.teacherType = teacherType;
    return model;
    
    
}

- (NSArray *)buildWithData:(NSArray *)data{
    NSMutableArray *modelArr = [NSMutableArray array];

    for (NSDictionary *dic in data) {
        NSString *teacherName = dic[@"turename"];
        NSString *teacherImage = dic[@"imgthumb"];
        NSNumber *teacherFans = dic[@"concern"];
        NSString *teacherFansNum = [NSString stringWithFormat:@"%ld",teacherFans.integerValue];
        NSString *teacherDescription = dic[@"description"];
        NSString *teacherId = dic[@"userid"];
        NSNumber *type = dic[@"type"];
        NSString *teacherType = [NSString stringWithFormat:@"%ld",type.integerValue];
        
        TeacherTeamModel *model = [[TeacherTeamModel alloc]initWithParameters:   teacherName
                                                                 teacherImage:teacherImage
                                                               teacherFansNum:teacherFansNum
                                                           teacherDescription:teacherDescription
                                                                    teacherId:teacherId
                                                                  teacherType:teacherType];
        [modelArr addObject:model];
    }
    return modelArr;
}


@end
