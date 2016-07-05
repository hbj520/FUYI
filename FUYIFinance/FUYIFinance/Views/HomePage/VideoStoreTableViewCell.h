//
//  VideoStoreTableViewCell.h
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/7/4.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoStoreTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *videoPic;
@property (weak, nonatomic) IBOutlet UILabel *videoContentLab;
@property (weak, nonatomic) IBOutlet UILabel *videoAuthorLab;
@property (weak, nonatomic) IBOutlet UILabel *videoPriceLab;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
- (void)configData;
@end
