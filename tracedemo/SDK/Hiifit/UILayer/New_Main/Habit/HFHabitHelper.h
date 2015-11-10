//
//  HFHabitHelper.h
//  GuanHealth
//
//  Created by shi_dongdong on 15/6/1.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HFHabitAlramClockListData;
@class HFHabitAlarmClockRes;
typedef NS_ENUM(NSInteger, WeekDayType) {
    HF_Sunday = 1,
    HF_Monday,
    HF_Tuesday,
    HF_Wenday,
    HF_Thuday,
    HF_Friday,
    HF_Satday,
};


@interface HFHabitHelper : NSObject

SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(HFHabitHelper, shareInstance);

//保存闹铃和习惯数据
- (void)saveAlarmRes:(HFHabitAlarmClockRes *)res;

//获取闹铃和习惯数据
- (HFHabitAlarmClockRes *)alarmClockRes;

//更新当前登录的用户ID
- (void)updateUsrID:(NSInteger)userID;

//删除单个闹铃
- (void)deleteLocalNoticationWithClockID:(NSInteger)clockID;

//删除某个习惯下所有通知
- (void)deleteLocalNoticationWithHabitID:(NSInteger)habitID;

//删除某个用户下所有通知
- (void)deleteCurrentUserLocalNotication;

//获取某个ID下地闹钟列表  返回闹钟数组
- (NSArray *)getClockListForHabitID:(NSInteger)habitId;

- (void)addNewData:(HFHabitAlramClockListData *)data habitId:(NSInteger)habitdID habitName:(NSString *)habitName;

- (void)updateData:(HFHabitAlramClockListData *)data habitId:(NSInteger)habitdID habitName:(NSString *)habitName;

- (void)cancelAllLocalNotication;

@end
