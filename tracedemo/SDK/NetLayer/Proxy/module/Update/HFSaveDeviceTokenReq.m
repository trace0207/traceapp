//
//  HFSaveDeviceTokenReq.m
//  GuanHealth
//
//  Created by 罗田佳 on 15/6/12.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFSaveDeviceTokenReq.h"

@implementation HFSaveDeviceTokenReq

- (NSString *)reqMothod
{
    return @"POST";
}

- (BOOL)showToast
{
    return NO;
}

-(NSString *)reqUrl
{
    return @"CloudHealth/req/mobile/common/user/user-base-info!doSaveBdChannelID.action";
}

@end
