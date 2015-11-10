//
//  HFDBCenter.h
//  GuanHealth
//
//  Created by shi_dongdong on 15/6/8.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HFDBCenter : NSObject

SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(HFDBCenter, shareInstance)

//从数据库里面读出数据
- (NSArray<HFHabitAlarmClockData> *)getHabitList;

//更新数据库数据
- (void)updateHabitList:(NSArray *)habitLists;

//取出相关的Habit数据
- (HFHabitAlarmClockData *)getHabitDataWithId:(NSInteger)habitId;

//更新本地敏感词库
- (void)updateSensitiveWords:(NSArray *)words;

//从数据库中取出敏感词库
- (NSArray *)getSensitiveWords;



@end
