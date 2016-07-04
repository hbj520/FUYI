//
//  InversetScrollView.h
//  FUYIFinance
//
//  Created by youyou on 16/6/23.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^TapInvestBlock) (NSInteger);
@interface InversetScrollView : UIScrollView
- (void)setUIWithData:(NSArray *)data;
@property (nonatomic,copy) TapInvestBlock tapBlock;
@end
