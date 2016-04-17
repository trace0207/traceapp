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
#import "TK_ModifyPasswordArg.h"
#import "TKUserCenter.h"
#import "TK_GetUserHomePageArg.h"

//TK_LoginArg,TK_RegisterNewUserArg,TK_RegisterNewUserAck;
@implementation TKUserProxy

#if B_Client == 1
#define ROLE 0
#else 
#define ROLE 1
#endif


-(void)login:(NSString *)userName withValue:(NSString *)value  withBlock:(hfAckBlock)block{
    TK_LoginArg * arg = [[TK_LoginArg alloc] init];
    arg.mobile = userName;
    arg.password = value;
    arg.showLoadingStr = @"YES";
    arg.role = ROLE;
    arg.method = @"GET";
    arg.token = [TKUserCenter instance].userNormalVM.token;
    
    
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
    
#if B_Client == 1
    arg.role = 0;
#else
    arg.role = 1;
#endif
 
    arg.mobile = mobile;
    arg.inviteCode = inviceCode;
    arg.smsCode = verifyCode;
    arg.password = userValue;
    arg.token = [TKUserCenter instance].userNormalVM.token;
    [[HF_HttpClient httpClient]sendRequestForHiifit:arg withBolck:block];
    
}


/**
 重置密码
 **/
-(void)resetPassword:(NSString *)mobile
             smsCode:(NSString *)smsCode
            password:(NSString *)newPassword
           withBlock:(hfAckBlock)block
{
    TK_ModifyPasswordArg * arg = [[TK_ModifyPasswordArg alloc] init];
    arg.password = newPassword;
    arg.smsCode = smsCode;
#if B_Client == 1
    arg.role = 0;
#endif
    arg.mobile = mobile;
    [[HF_HttpClient httpClient]sendRequestForHiifit:arg withBolck:block];
}


/**
 查看头像主页
 **/
-(void)getUserHomePage:(NSString *)userId userType:(NSInteger)type withBoloc:(hfAckBlock)block
{
    TK_GetUserHomePageArg * arg = [[TK_GetUserHomePageArg alloc] init];
    arg.userId = userId;
    [[HF_HttpClient httpClient] sendRequestForHiifit:arg withBolck:block];
}

/**
 更新用户信息
 **/
-(void)updateUserInfo:(TK_SetUserInfoArg *)arg withBlock:(hfAckBlock)block;
{
#if B_Client == 1
    arg.role = 0;
#endif
    [[HF_HttpClient httpClient]sendRequestForHiifit:arg withBolck:block];
}




@end
