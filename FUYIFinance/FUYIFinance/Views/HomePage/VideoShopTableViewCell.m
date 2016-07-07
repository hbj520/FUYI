//
//  VideoShopTableViewCell.m
//  FUYIFinance
//
//  Created by youyou on 16/7/5.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "VideoShopTableViewCell.h"
#import "DefaultStoreDataModel.h"
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

- (void)configWithData:(NSArray *)data{
    if (data.count > 0) {
        for (NSInteger i = 0; i < data.count; i++) {
            DefaultStoreDataModel *model = [data objectAtIndex:i];
            self.videoImage.image = [UIImage imageNamed:model.videoImage];
            self.videoTitle.text = model.videoName;
            self.teacherName.text = [NSString stringWithFormat:@"讲师： %@",model.teacherName];
            self.videoPrice.text = [NSString stringWithFormat:@"¥ %d.2f",200];
        }
    }
}



@end
