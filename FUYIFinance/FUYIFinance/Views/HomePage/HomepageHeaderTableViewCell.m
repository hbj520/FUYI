//
//  HomepageHeaderTableViewCell.m
//  ERVICE
//
//  Created by apple on 16/3/15.
//  Copyright © 2016年 hbjApple. All rights reserved.
//

#import "HomepageHeaderTableViewCell.h"

@implementation HomepageHeaderTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self addTapGes];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark -PrivateMethod
- (void)addTapGes{
    UITapGestureRecognizer *tapTeamGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(teamTapAct:)];
    [self.teachTeamTapView addGestureRecognizer:tapTeamGes];
    
    UITapGestureRecognizer *tapVideoGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(videoShopAct:)];
    [self.videoShopTapView addGestureRecognizer:tapVideoGes];
    
    UITapGestureRecognizer *tapBlogGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(blogAct:)];
    [self.blogAreaTapView addGestureRecognizer:tapBlogGes];
    
    UITapGestureRecognizer *tapFinanceGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(financeAct:)];
    [self.financeSchollTapView addGestureRecognizer:tapFinanceGes];
}
- (void)teamTapAct:(UIGestureRecognizer *)ges{
    if (self.teachTeamBlock) {
        self.teachTeamBlock();
    }
}
- (void)videoShopAct:(UIGestureRecognizer *)ges{
    if (self.videoShopBolck) {
        self.videoShopBolck();
    }
}
- (void)blogAct:(UIGestureRecognizer *)ges{
    if (self.blogAreaBlock) {
        self.blogAreaBlock();
    }
}
- (void)financeAct:(UIGestureRecognizer *)ges{
    if (self.financeBlock) {
        self.financeBlock();
    }
}
@end
