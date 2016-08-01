//
//  MyShopDetailTableViewCell.h
//  FUYIFinance
//
//  Created by 张哲 on 16/7/4.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeacherShopModel.h"

@interface MyShopDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *thumbimage;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *teacherName;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *paycount;
@property (nonatomic,strong) TeacherShopModel * model;
@end
