//
//  VideoDetailFirstTableViewCell.m
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/7/4.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "VideoDetailFirstTableViewCell.h"
#import "LabelHelper.h"
@implementation VideoDetailFirstTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
  self.detailVideoPriceLab.attributedText = [[LabelHelper alloc] attributedFontStringWithString:@"¥ 39.00"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
