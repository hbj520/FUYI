//
//  TeacherStoreModel.m
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/7/22.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "TeacherStoreModel.h"

@implementation TeacherStoreModel


- (id)initWithParameters:(NSString*)teacherName
               teacherId:(NSString*)teacherId goodsInfo:(NSArray*)goodsInfo{
    
    TeacherStoreModel *model = [[TeacherStoreModel alloc]init];
    model.teacherName = teacherName;
    model.teacherId = teacherId;
    model.goodsInfo = goodsInfo;
    return model;
}

- (NSArray*)buildWithArray:(NSArray*)data{
    NSMutableArray *teacherArr = [NSMutableArray array];
    for (NSDictionary *dic in data) {
        NSString *teacherName = dic[@"teachername"];
        NSString *teacherId = dic[@"tid"];
        NSArray *goodsInfo = dic[@"goodsinfo"];
        
        TeacherStoreModel *model = [[TeacherStoreModel alloc]initWithParameters:teacherName
                                                                      teacherId:teacherId
                                                                      goodsInfo:goodsInfo];
        [teacherArr addObject:model];
    }
    return teacherArr;
}

@end
