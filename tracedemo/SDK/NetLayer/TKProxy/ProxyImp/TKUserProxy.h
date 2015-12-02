//
//  TKUserProxy.h
//  tracedemo
//
//  Created by 罗田佳 on 15/11/20.
//  Copyright © 2015年 trace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TK_GetVerifyCodeAck.h"
#import "TK_GetVerifyCodeArg.h"
#import "TK_RegisterNewUserAck.h"
#import "TK_RegisterNewUserArg.h"
//#import "TK_LoginAck.h"
#import "TK_LoginArg.h"

@interface TKUserProxy : NSObject

/**
 登录
 **/
-(void)login:(NSString *)userName withValue:(NSString *)value  withBlock:(hfAckBlock)block;

/**
 获取验证码
 **/
-(void)getVerifyCode:(NSString *)phoneNumber whtiBlock:(hfAckBlock)block;


/**
 注册
 **/
-(void)registerNewUser:(NSString *) verifyCode
            inviteCode:(NSString *)inviceCode
             userValue:(NSString *)userValue
             whtiBlock:(hfAckBlock)block;

@end
