//
//  VideoStoreTableViewCell.m
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/7/4.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "VideoStoreTableViewCell.h"

@implementation VideoStoreTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configData{
    self.videoPriceLab.text = @"3jfikjfkdjk";
}

@end
