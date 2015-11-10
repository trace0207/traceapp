//
//  HFDeleteHabitReq.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/7/9.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseHttpReq.h"

@interface HFDeleteHabitReq : BaseHttpReq
@property (nonatomic, assign) NSInteger habitId;
@end
