//
//  HFGetUserHomeReq.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/7/9.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFGetUserHomeReq.h"

@implementation HFGetUserHomeReq
- (NSString *)reqUrl
{
    return @"CloudHealth/req/mobile/common/homepage/personal-home-page!getHomePageInfo.action";
}
@end
