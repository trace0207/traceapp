//
//  HFRegisterReq.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/6/17.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFRegisterReq.h"

@implementation HFRegisterReq

-(NSString *)reqUrl
{
    return @"CloudHealth/mobile/common/user/user!register.action";
}

- (NSInteger)deviceType
{
    return HIOSTypeIOS;
}

- (NSInteger)sourceAccountType
{
    return HIUserTypeMobile;
}

- (BOOL)showToast
{
    return YES;
}

@end
