//
//  HFHabitIsLatestReq.m
//  GuanHealth
//
//  Created by shi_dongdong on 15/6/8.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFHabitIsLatestReq.h"

@implementation HFHabitIsLatestReq

-(NSString *)reqMothod
{
    return @"POST";
}

-(NSString *)reqUrl
{
    return @"CloudHealth/req/mobile/common/habit/habit-alteration!isUpdateHabitList.action";
}

@end
