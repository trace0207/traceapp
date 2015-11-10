//
//  HFHabitAlarmClockAddReq.m
//  GuanHealth
//
//  Created by shi_dongdong on 15/6/5.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFHabitAlarmClockAddReq.h"

@implementation HFHabitAlarmClockAddReq

-(NSString *)reqMothod
{
    return @"POST";
}

-(NSString *)reqUrl
{
    return @"CloudHealth/req/mobile/common/habit/habit!setUserHabitAlarmClock.action";
}

@end
