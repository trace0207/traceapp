//
//  HFVerifySMSReq.m
//  GuanHealth
//
//  Created by 栋栋 施 on 15/6/18.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFVerifySMSReq.h"

@implementation HFVerifySMSReq

-(NSString *)reqUrl
{
    return @"CloudHealth/mobile/common/sms/sms-message!verifySMSCode.action";
}

@end
