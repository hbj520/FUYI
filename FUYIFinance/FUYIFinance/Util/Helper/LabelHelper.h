//
//  LabelHelper.h
//  FUYIFinance
//
//  Created by 张哲 on 16/7/6.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LabelHelper : NSObject

- (UILabel *)buildAttentionLabelWithNumString:(NSString *)numString regularString:(NSString *)regularString;
- (UILabel *)buildPriceLabelWithString:(NSString*)string;
- (NSMutableAttributedString *)attributedStringWithString:(NSString*)string;
- (NSMutableAttributedString *)attributedFontStringWithString:(NSString*)string firstFont:(NSInteger)firstFont secFont:(NSInteger)secFont thirdFont:(NSInteger)thirdFont;
@end
