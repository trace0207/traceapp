//
//  TK_SetUserInfoArg.h
//  tracedemo
//
//  Created by cmcc on 16/4/16.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "HF_BaseArg.h"

@interface TK_SetUserInfoArg : HF_BaseArg
@property (nonatomic,strong) NSString * nickName;
@property (nonatomic,strong) NSString * headerUrl;
@property (nonatomic,strong) NSString * address;
@property (nonatomic,strong) NSString * signature;
@property (nonatomic,assign) NSInteger sex;
@property (nonatomic,assign) NSInteger role;
@property (nonatomic,strong) NSString * purchaserName;
@end
