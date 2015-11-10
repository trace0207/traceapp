//
//  NSDate+HFHelper.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/6/11.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (HFHelper)
+ (NSString *)stringWithTimeUTC:(long)UTC;
//返回0、今天 1、昨天 2、前天 3、更前时间
+ (NSInteger)compareIfTodayWithDate:(NSDate *)date;
//返回几分钟之前或几小时之前的字符串
+ (NSString *)compareNowWtithDate:(NSDate *)date;

+ (NSInteger)getCurrentWeekday:(NSDate *)date;//返回当前星期几
+ (NSInteger)getCurrentHour;//返回当前时
+ (NSInteger)getCurrentMinute;//返回当前分

+ (NSTimeInterval)getUTCWithHour:(int)hour andMinute:(int)minute;

+ (NSDate *)getDateFromDateStr:(NSString *)dateStr;

+ (NSDate *)currentDatePlusDays:(NSInteger)day;

@end
