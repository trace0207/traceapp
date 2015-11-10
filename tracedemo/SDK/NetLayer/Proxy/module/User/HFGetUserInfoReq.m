//
//  HFGetUserInfoReq.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/7/7.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFGetUserInfoReq.h"

@implementation HFGetUserInfoReq

- (NSString *)reqUrl
{
    return @"CloudHealth/req/mobile/common/user/user-base-info!doGetBaseInfo.action";
}

@end
