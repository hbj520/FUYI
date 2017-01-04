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
@property (weak, nonatomic) IBOutlet UILabel *companyStockTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *supportBtn;
@property (weak, nonatomic) IBOutlet UIButton *unSupportBtn;
@property (weak, nonatomic) IBOutlet UILabel *supportCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *unSupportCountLabel;
@property (strong,nonatomic) StockRecommendListDetailModel *mModel;
- (IBAction)supportBtn:(UIButton *)sender;
- (IBAction)unSupportBtn:(UIButton *)sender;

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
- (void)configWithData:(StockRecommendListDetailModel *)model{
    self.mModel = model;
    [self.rateView configWithSupportCount:model.supportCount.integerValue unSupportCount:model.opposeCount.integerValue];
    self.timeLabel.text = model.createtime;
    self.companyStockTitleLabel.text = model.analysis_title;
    self.supportCountLabel.text = [NSString stringWithFormat:@"支持(%@)",model.supportCount];
    self.unSupportCountLabel.text = [NSString stringWithFormat:@"不支持(%@)",model.opposeCount];
}
- (IBAction)supportBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setImage:[UIImage imageNamed:@"zan_on"] forState:UIControlStateNormal];
        [self.unSupportBtn setImage:[UIImage imageNamed:@"zan_down"] forState:UIControlStateNormal];
        self.unSupportBtn.selected = NO;
//        NSInteger cout = _mModel.supportCount.integerValue;
//        cout++;
//        _mModel.supportCount = [NSString stringWithFormat:@"%ld",cout];

    }else{
        
        [sender setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
//        NSInteger cout = _mModel.supportCount.integerValue;
//        cout--;
//        _mModel.supportCount = [NSString stringWithFormat:@"%ld",cout];
    }
    if (self.clickZanBlock) {
        self.clickZanBlock(sender.selected);
    }
}

- (IBAction)unSupportBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setImage:[UIImage imageNamed:@"zan_down_on"] forState:UIControlStateNormal];
        [self.supportBtn setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
        self.supportBtn.selected = NO;


    }else{
        [sender setImage:[UIImage imageNamed:@"zan_down"] forState:UIControlStateNormal];

    }
    if (self.clickAgainstBlock) {
        self.clickAgainstBlock(sender.selected);
    }
}
@end
