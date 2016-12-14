//
//  RateView.m
//  FUYIFinance
//
//  Created by youyou on 16/12/13.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "RateView.h"
#import "HexColor.h"
typedef NS_ENUM(NSInteger,CircleSideType) {
    topSide,
    leftSide,
    bottomSide,
    rightSide
    
};

@implementation RateView
- (id)initWithFrame:(CGRect)frame{
 self =   [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    [self createUI];
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.supportView.backgroundColor = [UIColor colorWithRed:240 green:68 blue:68 alpha:1];
        self.unsupportView.backgroundColor = [UIColor colorWithRed:39 green:113 blue:216 alpha:1];
    }
    return self;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
   
    // Drawing code
}
- (void)createUI{
    if (!self.supportView) {
        self.supportView = [[UIView alloc] init];
        self.unsupportView = [[UIView alloc] init];
    }
    
   
}
- (void)configWithSupportCount:(NSInteger)supportCount
                unSupportCount:(NSInteger)unsupportCount{

    CGFloat totalCount = supportCount + unsupportCount;
    CGFloat supportRate = supportCount/totalCount;
    CGFloat unsupportRate = unsupportCount/totalCount;
    CGFloat supportWith = supportRate*self.bounds.size.width;
    CGFloat supportHeight = self.bounds.size.height;
    CGFloat unsupportWith =  unsupportRate*self.bounds.size.width;
    self.supportView.frame = CGRectMake(0, 0, supportWith, supportHeight);
    self.unsupportView.frame = CGRectMake(supportWith, 0,unsupportWith, supportHeight);
   
    [self.supportView setBackgroundColor: [UIColor colorWithHexString:@"F04441"]];
    self.unsupportView.backgroundColor = [UIColor colorWithHexString:@"2771D8"];
    self.supportView.layer.masksToBounds = YES;
    self.unsupportView.layer.masksToBounds = YES;
    self.opaque = NO;
    UIView *test = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
    test.backgroundColor = [UIColor redColor];
    //self.backgroundColor = [UIColor redColor];
    [self addSubview:self.supportView];
    [self addSubview:self.unsupportView];
    [self roundSide:leftSide WithView:self.supportView];
    [self roundSide:rightSide WithView:self.unsupportView];
   // [self addSubview:test];
}
- (void)roundSide:(CircleSideType)sideType WithView:(UIView *)view{
    UIBezierPath *maskPath;
    if (sideType == leftSide) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerBottomLeft)   cornerRadii:CGSizeMake(2.f, 2.f)];
    }else if (sideType == rightSide){
        maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:(UIRectCornerTopRight|UIRectCornerBottomRight)   cornerRadii:CGSizeMake(2.f, 2.f)];
    }else if (sideType == topSide){
        maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                         byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight)
                                               cornerRadii:CGSizeMake(2.f, 2.f)];
    }else{
        maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                         byRoundingCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight)
                                               cornerRadii:CGSizeMake(2.f, 2.f)];
    }
    
   // CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    // CGContextFillRect(context, rect);
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
    [view.layer setMasksToBounds:YES];
}
@end
