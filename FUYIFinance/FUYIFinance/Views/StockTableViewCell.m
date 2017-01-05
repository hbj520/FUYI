//
//  StockTableViewCell.m
//  FUYIFinance
//
//  Created by youyou on 16/12/12.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "StockTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "starView.h"
#import "ArticleListModel.h"

@interface StockTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *techNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstHotLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondHotLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdHotLabel;
@property (weak, nonatomic) IBOutlet starView *starView;

@end
@implementation StockTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.iconImageView.layer.masksToBounds = YES;
    [self.starView configWithStarLevel:3];
}
- (void)configWithData:(StockRecommendListModel *)model{
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.imgthumb] placeholderImage:[UIImage imageNamed:@"videothumbimage"]];
    [self.starView configWithStarLevel:4];
    self.techNameLabel.text = model.name;
    if (model.articleList.count >0) {
        ArticleListModel *firstModel = model.articleList[0];
        self.firstHotLabel.text = [NSString stringWithFormat:@"%@【%@】%@",firstModel.createtime,firstModel.stock_name,firstModel.analysis_title];
    }else if (model.articleList.count >= 1){
        ArticleListModel *secondModel = model.articleList[1];
        self.secondHotLabel.text = [NSString stringWithFormat:@"%@【%@】%@",secondModel.createtime,secondModel.stock_name,secondModel.analysis_title];
    }else if (model.articleList.count >= 2){
        ArticleListModel *thirdModel = model.articleList[2];
        self.thirdHotLabel.text = [NSString stringWithFormat:@"%@【%@】%@",thirdModel.createtime,thirdModel.stock_name,thirdModel.analysis_title];
    }

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
