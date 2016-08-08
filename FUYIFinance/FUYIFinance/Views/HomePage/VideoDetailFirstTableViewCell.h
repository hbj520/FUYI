//
//  VideoDetailFirstTableViewCell.h
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/7/4.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^CollectionBlock)(id);
@interface VideoDetailFirstTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *videoTitleLab;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UILabel *detailVideoPriceLab;
@property (weak, nonatomic) IBOutlet UILabel *authorLab;
@property (weak, nonatomic) IBOutlet UILabel *saleCountsLab;
@property (weak, nonatomic) IBOutlet UIButton *collectionBtn;

@property (nonatomic,copy) CollectionBlock collectBlock;
@end
