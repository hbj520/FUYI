//
//  LoveManageTableViewCell.m
//  FUYIFinance
//
//  Created by 张哲 on 16/6/30.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "LoveManageTableViewCell.h"

@implementation LoveManageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.modifyBtn.layer.cornerRadius = 3;
    self.deleteBtn.layer.cornerRadius = 3;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
