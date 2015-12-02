//
//  TK_ModifyUserInfo.h
//  tracedemo
//
//  Created by 罗田佳 on 15/12/2.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "HF_BaseArg.h"

@interface TK_ModifyUserInfo : HF_BaseArg


@property (nonatomic,strong)NSString * userId;

@property (nonatomic,strong)NSString * nickName;

@property (nonatomic,strong)NSString * headerUrl;

@property (nonatomic,strong)NSString * address;

@property (nonatomic,strong)NSString * signature;

@end
