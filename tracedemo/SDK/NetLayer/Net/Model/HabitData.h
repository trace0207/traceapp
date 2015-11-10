//
//  HabitData.h
//  GuanHealth
//
//  Created by hermit on 15/4/9.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ResponseData.h"
#import "HabitList.h"

@interface HabitData : ResponseData


@property (nonatomic, strong) NSArray<HabitList>    *userHabitList;

@property (nonatomic, assign) int       subsciptionCount;
@property (nonatomic,   copy) NSString *synopsis;

@end
