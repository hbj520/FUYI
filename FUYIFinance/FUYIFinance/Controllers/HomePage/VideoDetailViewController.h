//
//  VideoDetailViewController.h
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/7/4.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "BaseViewController.h"
@class StoreDataModel;
@interface VideoDetailViewController : BaseViewController
@property (nonatomic,strong) StoreDataModel *model;

@property (weak, nonatomic) IBOutlet UIView *serviceView;
@property (weak, nonatomic) IBOutlet UIView *shopView;
@property (weak, nonatomic) IBOutlet UIView *collectView;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;
@property (weak, nonatomic) IBOutlet UIButton *addShopCarBtn;

@property (weak, nonatomic) IBOutlet UILabel *numLab;


@property (weak, nonatomic) IBOutlet UIButton *shopCarBtn;

@end
