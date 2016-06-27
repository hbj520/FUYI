//
//  InvestCollectionViewTableViewCell.h
//  FUYIFinance
//
//  Created by youyou on 16/6/23.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvestCollectionViewTableViewCell : UITableViewCell
//@property (nonatomic,strong) NSArray *modelArray;
- (void)createUIWithData:(NSArray *)modelArray;
@end
