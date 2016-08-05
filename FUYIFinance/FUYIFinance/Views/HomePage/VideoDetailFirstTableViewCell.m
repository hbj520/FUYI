//
//  VideoDetailFirstTableViewCell.m
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/7/4.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "VideoDetailFirstTableViewCell.h"
#import "LabelHelper.h"
@interface VideoDetailFirstTableViewCell ()

@end
@implementation VideoDetailFirstTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self addBtnAct];
    
 // self.detailVideoPriceLab.attributedText = [[LabelHelper alloc] attributedFontStringWithString:@"¥ 39.00"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)addBtnAct{
    [self.collectionBtn setImage:[UIImage imageNamed:@"VD_star"] forState:UIControlStateNormal];
    [self.collectionBtn setImage:[UIImage imageNamed:@"VD_red_Star.jpg"] forState:UIControlStateSelected];
    [self.collectionBtn addTarget:self action:@selector(cellectionAct:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)cellectionAct:(id)sender{
    if (self.collectBlock) {
        self.collectBlock(self.collectionBtn);
    }
}
@end
