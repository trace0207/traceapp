//
//  HFHabitAlarmClockRes.h
//  GuanHealth
//
//  Created by shi_dongdong on 15/6/3.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ResponseData.h"


@protocol HFHabitAlramClockListData <NSObject>
@end

@interface HFHabitAlramClockListData : ResponseData

@property(nonatomic)NSInteger clockId;
@property(nonatomic)NSInteger hour;
@property(nonatomic)NSInteger minute;
@property(nonatomic)NSInteger status;
@property(nonatomic,strong)NSString * weeks;

@end



@protocol HFHabitAlarmClockData <NSObject>
@end

@interface HFHabitAlarmClockData : ResponseData

@property(nonatomic)NSInteger habitId;
@property(nonatomic,copy)NSString * habitName;
@property(nonatomic,strong)NSMutableArray<HFHabitAlramClockListData> * clockList;
@property(nonatomic,copy)NSString * habitIconUrl;
@property(nonatomic)NSInteger isSign;
@property(nonatomic)NSInteger subscribeNum;
@property(nonatomic)NSInteger dummyNum;
@end


@interface HFHabitAlarmClockRes : ResponseData

@property(nonatomic,strong)NSArray<HFHabitAlarmClockData> * data;

@end
