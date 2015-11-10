//
//  HFHabitAlarmClockAddReq.h
//  GuanHealth
//
//  Created by shi_dongdong on 15/6/5.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseHttpReq.h"

@interface HFHabitAlarmClockAddReq : BaseHttpReq

@property(nonatomic)NSInteger habitId;
@property(nonatomic)NSInteger hour;
@property(nonatomic)NSInteger minute;
@property(nonatomic,copy)NSString * weeks;
@property(nonatomic)NSInteger status;
@end
