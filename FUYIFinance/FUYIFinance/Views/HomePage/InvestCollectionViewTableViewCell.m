//
//  InvestCollectionViewTableViewCell.m
//  FUYIFinance
//
//  Created by youyou on 16/6/23.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "InvestCollectionViewTableViewCell.h"
#import "InversetScrollView.h"

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
    InversetScrollView *inverstScrollView = [[InversetScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 206)];
    [inverstScrollView setUIWithData:modelArray];
    NSInteger count = modelArray.count/5 + 1;
    inverstScrollView.contentSize = CGSizeMake(count*ScreenWidth, 206);
    [self addSubview:inverstScrollView];
    inverstScrollView.showsVerticalScrollIndicator = NO;
    inverstScrollView.showsHorizontalScrollIndicator = NO;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
