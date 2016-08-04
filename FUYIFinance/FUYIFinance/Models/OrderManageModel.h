//
//  OrderManageModel.h
//  FUYIFinance
//
//  Created by 张哲 on 16/8/4.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderManageModel : NSObject
@property (nonatomic,copy)NSString * orderId;
@property (nonatomic,copy)NSString * ordernum;
@property (nonatomic,copy)NSString * money;
@property (nonatomic,copy)NSString * goodsname;
@property (nonatomic,copy)NSString * goodsimg;
@property (nonatomic,copy)NSString * userid;
@property (nonatomic,copy)NSString * ctime;
@property (nonatomic,copy)NSString * state;
@property (nonatomic,copy)NSString * appcontent;

- (id)initWithOrderId:(NSString *)orderid
             Ordernum:(NSString *)ordernum
                Money:(NSString *)money
            Goodsname:(NSString *)goodsname
             Goodsimg:(NSString *)goodsimg
               Userid:(NSString *)userid
                Ctime:(NSString *)ctime
                State:(NSString *)state
           Appcontent:(NSString *)appcontent;

- (NSMutableArray *)buildWithData:(NSArray *)data;

@end
