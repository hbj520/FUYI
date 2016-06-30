//
//  PersonalWaitPayTableViewCell.h
//  FUYIFinance
//
//  Created by 张哲 on 16/6/28.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomBtn.h"
typedef void (^SelectBtnBlock) (NSIndexPath *);
@interface PersonalWaitPayTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumbImage;

@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;

@property (weak, nonatomic) IBOutlet CustomBtn *cancelBtn;

@property (weak, nonatomic) IBOutlet CustomBtn *sureBtn;

@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic,copy) SelectBtnBlock selectBtnBlock;

@end
