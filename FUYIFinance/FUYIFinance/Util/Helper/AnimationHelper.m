//
//  AnimationHelper.m
//  CRM
//
//  Created by Ebadu Mac Mini on 15/7/24.
//  Copyright (c) 2015年 Razi. All rights reserved.
//

#import "AnimationHelper.h"
UIBezierPath *path;
CALayer *layer;
NSString *keyPath;
@implementation AnimationHelper
+ (void)addShopAnimationWithImage:(UIImage *)image
                       startPiont:(CGPoint)startPiont
                         endPiont:(CGPoint)endPiont
                     controlPiont:(CGPoint)controlPiont withController:(id)controller
                        withLayer:(CALayer *)myLayer
                      withKeyPath:(NSString *)myKeyPath
{
    layer = myLayer;
    keyPath = myKeyPath;
    path = [UIBezierPath bezierPath];
    [path moveToPoint:startPiont];
    /**
     *  画二元曲线，一般和moveToPoint配合使用
     *
     *  @param endPoint     曲线的终点 - 购物车按钮的坐标
     *  @param controlPoint 画曲线的基准点
     */
    [path addQuadCurveToPoint:endPiont controlPoint:controlPiont];
    
    [self startAnimationWithImage:image withController:controller ];
}
+(void)startAnimationWithImage:(UIImage *)image withController:(id)controller
{
    UIViewController *viewController = (UIViewController *)controller;
        layer.contents = (__bridge id)image.CGImage;
        layer.contentsGravity = kCAGravityResizeAspectFill;
        layer.bounds = CGRectMake(0, 0, 50, 50);
        [layer setCornerRadius:CGRectGetHeight([layer bounds]) / 2];
        layer.masksToBounds = YES;
        layer.position =CGPointMake(50, 150);
        [viewController.navigationController.view.layer addSublayer:layer];
        

    [self groupAnimationWithController:viewController];
}
+(void)groupAnimationWithController:(UIViewController *)controller
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    
    //放大
    CABasicAnimation *expandAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    expandAnimation.duration = 0.1f;
    expandAnimation.fromValue = [NSNumber numberWithFloat:1];
    expandAnimation.toValue = [NSNumber numberWithFloat:2.0f];
    expandAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    //缩小
    CABasicAnimation *narrowAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    narrowAnimation.beginTime = 0.1f;
    narrowAnimation.duration = 0.3f;
    narrowAnimation.fromValue = [NSNumber numberWithFloat:2.0f];
    narrowAnimation.toValue = [NSNumber numberWithFloat:0.5f];
    narrowAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[animation,expandAnimation,narrowAnimation];
    groups.duration = 0.4f;
    groups.removedOnCompletion=NO;
    groups.fillMode=kCAFillModeForwards;
    groups.delegate = controller;
    [layer addAnimation:groups forKey:keyPath];

}

@end
