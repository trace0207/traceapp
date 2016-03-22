//
//  TKPayProxy.m
//  tracedemo
//
//  Created by cmcc on 16/3/14.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TKPayProxy.h"
#import "TK_PayAck.h"


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



/**
 支付
 **/
+(void)pay:(TK_PayArg *)arg withBlick:(payAckBlock)block
{
    
    arg.clientIp = [[HFDeviceInfo shareInstance] getIPAddress:YES];
    
    [[TKProxy proxy].mainProxy tkPay:arg withBolco:^(HF_BaseAck *ack) {
        if(ack.sucess)
        {
//            [weakSelf removeFromSuperview];
//            weakSelf.images = nil;
            [TKPayProxy aliPay: ((TK_PayAck *)ack).data urlScheme:@"QupaiConsumer" withCompletion:^(NSString *result, PingppError *error) {
                block(1);
            }];
            
        }
        else
        {
            block(0);
//            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(showLoadingError) object:nil];
//            [weakSelf showLoadingError];
        }
    } ];}



@end
