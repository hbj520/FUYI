//
//  OrderNoticeTableViewCell.m
//  FUYIFinance
//
//  Created by 张哲 on 16/8/8.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "OrderNoticeTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation OrderNoticeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(OrderNoticeModel *)model
{
    [self.NoticeImageView sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageNamed:@"myorderthumbimage"]];
    self.titleLabel.text = model.title;
    self.aboutLabel.text = model.about;
    self.timeLabel.text = model.time;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
