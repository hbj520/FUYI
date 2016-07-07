//
//  VideoShopTableViewCell.m
//  FUYIFinance
//
//  Created by youyou on 16/7/5.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "VideoShopTableViewCell.h"

#import "StoreDataModel.h"
@implementation VideoShopTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//
//- (void)configWithData:(NSArray *)data{
//
//        for (StoreDataModel *model in data) {
//            NSLog(@"%@66666666666666",model.videoPrice);
//            self.videoImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",model.videoImage]];
//            self.videoTitle.text = model.videoName;
//            self.teacherName.text = [NSString stringWithFormat:@"讲师： %@",model.teacherName];
//            self.videoPrice.text = [NSString stringWithFormat:@"¥ %@.00",model.videoPrice];
//        }
//   
//}



@end
