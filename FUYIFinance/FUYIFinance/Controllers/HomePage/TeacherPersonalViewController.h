//
//  TeacherPersonalViewController.h
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/7/15.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "BaseViewController.h"

#import "TeacherModel.h"
#import "TeacherTeamModel.h"

@interface TeacherPersonalViewController : BaseViewController
//typedef void (^passBlock) (NSString *);

//@property (nonatomic,copy) passBlock passTypeBlock;

@property (nonatomic,strong) TeacherTeamModel *model;



@end
