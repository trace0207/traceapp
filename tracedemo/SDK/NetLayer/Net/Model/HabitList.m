//
//  HabitList.m
//  GuanHealth
//
//  Created by hermit on 15/4/9.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HabitList.h"

@implementation HabitList

- (BOOL)isPastTime
{
    NSInteger currentHour = [NSDate getCurrentHour];
    NSInteger currentMinte = [NSDate getCurrentMinute];
    BOOL flag = NO;
    if (currentHour>_hour) {
        flag = YES;
    }else if (currentHour == _hour){
        if (currentMinte >= _minute) {
            flag = YES;
        }
    }
    return flag;
}

- (BOOL)isToday
{
    NSInteger week = [NSDate getCurrentWeekday:[NSDate date]];
    NSString *index = [self.weeks substringWithRange:NSMakeRange(week-1, 1)];
    NSInteger flag = [index integerValue];
    return flag == 1;
}

@end
