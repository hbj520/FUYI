//
//  MyAddressTextTableViewCell.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/13.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MyAddressTextTableViewCell.h"

@implementation MyAddressTextTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.textView.delegate = self;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.label1.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    self.label1.hidden = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
