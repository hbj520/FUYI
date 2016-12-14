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
- (void)configWith{
    [self.rateView configWithSupportCount:36 unSupportCount:96];
}
- (IBAction)supportBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setImage:[UIImage imageNamed:@"zan_on"] forState:UIControlStateNormal];
        [self.unSupportBtn setImage:[UIImage imageNamed:@"zan_down"] forState:UIControlStateNormal];
        self.unSupportBtn.selected = NO;

    }else{
        [sender setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
 
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
}
@end
