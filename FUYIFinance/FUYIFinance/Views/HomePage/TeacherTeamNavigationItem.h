//
//  TeacherTeamNavigationItem.h
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/7/14.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^BackBlock) ();
typedef void (^NewsBlock) ();
@interface TeacherTeamNavigationItem : UINavigationBar
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *newsBtn;

@property (weak, nonatomic) IBOutlet UILabel *ItemTitleLab;

@property (nonatomic,copy) BackBlock backBlock;
@property (nonatomic,copy) NewsBlock newsBlock;
@end
