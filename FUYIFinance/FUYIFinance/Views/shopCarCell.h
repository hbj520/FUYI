//
//  shopCarCell.h
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/6/28.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface shopCarCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *goodImage;

@property (weak, nonatomic) IBOutlet UILabel *goodPrice;

@property (weak, nonatomic) IBOutlet UILabel *goodCounts;

@property (weak, nonatomic) IBOutlet UILabel *goodContent;

@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;


@end
