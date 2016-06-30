//
//  HeaderView.h
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/6/29.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomBtn.h"
@interface HeaderView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet CustomBtn *selectBtn;
@property (weak, nonatomic) IBOutlet CustomBtn *deleteBtn;
@property (weak, nonatomic) IBOutlet UILabel *videoClassLab;


@end
