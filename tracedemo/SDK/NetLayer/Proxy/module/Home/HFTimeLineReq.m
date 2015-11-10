//
//  HFTimeLineReq.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/7/8.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFTimeLineReq.h"

@implementation HFTimeLineReq
-(NSString *)reqUrl
{
    return @"CloudHealth/req/mobile/common/user/user-timeline!getTimeLineRecord.action";
}
@end
