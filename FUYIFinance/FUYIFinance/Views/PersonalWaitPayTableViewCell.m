//
//  PersonalWaitPayTableViewCell.m
//  FUYIFinance
//
//  Created by 张哲 on 16/6/28.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "PersonalWaitPayTableViewCell.h"
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

- (void)addPriceLabel
{
//    self.translateFeeLabel.text = @"(含运费¥0.00)";
//    self.translateFeeLabel.textColor = [UIColor blackColor];
//    self.translateFeeLabel.font = [UIFont systemFontOfSize:11];
//    self.translateFeeLabel.frame = CGRectMake(self.contentView.frame.size.width - 15 - 81, 134, 81, 21);
//    [self.contentView addSubview:self.translateFeeLabel];
    
    
    UILabel * label2 = [[LabelHelper alloc] buildPriceLabelWithString:@"¥39.00"];
    label2.frame = CGRectMake(self.contentView.frame.size.width - 15 - 81 - 10, 134, 50, 21);
    [self.contentView addSubview:label2];
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
