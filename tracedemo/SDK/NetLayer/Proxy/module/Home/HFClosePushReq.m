//
//  HFClosePushReq.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/7/8.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFClosePushReq.h"

@implementation HFClosePushReq

-(NSString *)reqUrl
{
    return @"CloudHealth/req/mobile/common/user/user-base-info!doSavePushSwitchByUserID.action";
}

@end
