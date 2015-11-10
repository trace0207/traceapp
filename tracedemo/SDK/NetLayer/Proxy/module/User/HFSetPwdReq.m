//
//  HFSetPwdReq.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/6/17.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFSetPwdReq.h"

@implementation HFSetPwdReq

- (NSString *)reqUrl
{
    return @"CloudHealth/mobile/common/user/user!resetPassWord.action";
}

- (NSInteger)deviceType
{
    return HIOSTypeIOS;
}

@end
