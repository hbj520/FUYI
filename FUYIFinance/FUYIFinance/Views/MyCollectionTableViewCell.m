//
//  MyCollectionTableViewCell.m
//  FUYIFinance
//
//  Created by 张哲 on 16/6/29.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MyCollectionTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation MyCollectionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
      
}

- (void)setModel:(MineCollectionTreasureModel *)model
{
    //[self.thumbimage sd_setImageWithURL:[NSURL URLWithString:self.model.image] placeholderImage:[UIImage imageNamed:@""]];
    //self.titlename.text = self.model.name;
    //self.teachername.text = self.model.teacher;
   // self.pricelabel.text = self.model.price;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
