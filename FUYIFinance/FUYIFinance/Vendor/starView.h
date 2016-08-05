//
//  starView.h
//  star
//
//  Created by 张哲 on 16/7/29.
//  Copyright © 2016年 张哲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface starView : UIView
- (id)initWithFrame:(CGRect)frame withStarLevel:(float)levels;
- (void)configWithStarLevel:(float)levels;
@end
