//
//  TKMainProxy.m
//  tracedemo
//
//  Created by 罗田佳 on 15/11/14.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKMainProxy.h"
#import "HF_HttpClient.h"
#import "HF_BaseArg.h"
#import "HF_BaseAck.h"
#import "TK_GetOrdersArg.h"
#import "TK_GetOrdersAck.h"


@implementation TKMainProxy

/**
 *  获取晒单列表
 *
 *  @param type  晒单类型
 *  @param block 回调block
 */
-(void)getShowOrders:(NSInteger) type withBlock:(hfAckBlock)block{
    
    TK_GetOrdersArg * arg = [[TK_GetOrdersArg alloc] init];
    arg.type = type;
    arg.ackClassName = NSStringFromClass([TK_GetOrdersAck class]);
    [[HF_HttpClient httpClient]sendRequestForHiifit:arg withBolck:block];
}

@end
