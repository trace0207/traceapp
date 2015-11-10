//
//  HFCreatHabitReq.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/6/8.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseHttpReq.h"

@interface HFCreatHabitReq : BaseHttpReq
@property(nonatomic)NSInteger hour;
@property(nonatomic)NSInteger minute;
@property(nonatomic,copy)NSString * weeks;
@property(nonatomic)NSInteger status;
@property (nonatomic, copy)NSString *habitName;
@property (nonatomic, copy)NSString *habitNote;
@end
