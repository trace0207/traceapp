//
//  HFPreRegisterReq.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/7/7.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFPreRegisterReq.h"

@implementation HFPreRegisterReq

- (NSString *)reqUrl
{
    return @"CloudHealth/mobile/common/user/user!checkPhoneNumber.action";
}

- (NSInteger)sourceAccountType
{
    return HIUserTypeMobile;
}

@end
