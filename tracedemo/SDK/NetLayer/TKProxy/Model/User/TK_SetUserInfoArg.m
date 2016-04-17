//
//  TK_SetUserInfoArg.m
//  tracedemo
//
//  Created by cmcc on 16/4/16.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TK_SetUserInfoArg.h"
#import "TKUserCenter.h"

@implementation TK_SetUserInfoArg

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        TKUser *user = [[TKUserCenter instance]getUser];
        _nickName = user.nickName;
        _headerUrl = user.headPortraitUrl;
        _address = user.address;
        _signature = user.signature;
        _sex = user.sex;
#if B_Clent == 1
    _role = 0;
#else
    _role = 1;
#endif
        
    }
    return self;
}

@end
