//
//  HFCheckVercodeReq.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/7/7.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFCheckVercodeReq.h"

@implementation HFCheckVercodeReq

- (NSString *)reqUrl
{
    return @"CloudHealth/mobile/common/sms/sms-message!verifySMSCode.action";
}

@end
