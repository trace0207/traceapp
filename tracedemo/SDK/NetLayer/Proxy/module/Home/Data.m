//
//  Data.m
//  GuanHealth
//
//  Created by hermit on 15/4/5.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "Data.h"
#import "NSString+HFStrUtil.h"

@implementation Data
@synthesize content;
- (void)copyFromHabit:(HabitList*)habit
{
    self.habitId = habit.habitId;
    self.finished = habit.finished;
    self.habitName = habit.habitName;
    self.headPortraitUrl = habit.habitIconUrl;
    self.createTimeUTC = [NSDate getUTCWithHour:habit.hour andMinute:habit.minute];
    self.source = GZTimeLineTypeHabitTips;
    self.clockTime = [NSString stringWithFormat:@"%02i:%02i",habit.hour,habit.minute];
}

- (void)transfrom
{
//    DDLogInfo(@"Q%@",content);
//    content = [content.copy URLDecodedForString];
//    DDLogInfo(@"A%@",content);
    content = [NSString URLDecodedForString:content];
//    DDLogInfo(@"B%@",content);
    
}

@end
