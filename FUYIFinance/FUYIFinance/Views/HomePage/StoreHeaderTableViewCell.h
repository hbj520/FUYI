//
//  StoreHeaderTableViewCell.h
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/7/22.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreHeaderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *teacherImage;
@property (weak, nonatomic) IBOutlet UILabel *teacherNameLab;
@property (weak, nonatomic) IBOutlet UIImageView *teacherTypeImage;
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
@property (weak, nonatomic) IBOutlet UILabel *collectCountLab;
@property (weak, nonatomic) IBOutlet UIButton *collectStoreBtn;

@end
