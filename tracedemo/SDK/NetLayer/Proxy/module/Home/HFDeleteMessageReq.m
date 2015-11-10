//
//  HFDeleteMessageReq.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/7/9.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFDeleteMessageReq.h"

@implementation HFDeleteMessageReq
-(NSString *)reqUrl
{
    return @"CloudHealth/req/mobile/common/user/user-timeline!deleteTimelineMessage.action";
}
@end
