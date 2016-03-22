//
//  TKPayProxy.h
//  tracedemo
//
//  Created by cmcc on 16/3/14.
//  Copyright © 2016年 trace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import  "Pingpp.h"
#import "TK_PayArg.H"
#import "TKProxy.h"


typedef void (^payAckBlock)(NSInteger result);

@interface TKPayProxy : NSObject




+(void)aliPay:(NSObject *)charge
    urlScheme:(NSString *)scheme
withCompletion:(PingppCompletion)completionBlock;


/**
 支付
 **/
+(void)pay:(TK_PayArg *)arg withBlick:(payAckBlock)block;

@end
