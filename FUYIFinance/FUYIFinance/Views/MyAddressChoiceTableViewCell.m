//
//  MyAddressChoiceTableViewCell.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/13.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MyAddressChoiceTableViewCell.h"

@implementation MyAddressChoiceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.arrow.transform = CGAffineTransformMakeRotation(M_PI);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
