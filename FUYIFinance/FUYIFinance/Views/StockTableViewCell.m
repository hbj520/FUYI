//
//  StockTableViewCell.m
//  FUYIFinance
//
//  Created by youyou on 16/12/12.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "StockTableViewCell.h"
#import "starView.h"
@interface StockTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *techNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstHotLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondHotLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdHotLabel;
@property (weak, nonatomic) IBOutlet starView *starView;

@end
@implementation StockTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.iconImageView.layer.masksToBounds = YES;
    [self.starView configWithStarLevel:3];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
