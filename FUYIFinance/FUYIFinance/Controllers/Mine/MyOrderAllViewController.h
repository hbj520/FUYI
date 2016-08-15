//
//  MyOrderAllViewController.h
//  FUYIFinance
//
//  Created by 张哲 on 16/6/28.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "BaseViewController.h"
#import "ZCTradeView.h"
@interface MyOrderAllViewController : BaseViewController
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)    ZCTradeView * tradeView;
- (void)loadData;
@end
