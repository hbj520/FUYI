//
//  LabelHelper.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/6.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "LabelHelper.h"

@implementation LabelHelper

- (UILabel *)buildAttentionLabelWithNumString:(NSString *)numString regularString:(NSString *)regularString
{
    NSInteger length = numString.length;
    NSString * contentString = [numString stringByAppendingString:regularString];
    NSInteger contentLength = contentString.length;
    NSMutableAttributedString * attributeString = [[NSMutableAttributedString alloc] initWithString:contentString];
    [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, length)];
    [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:9] range:NSMakeRange(length, contentLength-length)];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 24)];
    label.attributedText = attributeString;
    return label;
}

- (UILabel *)buildPriceLabelWithString:(NSString*)string
{
    NSArray * stringArray = [string componentsSeparatedByString:@"."];
    NSString * numString = stringArray[0];
    NSString * numberString = [numString stringByAppendingString:@"."];
    NSInteger length = numberString.length;
    NSInteger contentlength = string.length;
    NSMutableAttributedString * attributeString = [[NSMutableAttributedString alloc] initWithString:string];
    [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, length)];
    [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:9] range:NSMakeRange(length,contentlength - length)];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 24)];
    label.attributedText = attributeString;
    return label;
    
    
    return nil;
}

- (NSMutableAttributedString *)attributedStringWithString:(NSString*)string
{
    NSArray * stringArray = [string componentsSeparatedByString:@"."];
    NSString * numString = stringArray[0];
    NSString * numberString = [numString stringByAppendingString:@"."];
    NSInteger length = numberString.length;
    NSInteger contentlength = string.length;
    NSMutableAttributedString * attributeString = [[NSMutableAttributedString alloc] initWithString:string];
    [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, length)];
    [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:9] range:NSMakeRange(length,contentlength - length)];
    return attributeString;
}

@end
