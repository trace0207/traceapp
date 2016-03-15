//
//  TKPayProxy.m
//  tracedemo
//
//  Created by cmcc on 16/3/14.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TKPayProxy.h"


@implementation TKPayProxy


-(instancetype)init
{
    [Pingpp setDebugMode:YES];
    self = [super init];
    
    return self;
}



+(void)aliPay:(NSObject *)charge
    urlScheme:(NSString *)scheme
withCompletion:(PingppCompletion)completionBlock

{
    [Pingpp createPayment:charge
             appURLScheme:scheme
           withCompletion:completionBlock];
}

@end
