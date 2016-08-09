//
//  NoticeListTableViewCell.h
//  FUYIFinance
//
//  Created by 张哲 on 16/8/8.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SystemNoticeModel.h"
@interface NoticeListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *noticeImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (nonatomic,strong)SystemNoticeModel * model;
@end
