//
//  HFDeleteHabitReq.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/7/9.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFDeleteHabitReq.h"

@implementation HFDeleteHabitReq
-(NSString *)reqUrl
{
    return @"CloudHealth/req/mobile/common/habit/habit!deleteHabit.action";
}
@end
