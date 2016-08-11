//
//  MyOrderSecondWaitPayViewController.h
//  FUYIFinance
//
//  Created by 张哲 on 16/7/15.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "BaseViewController.h"
#import "ZCTradeView.h"
@interface MyOrderSecondWaitPayViewController : BaseViewController
@property (nonatomic,strong)    ZCTradeView * tradeView;
- (void)loadData;
@end
