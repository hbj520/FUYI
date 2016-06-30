//
//  PersonalWaitJudgeTableViewCell.m
//  FUYIFinance
//
//  Created by 张哲 on 16/6/28.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "PersonalWaitJudgeTableViewCell.h"

@implementation PersonalWaitJudgeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.judgeBtn.layer.cornerRadius = 3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
