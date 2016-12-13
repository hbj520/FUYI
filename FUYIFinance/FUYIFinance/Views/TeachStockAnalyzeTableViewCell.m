//
//  TeachStockAnalyzeTableViewCell.m
//  FUYIFinance
//
//  Created by youyou on 16/12/12.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "TeachStockAnalyzeTableViewCell.h"
#import <Masonry/Masonry.h>
@interface TeachStockAnalyzeTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *tableViewCellContenView;

@end
@implementation TeachStockAnalyzeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.tableViewCellContenView.layer.masksToBounds = YES;
    [self addMasonary];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)addMasonary{
    [self addSubview:self.tableViewCellContenView];
    [self.tableViewCellContenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@5);
        make.left.equalTo(@5);
        make.bottom.equalTo(@5);
        make.right.equalTo(@5);
    }];
}
@end
