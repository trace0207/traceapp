//
//  HFHabitTimeDetailViewController.h
//  GuanHealth
//
//  Created by shi_dongdong on 15/6/1.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseViewController.h"
#import "HFHabitAlarmClockRes.h"

typedef NS_ENUM(NSInteger, habitOperateType)
{
    CreateHabit_Type = 0,
    AddHabit_Type,
    UpdataClock_Type,
    AddNewClock_Type,
};

@protocol HFAddHabitDelegate <NSObject>
@optional
- (void)addHabitSuccess:(NSInteger)habitId;

- (void)finishAction:(HFHabitAlramClockListData *)data;

@end

@interface HFHabitTimeDetailViewController : BaseViewController
@property (nonatomic, strong)  UIViewController *popViewController;
@property (nonatomic, weak) id<HFAddHabitDelegate>delegate;
@property(nonatomic)NSInteger mHabitId;
@property(nonatomic,strong)HFHabitAlramClockListData * data;

@property(nonatomic)habitOperateType  mType;

@end
