//
//  PersonalWaitPayTableViewCell.m
//  FUYIFinance
//
//  Created by 张哲 on 16/6/28.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "PersonalWaitPayTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "LabelHelper.h"

@implementation PersonalWaitPayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
   // [self addBlock];
    self.cancelBtn.layer.borderColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1].CGColor;
    self.cancelBtn.layer.borderWidth =  0.5;
    self.cancelBtn.layer.cornerRadius = 3;
    self.sureBtn.layer.cornerRadius = 3;
    self.totalPrice.attributedText = [[LabelHelper alloc] attributedStringWithString:@"¥39.00"];
    
   // [self addPriceLabel];
    
  
}

- (void)setModel:(MineWaitPayModel *)model
{
    [self.thumbImage sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"placeimage"]];
    NSString * pricelabel = [NSString stringWithFormat:@"¥ %@",model.price];
    self.price.text = pricelabel;
    self.totalPrice.attributedText = [[LabelHelper alloc] attributedStringWithString:pricelabel];
    self.shopname.text = model.shopname;
    self.titlename.text = model.name;
    NSString * teachernamelabel = [NSString stringWithFormat:@"讲师:%@",model.teacher];
    self.teachername.text = teachernamelabel;
    
    
}

- (void)addBlock{
    [self.cancelBtn addTarget:self action:@selector(SelectAct:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)SelectAct:(id)sender{
    if (self.selectBtnBlock) {
        self.selectBtnBlock(self.indexPath);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
