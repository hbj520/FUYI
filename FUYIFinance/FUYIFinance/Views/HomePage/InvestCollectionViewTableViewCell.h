//
//  InvestCollectionViewTableViewCell.h
//  FUYIFinance
//
//  Created by youyou on 16/6/23.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^TapInvestCellBlock) (NSInteger);
@interface InvestCollectionViewTableViewCell : UITableViewCell
- (void)createUIWithData:(NSArray *)modelArray;
@property (nonatomic,copy) TapInvestCellBlock tapInvestCellBlock;
@end
