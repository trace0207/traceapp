//
//  TKUserProxy.m
//  tracedemo
//
//  Created by 罗田佳 on 15/11/20.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKUserProxy.h"

@implementation TKUserProxy


-(void)login:(NSString *)userName withValue:(NSString *)value  withBlock:(hfAckBlock)block{
    TK_LoginArg * arg = [[TK_LoginArg alloc] init];
    arg.mobile = userName;
    arg.password = value;
    arg.showLoadingStr = @"YES";
    [[HF_HttpClient httpClient]sendRequestForHiifit:arg withBolck:block];
    
}

-(void)getVerifyCode:(NSString *)phoneNumber whtiBlock:(hfAckBlock)block{
    
    TK_GetVerifyCodeArg * arg = [[TK_GetVerifyCodeArg alloc] init];
    arg.ackClassName = NSStringFromClass([TK_GetVerifyCodeAck class]);
    [[HF_HttpClient httpClient]sendRequestForHiifit:arg withBolck:block];
    
}

-(void)registerNewUser:(NSString *) verifyCode
            inviteCode:(NSString *)inviceCode
             userValue:(NSString *)userValue
             whtiBlock:(hfAckBlock)block{
    TK_RegisterNewUserArg * arg = [[TK_RegisterNewUserArg alloc] init];
    arg.ackClassName = NSStringFromClass([TK_RegisterNewUserAck class]);
    [[HF_HttpClient httpClient]sendRequestForHiifit:arg withBolck:block];
    
}

@end
