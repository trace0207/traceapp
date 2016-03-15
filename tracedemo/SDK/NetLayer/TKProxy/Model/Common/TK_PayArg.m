//
//  TK_PayArg.m
//  tracedemo
//
//  Created by cmcc on 16/3/15.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TK_PayArg.h"

@implementation TK_PayArg


-(instancetype)init
{
    self = [super init];
    self.payType = 0;//  0 aliPay , 1 weixinPay
    return self;
}

@end
