//
//  PersonalWaitJudgeTableViewCell.h
//  FUYIFinance
//
//  Created by 张哲 on 16/6/28.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomBtn.h"
typedef void (^selectedBtnblock) (NSIndexPath * indexpath);
@interface PersonalWaitJudgeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumbImage;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *teacherName;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;

@property (weak, nonatomic) IBOutlet CustomBtn *judgeBtn;
@property (nonatomic,assign) NSIndexPath * indexpath;
@property (nonatomic,copy) selectedBtnblock block;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end
