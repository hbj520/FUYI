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

/**
 *  商城商品类型选择
 *
 *  @param selectId   商品类型id
 *  @param selectName 商品类型名称
 *
 *  @return 
 */
- (id)initWithParameters:(NSString *)selectId
              selectName:(NSString *)selectName;
- (NSArray *)buildWithData:(NSArray *)data;

@end
