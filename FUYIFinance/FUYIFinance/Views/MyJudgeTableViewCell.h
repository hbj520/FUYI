//
//  MyJudgeTableViewCell.h
//  FUYIFinance
//
//  Created by 张哲 on 16/6/30.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyJudgeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *thumbimage;
@property (weak, nonatomic) IBOutlet UILabel *judgelabel;
@property (weak, nonatomic) IBOutlet UILabel *titlename;
@property (weak, nonatomic) IBOutlet UILabel *defaultjudge;
@property (weak, nonatomic) IBOutlet UILabel *timelabel;

@end
