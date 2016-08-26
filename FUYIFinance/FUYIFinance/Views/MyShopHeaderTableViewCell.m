//
//  MyShopHeaderTableViewCell.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/4.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MyShopHeaderTableViewCell.h"

@implementation MyShopHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headicon.layer.cornerRadius = 26;
    self.headicon.layer.masksToBounds = YES;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(login)];
    [self.teacherName addGestureRecognizer:tap];
}

- (void)login
{
    self.block();
    
}

- (IBAction)treasure:(id)sender {
    self.blocktreasure();
}

- (IBAction)youbi:(id)sender {
    self.blockyoubi();
}

- (IBAction)goalbtn:(id)sender {
    self.blockgoal();
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
