//
//  HomePageHotNewTableViewCell.h
//  FUYIFinance
//
//  Created by youyou on 16/6/23.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^clickaction)();
@interface HomePageHotNewTableViewCell : UITableViewCell
- (void)configWithData:(NSArray *)data;
@property (nonatomic,copy)clickaction block;
@end
