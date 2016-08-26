//
//  OrderManageModel.m
//  FUYIFinance
//
//  Created by 张哲 on 16/8/4.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "OrderManageModel.h"

@implementation OrderManageModel

- (id)initWithOrderId:(NSString *)orderid
             Ordernum:(NSString *)ordernum
                Money:(NSString *)money
            Goodsname:(NSString *)goodsname
             Goodsimg:(NSString *)goodsimg
               Userid:(NSString *)userid
                Ctime:(NSString *)ctime
                State:(NSString *)state
           Appcontent:(NSString *)appcontent
{
    OrderManageModel * model = [[OrderManageModel alloc] init];
    model.orderId = orderid;
    model.ordernum = ordernum;
    model.money = money;
    model.goodsname = goodsname;
    model.goodsimg = goodsimg;
    model.userid = userid;
    model.ctime = ctime;
    model.state = state;
    model.appcontent = appcontent;
    return model;
}

- (NSMutableArray *)buildWithData:(NSArray *)data
{
    NSMutableArray * array = [NSMutableArray array];
    for(NSDictionary * dict in data){
        NSString * orderid = dict[@"id"];
        NSString * ordernum = dict[@"ordernum"];
        NSString * money = dict[@"money"];
        NSString * goodsname = dict[@"goodsname"];
        NSString * goodsimg = dict[@"goodsimg"];
        NSString * userid = dict[@"userid"];
        NSString * ctime = dict[@"ctime"];
        NSString * state = dict[@"state"];
        NSString * app_content = dict[@"app_content"];
        OrderManageModel * model = [[OrderManageModel alloc] initWithOrderId:orderid Ordernum:ordernum  Money:money Goodsname:goodsname Goodsimg:goodsimg Userid:userid Ctime:ctime State:state  Appcontent:app_content];
        [array addObject:model];
    }
    return array;
}

@end
