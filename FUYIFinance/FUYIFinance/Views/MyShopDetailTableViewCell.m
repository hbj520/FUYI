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
    self.stateLabel.layer.cornerRadius = 9;
    self.stateLabel.layer.masksToBounds = YES;
    self.stateLabel.layer.borderWidth = 1;
   }

- (void)setModel:(OrderManageModel *)model
{
    [self.thumbimage sd_setImageWithURL:[NSURL URLWithString:model.goodsimg] placeholderImage:[UIImage imageNamed:@"myorderthumbimage"]];
    self.title.text = model.appcontent;
    self.orderNum.text = model.ordernum;
    self.price.text = model.money;
    if([model.state isEqualToString:@"0"]){
        self.stateLabel.text = @"未付款";
        self.stateLabel.textColor = [UIColor redColor];
        self.stateLabel.layer.borderColor = [UIColor redColor].CGColor;
    }else if ([model.state isEqualToString:@"1"]){
        self.stateLabel.text = @"未评价";
        self.stateLabel.textColor = [UIColor orangeColor];
        self.stateLabel.layer.borderColor = [UIColor orangeColor].CGColor;
    }else if ([model.state isEqualToString:@"2"]){
        self.stateLabel.text = @"成功";
        self.stateLabel.textColor = [UIColor greenColor];
        self.stateLabel.layer.borderColor = [UIColor greenColor].CGColor;
        
    }else{
        self.stateLabel.text = @"取消订单";
        self.stateLabel.textColor = [UIColor grayColor];
        self.stateLabel.layer.borderColor = [UIColor grayColor].CGColor;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
