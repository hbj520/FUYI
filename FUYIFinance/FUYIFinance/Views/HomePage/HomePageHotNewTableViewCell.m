//
//  HomePageHotNewTableViewCell.m
//  FUYIFinance
//
//  Created by youyou on 16/6/23.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "HomePageHotNewTableViewCell.h"
#import "homePageNoticeModel.h"
#import "CLHomeHeader.h"
@interface HomePageHotNewTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *newestNotice;
@property (weak, nonatomic) IBOutlet UILabel *fantasticNotice;
@property (strong, nonatomic)  CLHomeHeader *clhomeheaderView;

@end
@implementation HomePageHotNewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self createUI];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)createUI{
    self.clhomeheaderView =[[CLHomeHeader alloc] initWithFrame:CGRectMake(0, 1,ScreenWidth, 68)];
//    self.clhomeheaderView.newses = @[@[@"",@""],@[@"",@""]];

}
- (void)configWithData:(NSArray *)data{
    if (data.count > 0) {
        self.clhomeheaderView.newses = data;
        __weak HomePageHotNewTableViewCell * weakself = self;
        self.clhomeheaderView.cliclCelllable1 = ^(){
            weakself.block();
        };
        self.clhomeheaderView.cliclCelllable2 = ^(){
            weakself.block();
        };
        [self addSubview:self.clhomeheaderView];
    }
}
@end
