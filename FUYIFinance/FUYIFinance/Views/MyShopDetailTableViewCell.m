//
//  MyShopDetailTableViewCell.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/4.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MyShopDetailTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "LabelHelper.h"

@implementation MyShopDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
   }

- (void)setModel:(TeacherShopModel *)model
{
    [self.thumbimage sd_setImageWithURL:[NSURL URLWithString:model.thumbimg] placeholderImage:[UIImage imageNamed:@"placeimage"]];
    self.title.text = model.title;
    NSMutableAttributedString * attributeString = [[LabelHelper alloc] attributedStringWithString:model.price];
    self.price.attributedText = attributeString;
    self.teacherName.text = [NSString stringWithFormat:@"讲师：%@",model.teachername];
    self.paycount.text = [NSString stringWithFormat:@"%@人付款",model.num];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
