//
//  HFHabitInfoRes.h
//  GuanHealth
//
//  Created by shi_dongdong on 15/6/3.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ResponseData.h"

@interface HFHabitSignInfoData : ResponseData

@property(nonatomic)NSInteger totalDay;//总签到天数
@property(nonatomic)NSInteger continueDay;//连续签到天数
@property(nonatomic)NSInteger signStatus;//今天是否已签到（1:已签到，0：未签到）

@property(nonatomic)NSInteger subscribeNum;//习惯订阅人数
@property(nonatomic)NSInteger dummyNum;//习惯订阅数（虚拟）
@property(nonatomic)NSInteger subscribeStatus;//习惯是否订阅（1:已订阅，0：未订阅）

@property (nonatomic, copy) NSString *habitName;
@property (nonatomic, copy) NSString *habitIconUrl;

@end


@interface HFHabitSignInfoRes : ResponseData

@property(nonatomic, strong)HFHabitSignInfoData * data;

@end
