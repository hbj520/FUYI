//
//  NoticeListTableViewCell.m
//  FUYIFinance
//
//  Created by 张哲 on 16/8/8.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "NoticeListTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation NoticeListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(SystemNoticeModel *)model
{
    [self.noticeImageView sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageNamed:@"placeimage"]];
    self.titleLabel.text = model.title;
    self.timeLabel.text = model.time;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
