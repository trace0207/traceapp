//
//  HFCreateHabitRes.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/6/9.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

@interface HFCreateHabitData : ResponseData

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger source;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic,   copy) NSString *name;
@property (nonatomic,   copy) NSString *habitIconUrl;

@end


#import "ResponseData.h"

@interface HFCreateHabitRes : ResponseData

@property (nonatomic, strong) HFCreateHabitData *data;

@end
