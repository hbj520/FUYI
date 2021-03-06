//
//  InvestCollectionViewTableViewCell.m
//  FUYIFinance
//
//  Created by youyou on 16/6/23.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "InvestCollectionViewTableViewCell.h"
#import "InversetScrollView.h"
@interface InvestCollectionViewTableViewCell ()
{
    InversetScrollView *inverstScrollView;
}
@end
@implementation InvestCollectionViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}
#pragma mark - PrivateMethod
- (void)createUIWithData:(NSArray *)modelArray{
    if (inverstScrollView) {
        [inverstScrollView removeFromSuperview];
    }
    inverstScrollView = [[InversetScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 206/375.*ScreenWidth)];
    [inverstScrollView setUIWithData:modelArray];
    NSInteger count = modelArray.count/5 + 1;
    inverstScrollView.contentSize = CGSizeMake(count*ScreenWidth, 206/375.*ScreenWidth);

    [self addSubview:inverstScrollView];
    inverstScrollView.tapBlock = ^(NSInteger index){
        if (self.tapInvestCellBlock) {
            self.tapInvestCellBlock(index);
        }
    };
    inverstScrollView.showsVerticalScrollIndicator = NO;
    inverstScrollView.showsHorizontalScrollIndicator = NO;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
