//
//  StarView.h
//  FUYIFinance
//
//  Created by 张哲 on 16/7/1.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StarView : UIView
- (id)initWithFrame:(CGRect)frame withStarLevel:(float)levels;
- (void)configWithStarLevel:(float)levels;
@end
