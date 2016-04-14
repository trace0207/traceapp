//
//  TKUserProxy.h
//  tracedemo
//
//  Created by 罗田佳 on 15/11/20.
//  Copyright © 2015年 trace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TK_ModifyUserInfoArg.h"
@class TK_LoginArg,TK_RegisterNewUserArg,TK_RegisterNewUserAck;
@interface TKUserProxy : NSObject

/**
 登录
 **/
-(void)login:(NSString *)userName withValue:(NSString *)value  withBlock:(hfAckBlock)block;

/**
 获取验证码
 **/
-(void)getVerifyCode:(NSString *)phoneNumber type:(NSInteger)type  whtiBlock:(hfAckBlock)block;


/**
 注册
 **/
-(void)registerNewUser:(NSString *) verifyCode
            inviteCode:(NSString *)inviceCode
             userValue:(NSString *)userValue
                mobile:(NSString *)mobile
             whtiBlock:(hfAckBlock)block;

/**
  重置密码
 **/
-(void)resetPassword:(NSString *)mobile
             smsCode:(NSString *)smsCode
            password:(NSString *)newPassword
           withBlock:(hfAckBlock)block;

/**
 查看头像主页
 **/
-(void)getUserHomePage:(NSString *)userId userType:(NSInteger)type withBoloc:(hfAckBlock)block;


@end
