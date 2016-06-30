//
//  Good.h
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/6/30.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Good : NSObject


@property (nonatomic,copy) NSString *brandID;
@property (nonatomic,assign) BOOL select;
@property (nonatomic,assign) NSInteger number;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *contenetStr;
@property (nonatomic,retain)UIImage *image;


@end
