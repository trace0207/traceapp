//
//  HFAddHabitReq.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/6/8.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseHttpReq.h"

@interface HFAddHabitReq : BaseHttpReq

@property(nonatomic)NSInteger habitId;
@property(nonatomic)NSInteger hour;
@property(nonatomic)NSInteger minute;
@property(nonatomic,copy)NSString * weeks;
@property(nonatomic)NSInteger status;

@end
