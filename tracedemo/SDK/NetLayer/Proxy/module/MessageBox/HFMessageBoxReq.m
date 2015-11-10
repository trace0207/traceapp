//
//  HFMessageBoxReq.m
//  GuanHealth
//
//  Created by shi_dongdong on 15/5/22.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFMessageBoxReq.h"

@implementation HFMessageBoxReq

- (NSString *)reqMothod
{
    return @"POST";
}

-(NSString *)reqUrl
{
    return @"CloudHealth/req/mobile/common/user/user-message!getMessageBoxCount.action";
}

@end
