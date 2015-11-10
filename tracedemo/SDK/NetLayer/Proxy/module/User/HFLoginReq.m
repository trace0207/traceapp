//
//  HFLoginReq.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/6/16.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFLoginReq.h"

@implementation HFLoginReq

-(NSString *)reqUrl
{
    return @"CloudHealth/mobile/common/user/login!userLogin.action";
}

- (NSString *)bdChannelId
{
    return [GlobInfo shareInstance].token;
}

- (long)lastUpdateTime
{
    return [GlobInfo shareInstance].lastUpdateTime;
}

- (int)deviceType
{
    return HIOSTypeIOS;
}

@end
