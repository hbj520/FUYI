//
//  PersonalWaitJudgeTableViewCell.m
//  FUYIFinance
//
//  Created by 张哲 on 16/6/28.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "PersonalWaitJudgeTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "LabelHelper.h"

@implementation PersonalWaitJudgeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.judgeBtn.layer.cornerRadius = 3;
    self.totalPrice.attributedText = [[LabelHelper alloc] attributedStringWithString:@"¥39.00"];
    [self.judgeBtn addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)selectBtn:(id)sender
{
    if(self.block){
        self.block(self.indexpath);
    }
}

- (void)setModel:(MineWaitJudgeModel *)model
{
    NSString * pricelabel = [NSString stringWithFormat:@"¥%@",model.price];
    self.price.text = pricelabel;
    self.title.text = model.name;
   // self.teacherName.text = model.teacher;
    self.shopname.text = model.shopname;
    self.totalPrice.text = pricelabel;
    [self.thumbImage sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@""]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
