//
//  MyShopHeaderTableViewCell.h
//  FUYIFinance
//
//  Created by 张哲 on 16/7/4.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyShopHeaderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headicon;
@property (weak, nonatomic) IBOutlet UILabel *totoalcount;
@property (weak, nonatomic) IBOutlet UILabel *vivstcount;
@property (weak, nonatomic) IBOutlet UILabel *ordercount;
@property (weak, nonatomic) IBOutlet UILabel *teacherName;

@end
