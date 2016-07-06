//
//  BuyCountTableViewCell.h
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/7/5.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomBtn.h"

@interface BuyCountTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet CustomBtn *minusBtn;
@property (weak, nonatomic) IBOutlet CustomBtn *plusBtn;
@property (weak, nonatomic) IBOutlet UITextField *countText;

@end
