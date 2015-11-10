//
//  HFMessageSetReq.m
//  GuanHealth
//
//  Created by shi_dongdong on 15/5/22.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFMessageSetReq.h"

@implementation HFMessageSetReq

-(NSString *)reqMothod
{
    return @"POST";
}

-(NSString *)reqUrl
{
    return @"CloudHealth/req/mobile/common/user/user-message!updateMessageToReaded.action";
}
@end
