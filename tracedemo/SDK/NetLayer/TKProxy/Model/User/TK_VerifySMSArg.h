//
//  TK_VerifySMSArg.h
//  tracedemo
//
//  Created by 罗田佳 on 15/12/7.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "HF_BaseArg.h"

@interface TK_VerifySMSArg : HF_BaseArg

@property(nonatomic,copy)NSString * mobile;
@property(nonatomic)NSInteger codeType; // 0：用户注册短信验证码，1：找回密码短信验证码

@end
