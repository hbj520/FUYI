//
//  HomePageHotNewTableViewCell.m
//  FUYIFinance
//
//  Created by youyou on 16/6/23.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "HomePageHotNewTableViewCell.h"
#import "homePageNoticeModel.h"
@interface HomePageHotNewTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *newestNotice;
@property (weak, nonatomic) IBOutlet UILabel *fantasticNotice;

@end
@implementation HomePageHotNewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configWithData:(NSArray *)data{
    if (data.count > 0) {
        for (NSInteger i = 0; i < data.count; i++) {
            HomePageNoticeModel *model = [data objectAtIndex:i];
            if (i == 0) {
                self.newestNotice.text = model.noticeTitle;
            }else if (i == 1){
                self.fantasticNotice.text = model.noticeTitle;
            }
        }
    }
}
@end
