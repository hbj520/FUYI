//
//  ShopCarTableViewCell.m
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/6/29.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "ShopCarTableViewCell.h"
#import "CustomBtn.h"

@implementation ShopCarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self addBlock];
    
    
}

#pragma mark - privateMethod
- (void)addBlock{
    [self.selectBtn addTarget:self action:@selector(SelectAct:) forControlEvents:UIControlEventTouchUpInside];
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
