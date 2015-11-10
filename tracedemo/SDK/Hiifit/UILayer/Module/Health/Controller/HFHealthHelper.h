//
//  HFHealthHelper.h
//  GuanHealth
//
//  Created by 栋栋 施 on 15/7/30.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HealthDayType) {
    HistoryType = 0,
    TodayType,
    FutureType,
};

/**
 *  此类负责对于历史数据，当日数据，以及未来数据的处理
 *  以后如果换成其他调理方式，需要进行换处理 采用扩展类的方式
 */
@interface HFHealthHelper : NSObject

- (instancetype)initWithType:(HealthDayType)type;

@property(nonatomic)HealthDayType mType;

@end
