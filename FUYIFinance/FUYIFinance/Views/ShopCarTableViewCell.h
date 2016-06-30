//
//  ShopCarTableViewCell.h
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/6/29.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomBtn.h"
typedef void (^SelectBtnBlock) (NSIndexPath *);
@interface ShopCarTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *goodImage;
@property (weak, nonatomic) IBOutlet CustomBtn *selectBtn;
@property (weak, nonatomic) IBOutlet UILabel *goodPrice;
@property (weak, nonatomic) IBOutlet UILabel *goodCounts;
@property (weak, nonatomic) IBOutlet UILabel *goodContent;
@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic,copy) SelectBtnBlock selectBtnBlock;
@end
