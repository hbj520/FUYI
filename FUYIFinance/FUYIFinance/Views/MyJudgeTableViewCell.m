//
//  MyJudgeTableViewCell.m
//  FUYIFinance
//
//  Created by 张哲 on 16/6/30.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MyJudgeTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation MyJudgeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(MineMyJudgeModel *)model
{
    self.titlename.text = model.name;
    self.defaultjudge.text = model.content;
    [self.thumbimage sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"placeimage"]];
    self.timelabel.text = model.ctime;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
