//
//  ProductJudgeViewController.h
//  FUYIFinance
//
//  Created by 张哲 on 16/7/1.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^DeleteJudgeBlock)(NSIndexPath *);
@interface ProductJudgeViewController : BaseViewController
@property (nonatomic,copy) NSString * uid;
@property (nonatomic,copy) NSString * ustyle;
@property (nonatomic,copy) NSString * ordernum;
@property (nonatomic,assign) NSIndexPath * indexpath;
@property (nonatomic,assign) NSInteger index;
@property (nonatomic,copy) DeleteJudgeBlock deleteblock;
@end
