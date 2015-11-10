//
//  HFHabitAlarmClockDeleteReq.m
//  GuanHealth
//
//  Created by shi_dongdong on 15/6/3.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFHabitAlarmClockDeleteReq.h"

@implementation HFHabitAlarmClockDeleteReq

-(NSString *)reqMothod
{
    return @"POST";
}

-(NSString *)reqUrl
{
    return @"CloudHealth/req/mobile/common/habit/habit!delUserHabitAlarmClock.action";
}

@end
