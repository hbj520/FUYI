//
//  AnimationHelper.h
//  CRM
//
//  Created by Ebadu Mac Mini on 15/7/24.
//  Copyright (c) 2015年 Razi. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol AnimationHelperDelegate<NSObject>
- (void)animationHelperDidStop:(CAAnimation *)anim finished:(BOOL)flag;
@end
@interface AnimationHelper : NSObject

/**
 *  购物车动画
 *
 *  @param image        购物车图片
 *  @param startPiont   动画起始点
 *  @param endPiont     动画结束点
 *  @param controlPiont 画曲线的基准点
 *  @param controller   传入的视图控制器
 */
+ (void)addShopAnimationWithImage:(UIImage *)image
                       startPiont:(CGPoint)startPiont
                         endPiont:(CGPoint)endPiont
                     controlPiont:(CGPoint)controlPiont withController:(id)controller
                        withLayer:(CALayer*)myLayer withKeyPath:(NSString *)keyPath;
@end
