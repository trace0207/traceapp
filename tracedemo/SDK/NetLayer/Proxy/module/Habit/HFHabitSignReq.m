//
//  HFHabitSignReq.m
//  GuanHealth
//
//  Created by shi_dongdong on 15/6/3.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFHabitSignReq.h"

@implementation HFHabitSignReq

-(NSString *)reqMothod
{
    return @"POST";
}

-(NSString *)reqUrl
{
    return @"CloudHealth/req/mobile/common/habit/sign!signHabit.action";
}

@end
