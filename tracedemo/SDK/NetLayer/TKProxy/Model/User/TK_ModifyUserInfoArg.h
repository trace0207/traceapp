//
//  TK_ModifyUserInfoArg.h
//  tracedemo
//
//  Created by cmcc on 16/3/6.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "HF_BaseArg.h"

@interface TK_ModifyUserInfoArg : HF_BaseArg
@property (nonatomic,strong)NSString * userId;
@property (nonatomic,strong)NSString * nickName;
@property (nonatomic,strong)NSString * headerUrl;
@property (nonatomic,strong)NSString * address;
@property (nonatomic,strong)NSString * signature;
@property (nonatomic,assign)NSInteger role;

@end
