//
//  MyShopDetailTableViewCell.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/4.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MyShopDetailTableViewCell.h"
#import "LabelHelper.h"

@implementation MyShopDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    NSMutableAttributedString * attributeString = [[LabelHelper alloc] attributedStringWithString:@"39.00"];
    self.priceLabel.attributedText = attributeString;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
