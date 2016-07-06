//
//  SelectModel.h
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/7/6.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SelectModel : NSObject

@property (nonatomic,copy) NSString *selectName;
@property (nonatomic,copy) NSString *selectId;


- (id)initWithParameters:(NSString *)selectId
              selectName:(NSString *)selectName;
- (NSArray *)buildWithData:(NSArray *)data;

@end
