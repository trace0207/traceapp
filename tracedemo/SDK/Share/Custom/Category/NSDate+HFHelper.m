//
//  NSDate+HFHelper.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/6/11.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "NSDate+HFHelper.h"
#import "NSDate+Helpers.h"
#define DAY_SEC 86400

@implementation NSDate (HFHelper)
+ (NSString *)stringWithTimeUTC:(long)UTC
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:UTC];
    NSInteger day = [self compareIfTodayWithDate:date];
    NSString *dateString = nil;
    switch (day) {
        case 0:
            return [self compareNowWtithDate:date];
            break;
        case 1:
            dateString = [self stringFromDate:date withFormat:NSDateFormatHm24 andTimeZone:NSDateTimeZoneUTC];
            return [NSString stringWithFormat:@"昨天%@",dateString];
            break;
        case 2:
            dateString = [self stringFromDate:date withFormat:NSDateFormatHm24 andTimeZone:NSDateTimeZoneUTC];
            return [NSString stringWithFormat:@"前天%@",dateString];
            break;
        default:
            dateString = [self stringFromDate:date withFormat:NSDateFormatDmy4 andTimeZone:NSDateTimeZoneUTC];
            return dateString;
            break;
    }
}
+ (NSInteger)compareIfTodayWithDate:(NSDate *)date {
    NSDate *todate = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSChineseCalendar];
    NSDateComponents *comps_today= [calendar components:(NSYearCalendarUnit |
                                                         NSMonthCalendarUnit |
                                                         NSDayCalendarUnit |
                                                         NSWeekdayCalendarUnit) fromDate:todate];
    
    NSDateComponents *comps_other= [calendar components:(NSYearCalendarUnit |
                                                         NSMonthCalendarUnit |
                                                         NSDayCalendarUnit |
                                                         NSWeekdayCalendarUnit) fromDate:date];
    
    if (comps_today.year == comps_other.year &&
        comps_today.month == comps_other.month &&
        comps_today.day == comps_other.day) {
        return 0;
        
    }else if (comps_today.year == comps_other.year &&
              comps_today.month == comps_other.month &&
              (comps_today.day - comps_other.day) == -1){
        return 1;
        
    }else if (comps_today.year == comps_other.year &&
              comps_today.month == comps_other.month &&
              (comps_today.day - comps_other.day) == -2){
        return 2;
        
    }else{
        return 3;
    }
}

+ (NSString *)compareNowWtithDate:(NSDate *)date
{
    NSTimeInterval seconds = fabs([date timeIntervalSinceNow]);
    NSString *beforeTime = nil;
    if (seconds >= BSHour) {
        int hours = (int)seconds/BSHour;
        beforeTime = [NSString stringWithFormat:@"%i小时前",hours];
    }else if (seconds >= BSMinute) {
        int minutes = (int)seconds/BSMinute;
        beforeTime = [NSString stringWithFormat:@"%i分钟前",minutes];
    }else{
        beforeTime = @"刚刚";
    }
    return beforeTime;
}
//返回当前星期几
+ (NSInteger)getCurrentWeekday:(NSDate *)date
{
    //NSDate *currentDate = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger unitFlags = NSWeekdayCalendarUnit;
    NSDateComponents *dateComponent = [gregorian components:unitFlags fromDate:date];
    return [dateComponent weekday] - 1;
}
//返回当前时
+ (NSInteger)getCurrentHour
{
    NSDate *currentDate = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger unitFlags = NSCalendarUnitHour;
    NSDateComponents *dateComponent = [gregorian components:unitFlags fromDate:currentDate];
    return [dateComponent hour];
}
//返回当前分
+ (NSInteger)getCurrentMinute;
{
    NSDate *currentDate = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger unitFlags = NSCalendarUnitMinute;
    NSDateComponents *dateComponent = [gregorian components:unitFlags fromDate:currentDate];
    return [dateComponent minute];
}

+ (NSTimeInterval)getUTCWithHour:(int)hour andMinute:(int)minute
{
    NSDate *currentDate=[NSDate date];
    NSDateFormatter *df=[[NSDateFormatter alloc] init];
    //[df setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSLocale *locale=[NSLocale currentLocale];
    [df setLocale:locale];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | kCFCalendarUnitMonth | kCFCalendarUnitDay |kCFCalendarUnitHour |kCFCalendarUnitMinute;
    NSDateComponents *dateComponent = [gregorian components:unitFlags fromDate:currentDate];
    
    NSString *habitDS = [NSString stringWithFormat:@"%@-%@-%@ %02i:%02i:00",@(dateComponent.year),@(dateComponent.month),@(dateComponent.day),hour,minute];
    
    NSDate *habitDate=[df dateFromString:habitDS];
    
    NSTimeInterval seconds = [habitDate timeIntervalSince1970];
    
    return seconds;
}
+ (NSDate *)getDateFromDateStr:(NSString *)dateStr
{
    NSDateFormatter *df=[[NSDateFormatter alloc] init];
    [df setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSLocale *locale=[NSLocale currentLocale];
    [df setLocale:locale];
    
    //    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    //    NSUInteger unitFlags = NSCalendarUnitYear | kCFCalendarUnitMonth | kCFCalendarUnitDay;
    //    NSDateComponents *dateComponent = [gregorian components:unitFlags fromDate:currentDate];
    
    NSString *habitDS = [NSString stringWithFormat:@"%@ 00:00:00",dateStr];
    
    NSDate *habitDate=[df dateFromString:habitDS];
    
    return habitDate;
}

+ (NSDate *)currentDatePlusDays:(NSInteger)day {
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + day * DAY_SEC;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:timeInterval];
}

@end
