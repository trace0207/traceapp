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



typedef NS_ENUM(NSInteger ,PayResult)
{
    PaySuccess = 1,
    PrePaying = 11,
    PrePaySuccess = 2,
    PrePayFailed = 3,
    PayFailed = 4,
    PayBigMoneySuccess =5,
    PayCancel = 6,
    PaySelectBack =7,
    PayBigMoneyNotEnough =8,
};

typedef void (^payAckBlock)(PayResult result);

@interface TKPayProxy : NSObject




+(void)aliPay:(NSObject *)charge
    urlScheme:(NSString *)scheme
withCompletion:(PingppCompletion)completionBlock;


/**
 预支付
 **/
+(void)prePay:(TK_PayArg *)arg withBlick:(payAckBlock)block;

/**
 选择支付途径
 **/
+(void)selectPayWay:(NSString *)money
           rewardId:(NSString *)rewardId
           fundType:(NSInteger)type
          withBlock:(payAckBlock)block;

@end
