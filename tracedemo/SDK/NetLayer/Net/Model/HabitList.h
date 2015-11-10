//
//  HabitList.h
//  GuanHealth
//
//  Created by hermit on 15/4/9.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ResponseData.h"

@protocol HabitList

@end

@interface HabitList : ResponseData

@property (nonatomic, assign) int habitId;
@property (nonatomic, assign) int hour;
@property (nonatomic, assign) int status;
@property (nonatomic, assign) int minute;
@property (nonatomic, assign) int finished;//是否完成习惯 0、未完成 1、已完成

@property (nonatomic, retain) NSString * weeks;
@property (nonatomic, retain) NSString * habitName;
@property (nonatomic, retain) NSString * habitIconUrl;


- (BOOL)isPastTime;

- (BOOL)isToday;

@end
