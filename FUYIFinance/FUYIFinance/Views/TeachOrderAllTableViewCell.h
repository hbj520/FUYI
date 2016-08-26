//
//  TeachOrderAllTableViewCell.h
//  FUYIFinance
//
//  Created by 张哲 on 16/8/24.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeachOrderAllTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *thumbImg;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *totalprice;
@property (weak, nonatomic) IBOutlet UILabel *dealtime;
@property (weak, nonatomic) IBOutlet UILabel *teahname;
@property (weak, nonatomic) IBOutlet UILabel *allorwaitpaylabel;

@end
