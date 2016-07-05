//
//  VideoInfoTableViewCell.h
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/7/5.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoInfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *videoImage;
@property (weak, nonatomic) IBOutlet UILabel *videoContentLab;
@property (weak, nonatomic) IBOutlet UILabel *videoPriceLab;

@end
