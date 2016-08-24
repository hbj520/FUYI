//
//  MineGoodsJudgeTableViewController.h
//  FUYIFinance
//
//  Created by 张哲 on 16/8/23.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^DeleteJudgeBlock)(NSIndexPath *);
@interface MineGoodsJudgeTableViewController : UITableViewController
@property (nonatomic,copy) NSString * uid;
@property (nonatomic,copy) NSString * image;
@property (nonatomic,copy) NSString * goodsname;
@property (nonatomic,copy) NSString * teachname;
@property (nonatomic,copy) NSString * goodsprice;
@property (nonatomic,copy) NSString * ustyle;
@property (nonatomic,copy) NSString * ordernum;
@property (nonatomic,assign) NSIndexPath * indexpath;
@property (nonatomic,assign) NSInteger index;
@property (nonatomic,copy) DeleteJudgeBlock deleteblock;
- (void)logOut;

@end
