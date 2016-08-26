//
//  MyShopHeaderTableViewCell.h
//  FUYIFinance
//
//  Created by 张哲 on 16/7/4.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^loginBlock)();
@interface MyShopHeaderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headicon;
@property (weak, nonatomic) IBOutlet UILabel *totoalcount;
@property (weak, nonatomic) IBOutlet UILabel *vivstcount;
@property (weak, nonatomic) IBOutlet UILabel *ordercount;
@property (weak, nonatomic) IBOutlet UILabel *teacherName;
@property (weak, nonatomic) IBOutlet UIImageView *backImg;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIImageView *personlabel;
@property (weak, nonatomic) IBOutlet UIButton *treasurebtn;
@property (weak, nonatomic) IBOutlet UIButton *youbibtn;
@property (weak, nonatomic) IBOutlet UIButton *goalbtn;
@property (nonatomic,copy) loginBlock block;
@property (nonatomic,copy) loginBlock blocktreasure;    //财富
@property (nonatomic,copy) loginBlock blockyoubi;       //优币
@property (nonatomic,copy) loginBlock blockgoal;        //积分
@end
