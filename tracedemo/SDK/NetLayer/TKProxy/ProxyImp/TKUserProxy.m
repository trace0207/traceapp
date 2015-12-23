//
//  TKUserProxy.m
//  tracedemo
//
//  Created by 罗田佳 on 15/11/20.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKUserProxy.h"
#import "TK_VerifySMSArg.h"
#import "TK_LoginArg.h"
#import "TK_RegisterNewUserArg.h"
#import "TK_RegisterNewUserAck.h"

//TK_LoginArg,TK_RegisterNewUserArg,TK_RegisterNewUserAck;
@implementation TKUserProxy


-(void)login:(NSString *)userName withValue:(NSString *)value  withBlock:(hfAckBlock)block{
    TK_LoginArg * arg = [[TK_LoginArg alloc] init];
    arg.mobile = userName;
    arg.password = value;
    arg.showLoadingStr = @"YES";
    [[HF_HttpClient httpClient]sendRequestForHiifit:arg withBolck:block];
    
}

-(void)getVerifyCode:(NSString *)phoneNumber type:(NSInteger)type whtiBlock:(hfAckBlock)block{
    
    TK_VerifySMSArg * arg = [[TK_VerifySMSArg alloc] init];
    arg.mobile = phoneNumber;
    arg.codeType = type;
    arg.showLoadingStr = @"YES";
    [[HF_HttpClient httpClient]sendRequestForHiifit:arg withBolck:block];
    
}

-(void)registerNewUser:(NSString *) verifyCode
            inviteCode:(NSString *)inviceCode
             userValue:(NSString *)userValue
                mobile:(NSString *)mobile
             whtiBlock:(hfAckBlock)block{
    TK_RegisterNewUserArg * arg = [[TK_RegisterNewUserArg alloc] init];
    arg.mobile = mobile;
    arg.inviteCode = inviceCode;
    arg.sms = verifyCode;
    arg.password = userValue;
    [[HF_HttpClient httpClient]sendRequestForHiifit:arg withBolck:block];
    
}

@end
