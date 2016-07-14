//
//  ConfirmOrderViewController.h
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/7/5.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "BaseViewController.h"
@class StoreDataModel;
@interface ConfirmOrderViewController : BaseViewController

@property (nonatomic,strong)StoreDataModel *model;

@property (weak, nonatomic) IBOutlet UILabel *allPriceLab;

@end
