//
//  HFHabitDeleteReq.m
//  GuanHealth
//
//  Created by shi_dongdong on 15/6/8.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFHabitDeleteReq.h"

@implementation HFHabitDeleteReq
-(NSString *)reqMothod
{
    return @"POST";
}

-(NSString *)reqUrl
{
    return @"CloudHealth/req/mobile/common/habit/sign!deleteUserSign.action";
}

@end
