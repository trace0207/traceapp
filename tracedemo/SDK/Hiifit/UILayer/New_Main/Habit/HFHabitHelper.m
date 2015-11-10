//
//  HFHabitHelper.m
//  GuanHealth
//
//  Created by shi_dongdong on 15/6/1.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFHabitHelper.h"
#import "HFHabitAlarmClockRes.h"

#define kLocalNoti_UserID   @"userID"
#define kLocalNoti_HabitID  @"habitID"
#define kLocalNoti_ClockID  @"clockID"
#define kLocalNoti_Time     @"Time"

@interface HFHabitHelper()
{
    HFHabitAlarmClockRes * mRes;
    
    NSInteger mUserId;
}
@property(nonatomic,strong)HFHabitAlarmClockRes * mRes;
@end

@implementation HFHabitHelper
@synthesize mRes;

SYNTHESIZE_SINGLETON_FOR_CLASS_PROTOTYPE(HFHabitHelper, shareInstance);
- (void)addLocalNoticationWithHour:(NSInteger)hour
                               Min:(NSInteger)min
                           ClockID:(NSInteger)clcokId
                           HabitID:(NSInteger)habitId
                           WeekDay:(WeekDayType)type
                         habitName:(NSString *)habitName
{
    UILocalNotification * localNotication = [[UILocalNotification alloc] init];
    //设置推送时间
    localNotication.fireDate = [self getFireDateForDayOfWeek:type withHour:hour Min:min];
    
    //设置时区
    localNotication.timeZone = [NSTimeZone defaultTimeZone];
    
    //设置重复间隔
    localNotication.repeatInterval = kCFCalendarUnitWeek; //一周提醒一次
    
    //推送声音
    localNotication.soundName = UILocalNotificationDefaultSoundName;
    
    //内容
    localNotication.alertBody = habitName;
    
    //显示在icon上的红色圈中的数子
    localNotication.applicationIconBadgeNumber = 1;
    
    //设置userinfo 方便在之后需要撤销的时候使用
    NSDictionary *infoDic = [NSDictionary dictionaryWithObjectsAndKeys:@(mUserId),kLocalNoti_UserID,@(habitId),kLocalNoti_HabitID,@(clcokId),kLocalNoti_ClockID, nil];
    localNotication.userInfo = infoDic;
    
    //添加推送到uiapplication
    UIApplication *app = [UIApplication sharedApplication];
    [app scheduleLocalNotification:localNotication];
}

//删除某个习惯下地某个通知 如果是直接删除闹钟的画
- (void)deleteLocalNoticationWithhabitID:(NSInteger)habitId clockID:(NSInteger)clockId
{
    NSArray *localArr = [[UIApplication sharedApplication] scheduledLocalNotifications];
    NSLog(@"目前本地推送数组%@",localArr);
    for (int i = 0; i < [localArr count]; i++)
    {
        UILocalNotification * localNoti = [localArr objectAtIndex:i];
        NSDictionary * localNotiDic = localNoti.userInfo;
        if (clockId == -1)
        {
            if (habitId == -1) {
                [[UIApplication sharedApplication] cancelLocalNotification:localNoti];
            }
            else
            {
                NSInteger tmpHabitId = [[localNotiDic objectForKey:kLocalNoti_HabitID] integerValue];
                if (tmpHabitId == habitId)
                {
                    [[UIApplication sharedApplication] cancelLocalNotification:localNoti];
                }
            }
        }
        else
        {
            NSInteger tmpClockId = [[localNotiDic objectForKey:kLocalNoti_ClockID] integerValue];
            if (tmpClockId == clockId)
            {
                [[UIApplication sharedApplication] cancelLocalNotification:localNoti];
            }
        }
    }
}

- (void)deleteLocalNoticationWithClockID:(NSInteger)clockID
{
    [self deleteLocalNoticationWithhabitID:-1 clockID:clockID];
}

//删除某个习惯下所有通知
- (void)deleteLocalNoticationWithHabitID:(NSInteger)habitID
{
    [self deleteLocalNoticationWithhabitID:habitID clockID:-1];
}

//删除某个用户下所有通知
- (void)deleteCurrentUserLocalNotication
{
    [self deleteLocalNoticationWithhabitID:-1 clockID:-1];
}

#pragma mark -
#pragma mark private
//添加获取时间
- (NSDate *) getFireDateForDayOfWeek:(NSInteger)desiredWeekday withHour:(NSInteger)hour  Min:(NSInteger)min // 1:Sunday - 7:Saturday
{
    NSRange weekDateRange = [[NSCalendar currentCalendar] maximumRangeOfUnit:NSCalendarUnitWeekday];
    NSInteger daysInWeek = weekDateRange.length - weekDateRange.location + 1;
    
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:[NSDate date]];
    NSInteger currentWeekday = dateComponents.weekday;
    NSInteger differenceDays = (desiredWeekday - currentWeekday + daysInWeek) % daysInWeek;
    
    NSDateComponents *daysComponents = [[NSDateComponents alloc] init];
    daysComponents.day = differenceDays;
    NSDate *fireDate = [[NSCalendar currentCalendar] dateByAddingComponents:daysComponents toDate:[NSDate date] options:0];
    
    NSDateComponents *fireDateComponents = [[NSCalendar currentCalendar]
                                            components: NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond
                                            fromDate:fireDate];
    
    fireDateComponents.hour = hour;
    fireDateComponents.minute = min;
    fireDateComponents.second = 0;
    
    NSDate *resultDate = [[NSCalendar currentCalendar] dateFromComponents:fireDateComponents];
    
    if(resultDate.timeIntervalSinceNow < 0) {
        resultDate = [resultDate dateByAddingTimeInterval:60 * 60 * 24 * 7];
    }
    
    return resultDate;
}

- (void)creatLocalNoticationList
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    for (int i = 0 ; i < [mRes.data count]; i++) {
        HFHabitAlarmClockData * clockData = [mRes.data objectAtIndex:i];
        for (int i = 0; i < [clockData.clockList count]; i++) {
            HFHabitAlramClockListData * data = [clockData.clockList objectAtIndex:i];
            if (data.status == 1)
            {
                [self addLocalNotiWithData:data habitID:clockData.habitId habitName:clockData.habitName];
            }
        }
    }
}

- (void)addLocalNotiWithData:(HFHabitAlramClockListData *)data habitID:(NSInteger)habitId habitName:(NSString *)habitName
{
   // NSLog(@"123%ld",data.clockId);
    
    for (int i = 0 ; i < [data.weeks length]; i++) {
       NSInteger flag = [[data.weeks substringWithRange:NSMakeRange(i, 1)] integerValue];
        if (flag == 1)
        {
            WeekDayType type = i == 6 ? 1 : i + 2;
            [self addLocalNoticationWithHour:data.hour Min:data.minute ClockID:data.clockId HabitID:habitId WeekDay:type habitName:habitName];
        }
    }
}

#pragma mark -
#pragma mark public

//将全局数据更新到helper中保存
- (void)saveAlarmRes:(HFHabitAlarmClockRes *)res
{
    self.mRes = res;
    [self creatLocalNoticationList];
}

- (HFHabitAlarmClockRes *)alarmClockRes
{
    return mRes;
}

//登录进来先要进行本地
- (void)updateUsrID:(NSInteger)userID
{
    mUserId = userID;
}

- (NSArray *)getClockListForHabitID:(NSInteger)habitId
{
    for (int i = 0; i < [mRes.data count]; i++) {
        HFHabitAlarmClockData * data = [mRes.data objectAtIndex:i];
        if (data.habitId == habitId)
        {
            return data.clockList;
        }
    }
    return nil;
}

- (void)addNewData:(HFHabitAlramClockListData *)data habitId:(NSInteger)habitdID habitName:(NSString *)habitName
{
    for (int i = 0; i < [mRes.data count]; i++) {
        HFHabitAlarmClockData * alarmData = [mRes.data objectAtIndex:i];
        if (alarmData.habitId == habitdID)
        {
            [alarmData.clockList addObject:data];
            
            [self addLocalNotiWithData:data habitID:habitdID habitName:habitName];
        }
    }
}

- (void)updateData:(HFHabitAlramClockListData *)data habitId:(NSInteger)habitdID habitName:(NSString *)habitName
{
    for (int i = 0; i < [mRes.data count]; i++) {
        HFHabitAlarmClockData * alarmData = [mRes.data objectAtIndex:i];
        if (alarmData.habitId == habitdID)
        {
            for (int j = 0; j < [alarmData.clockList count]; j++) {
                HFHabitAlramClockListData * clockData = [alarmData.clockList objectAtIndex:j];
                if (clockData.clockId == data.clockId)
                {
                    [alarmData.clockList replaceObjectAtIndex:j withObject:data];
                    
                    [self deleteLocalNoticationWithClockID:data.clockId];
                    
                    [self addLocalNotiWithData:data habitID:habitdID habitName:habitName];
                }
            }
        }
    }
}

- (void)cancelAllLocalNotication
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

@end
