//
//  HFHealthHelper.m
//  GuanHealth
//
//  Created by 栋栋 施 on 15/7/30.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFHealthHelper.h"

@implementation HFHealthHelper

- (instancetype)initWithType:(HealthDayType)type
{
    self = [super init];
    
    if (self)
    {
        self.mType = type;
    }
    return self;
}

@end
