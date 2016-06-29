      //
//  HomepageHeaderTableViewCell.h
//  ERVICE
//
//  Created by apple on 16/3/15.
//  Copyright © 2016年 hbjApple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ItemBlock)();
@interface HomepageHeaderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *teachTeamTapView;
@property (weak, nonatomic) IBOutlet UIView *blogAreaTapView;
@property (weak, nonatomic) IBOutlet UIView *financeSchollTapView;
@property (weak, nonatomic) IBOutlet UIView *videoShopTapView;
@property (nonatomic,copy) ItemBlock teachTeamBlock;
@property (nonatomic,copy) ItemBlock blogAreaBlock;
@property (nonatomic,copy) ItemBlock financeBlock;
@property (nonatomic,copy) ItemBlock videoShopBolck;
@end
