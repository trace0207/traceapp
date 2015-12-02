//
//  TK_RegisterNewUserArg.h
//  tracedemo
//
//  Created by 罗田佳 on 15/11/20.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "HF_BaseArg.h"

@interface TK_RegisterNewUserArg : HF_BaseArg

@property (nonatomic,strong)NSString * mobile;

@property (nonatomic,strong)NSString * password;

@property (nonatomic,strong)NSString * inviteCode;

@property (nonatomic,strong)NSString * sms;

@end
