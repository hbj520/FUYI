//
//  TeacherTeamTableViewCell.m
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/7/14.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "TeacherTeamTableViewCell.h"

@implementation TeacherTeamTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.focusAndCancelBtn addTarget:self action:@selector(focusClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.focusAndCancelBtn setImage:[UIImage imageNamed:@"TeacherTeam_focus"] forState:UIControlStateNormal];
    [self.focusAndCancelBtn setImage:[UIImage imageNamed:@"TeacherTeam_cancel"] forState:UIControlStateSelected];
    
}
- (void)focusClick:(UIButton*)button{
    if (self.focusBtnBlock) {
        self.focusBtnBlock(button);
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
