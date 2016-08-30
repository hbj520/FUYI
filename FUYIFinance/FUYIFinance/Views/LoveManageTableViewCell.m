//
//  LoveManageTableViewCell.m
//  FUYIFinance
//
//  Created by 张哲 on 16/6/30.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "LoveManageTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation LoveManageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.modifyBtn.layer.cornerRadius = 3;
    self.deleteBtn.layer.cornerRadius = 3;
    self.modifyBtn.layer.borderWidth = 1;
    self.modifyBtn.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    
}

- (void)setModel:(ManageTreasureModel *)model
{
    NSString * imagethumb = [NSString stringWithFormat:@"http://60.173.235.34:9090/fuyi//%@",model.thumbimg];
    [self.thumbimage sd_setImageWithURL:[NSURL URLWithString:imagethumb] placeholderImage:[UIImage imageNamed:@"myorderthumbimage"]];
    self.titlelabel.text = model.title;
    self.pricelabel.text = [NSString stringWithFormat:@"%@",model.price];
    self.uploadtime.text = model.time;
    self.sellcount.text = [NSString stringWithFormat:@"已售%@",model.num];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
