//
//  OrderNoticeTableViewCell.h
//  FUYIFinance
//
//  Created by 张哲 on 16/8/8.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderNoticeModel.h"
@interface OrderNoticeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *NoticeImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *aboutLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (nonatomic,strong)OrderNoticeModel * model;
@end
