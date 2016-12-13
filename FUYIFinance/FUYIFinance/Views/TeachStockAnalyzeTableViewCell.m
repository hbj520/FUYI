//
//  TeachStockAnalyzeTableViewCell.m
//  FUYIFinance
//
//  Created by youyou on 16/12/12.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "TeachStockAnalyzeTableViewCell.h"
#import <Masonry/Masonry.h>
#import "RateView.h"
@interface TeachStockAnalyzeTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *tableViewCellContenView;
@property (weak, nonatomic) IBOutlet UIView *cellBgView;
@property (weak, nonatomic) IBOutlet RateView *rateView;

@end
@implementation TeachStockAnalyzeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.cellBgView.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configWith{
    [self.rateView configWithSupportCount:36 unSupportCount:96];
}
@end
