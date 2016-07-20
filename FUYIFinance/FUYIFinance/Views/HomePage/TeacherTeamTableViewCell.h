//
//  TeacherTeamTableViewCell.h
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/7/14.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomBtn.h"

//typedef void (^FocuBtnBlock) (UIButton*);
@interface TeacherTeamTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *teacherNameLab;
@property (weak, nonatomic) IBOutlet UILabel *teacherSaying;
@property (weak, nonatomic) IBOutlet UILabel *focusNum;

@property (weak, nonatomic) IBOutlet CustomBtn *focusAndCancelBtn;

//@property (nonatomic,copy) FocuBtnBlock focusBtnBlock;

@end
