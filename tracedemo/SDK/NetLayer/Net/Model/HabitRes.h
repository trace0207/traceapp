//
//  HabitRes.h
//  GuanHealth
//
//  Created by hermit on 15/4/9.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ResponseData.h"
#import "HabitData.h"

@interface HabitRes : ResponseData

@property (nonatomic, strong) HabitData *data;

@end
