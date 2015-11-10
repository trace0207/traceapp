//
//  HFHabitAlarmClockResetReq.h
//  GuanHealth
//
//  Created by shi_dongdong on 15/6/3.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseHttpReq.h"

@interface HFHabitAlarmClockUpdateReq : BaseHttpReq

@property(nonatomic)NSInteger clockId;
@property(nonatomic)NSInteger habitId;
@property(nonatomic)NSInteger hour;
@property(nonatomic)NSInteger minute;
@property(nonatomic,copy)NSString * weeks;
@property(nonatomic)NSInteger status;
@end
