//
//  PersonalWaitPayTableViewCell.m
//  FUYIFinance
//
//  Created by 张哲 on 16/6/28.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "PersonalWaitPayTableViewCell.h"

@implementation PersonalWaitPayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.cancelBtn.layer.borderColor = [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:170/255.0].CGColor;
    self.cancelBtn.layer.borderWidth =  1;
    self.cancelBtn.layer.cornerRadius = 3;
    
    self.sureBtn.layer.cornerRadius = 3;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
