//
//  NSDate+Common.m
//  RenheiOS
//
//  Created by renhe on 14-5-19.
//  Copyright (c) 2014年 renhe. All rights reserved.
//

#import "NSDate+Common.h"

@implementation NSDate (Common)

/****************************************************
 *@Description:根据年份、月份、日期、小时数、分钟数、秒数返回NSDate
 *@Params:
 *  year:年份
 *  month:月份
 *  day:日期
 *  hour:小时数
 *  minute:分钟数
 *  second:秒数
 *@Return:
 ****************************************************/
+ (NSDate*)dateWithYear:(NSUInteger)year
                  Month:(NSUInteger)month
                    Day:(NSUInteger)day
                   Hour:(NSUInteger)hour
                 Minute:(NSUInteger)minute
                 Second:(NSUInteger)second
{
    NSDateComponents* dateComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:[NSDate date]];
    dateComponents.year = year;
    dateComponents.month = month;
    dateComponents.day = day;
    dateComponents.hour = hour;
    dateComponents.minute = minute;
    dateComponents.second = second;

    return [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
}

/****************************************************
 *@Description:实现dateFormatter单例方法
 *@Params:nil
 *Return:相应格式的NSDataFormatter对象
 ****************************************************/
+ (NSDateFormatter*)defaultDateFormatterWithFormatYYYYMMddHHmmss
{
    static NSDateFormatter* staticDateFormatterWithFormatYYYYMMddHHmmss;
    if (!staticDateFormatterWithFormatYYYYMMddHHmmss) {
        staticDateFormatterWithFormatYYYYMMddHHmmss = [[NSDateFormatter alloc] init];
        [staticDateFormatterWithFormatYYYYMMddHHmmss setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    }

    return staticDateFormatterWithFormatYYYYMMddHHmmss;
}

+ (NSDateFormatter*)defaultDateFormatterWithFormatYYYYMMdd
{
    static NSDateFormatter* staticDateFormatterWithFormatYYYYMMddHHmmss;
    if (!staticDateFormatterWithFormatYYYYMMddHHmmss) {
        staticDateFormatterWithFormatYYYYMMddHHmmss = [[NSDateFormatter alloc] init];
        [staticDateFormatterWithFormatYYYYMMddHHmmss setDateFormat:@"YYYY.MM.dd"];
    }

    return staticDateFormatterWithFormatYYYYMMddHHmmss;
}

+ (NSDateFormatter*)defaultDateFormatterWithFormatMMddHHmm
{
    static NSDateFormatter* staticDateFormatterWithFormatMMddHHmm;
    if (!staticDateFormatterWithFormatMMddHHmm) {
        staticDateFormatterWithFormatMMddHHmm = [[NSDateFormatter alloc] init];
        [staticDateFormatterWithFormatMMddHHmm setDateFormat:@"MM-dd HH:mm"];
    }

    return staticDateFormatterWithFormatMMddHHmm;
}

+ (NSDateFormatter*)defaultDateFormatterWithFormatHHmm
{
    static NSDateFormatter* staticDateFormatterWithFormatHHmm;
    if (!staticDateFormatterWithFormatHHmm) {
        staticDateFormatterWithFormatHHmm = [[NSDateFormatter alloc] init];
        [staticDateFormatterWithFormatHHmm setDateFormat:@"HH:mm"];
    }

    return staticDateFormatterWithFormatHHmm;
}

+ (NSDateFormatter*)defaultDateFormatterWithFormatYYYYMMddHHmmInChinese
{
    static NSDateFormatter* staticDateFormatterWithFormatYYYYMMddHHmmssInChines;
    if (!staticDateFormatterWithFormatYYYYMMddHHmmssInChines) {
        staticDateFormatterWithFormatYYYYMMddHHmmssInChines = [[NSDateFormatter alloc] init];
        [staticDateFormatterWithFormatYYYYMMddHHmmssInChines setDateFormat:@"YYYY年MM月dd日 HH:mm"];
    }

    return staticDateFormatterWithFormatYYYYMMddHHmmssInChines;
}

+ (NSDateFormatter*)defaultDateFormatterWithFormatMMddHHmmInChinese
{
    static NSDateFormatter* staticDateFormatterWithFormatMMddHHmmInChinese;
    if (!staticDateFormatterWithFormatMMddHHmmInChinese) {
        staticDateFormatterWithFormatMMddHHmmInChinese = [[NSDateFormatter alloc] init];
        [staticDateFormatterWithFormatMMddHHmmInChinese setDateFormat:@"MM月dd日 HH:mm"];
    }

    return staticDateFormatterWithFormatMMddHHmmInChinese;
}

+ (NSDateFormatter *)defaultDateFormatterWithFormatMMddInChinese
{
    static NSDateFormatter* staticDateFormatterWithFormatMMddInChinese;
    if (!staticDateFormatterWithFormatMMddInChinese) {
        staticDateFormatterWithFormatMMddInChinese = [[NSDateFormatter alloc] init];
        [staticDateFormatterWithFormatMMddInChinese setDateFormat:@"MM月dd日"];
    }
    
    return staticDateFormatterWithFormatMMddInChinese;
}

/**********************************************************
 *@Description:获取当天的包括“年”，“月”，“日”，“周”，“时”，“分”，“秒”的NSDateComponents
 *@Params:nil
 *@Return:当天的包括“年”，“月”，“日”，“周”，“时”，“分”，“秒”的NSDateComponents
 ***********************************************************/
- (NSDateComponents*)componentsOfDay
{
    return [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:self];
}

//  --------------------------NSDate---------------------------
/****************************************************
 *@Description:获得NSDate对应的年份
 *@Params:nil
 *@Return:NSDate对应的年份
 ****************************************************/
- (NSUInteger)year
{
    return [self componentsOfDay].year;
}

/****************************************************
 *@Description:获得NSDate对应的月份
 *@Params:nil
 *@Return:NSDate对应的月份
 ****************************************************/
- (NSUInteger)month
{
    return [self componentsOfDay].month;
}

/****************************************************
 *@Description:获得NSDate对应的日期
 *@Params:nil
 *@Return:NSDate对应的日期
 ****************************************************/
- (NSUInteger)day
{
    return [self componentsOfDay].day;
}

/****************************************************
 *@Description:获得NSDate对应的小时数
 *@Params:nil
 *@Return:NSDate对应的小时数
 ****************************************************/
- (NSUInteger)hour
{
    return [self componentsOfDay].hour;
}

/****************************************************
 *@Description:获得NSDate对应的分钟数
 *@Params:nil
 *@Return:NSDate对应的分钟数
 ****************************************************/
- (NSUInteger)minute
{
    return [self componentsOfDay].minute;
}

/****************************************************
 *@Description:获得NSDate对应的秒数
 *@Params:nil
 *@Return:NSDate对应的秒数
 ****************************************************/
- (NSUInteger)second
{
    return [self componentsOfDay].second;
}

/****************************************************
 *@Description:获得NSDate对应的星期
 *@Params:nil
 *@Return:NSDate对应的星期
 ****************************************************/
- (NSUInteger)weekday
{
    return [self componentsOfDay].weekday;
}

/******************************************
 *@Description:获取当天是当年的第几周
 *@Params:nil
 *@Return:当天是当年的第几周
 ******************************************/
- (NSUInteger)weekOfDayInYear
{
    return [[NSCalendar currentCalendar] ordinalityOfUnit:NSWeekOfYearCalendarUnit inUnit:NSYearCalendarUnit forDate:self];
}

/****************************************************
 *@Description:获得一般当天的工作开始时间
 *@Params:nil
 *@Return:一般当天的工作开始时间
 ****************************************************/
- (NSDate*)workBeginTime
{
    unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents* components = [[NSCalendar currentCalendar] components:flags fromDate:self];
    [components setHour:9];
    [components setMinute:30];
    [components setSecond:0];

    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

/****************************************************
 *@Description:获得一般当天的工作结束时间
 *@Params:nil
 *@Return:一般当天的工作结束时间
 ****************************************************/
- (NSDate*)workEndTime
{
    unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents* components = [[NSCalendar currentCalendar] components:flags fromDate:self];
    [components setHour:18];
    [components setMinute:0];
    [components setSecond:0];

    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

/****************************************************
 *@Description:获取一小时后的时间
 *@Params:nil
 *@Return:一小时后的时间
 ****************************************************/
- (NSDate*)oneHourLater
{
    return [NSDate dateWithTimeInterval:3600 sinceDate:self];
}

/****************************************************
 *@Description:获得某一天的这个时刻
 *@Params:nil
 *@Return:某一天的这个时刻
 ****************************************************/
- (NSDate*)sameTimeOfDate
{
    unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents* components = [[NSCalendar currentCalendar] components:flags fromDate:self];
    [components setHour:[[NSDate date] hour]];
    [components setMinute:[[NSDate date] minute]];
    [components setSecond:[[NSDate date] second]];

    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

/******************************************
 *@Description:判断与某一天是否为同一天
 *@Params:
 *  otherDate:某一天
 *@Return:YES-同一天；NO-不同一天
 ******************************************/
- (BOOL)sameDayWithDate:(NSDate*)otherDate
{
    if (self.year == otherDate.year && self.month == otherDate.month && self.day == otherDate.day) {
        return YES;
    }
    else {
        return NO;
    }
}

/******************************************
 *@Description:判断与某一天是否为同一周
 *@Params:
 *  otherDate:某一天
 *@Return:YES-同一周；NO-不同一周
 ******************************************/
- (BOOL)sameWeekWithDate:(NSDate*)otherDate
{
    if (self.year == otherDate.year && self.month == otherDate.month && self.weekOfDayInYear == otherDate.weekOfDayInYear) {
        return YES;
    }
    else {
        return NO;
    }
}

/******************************************
 *@Description:判断与某一天是否为同一月
 *@Params:
 *  otherDate:某一天
 *@Return:YES-同一月；NO-不同一月
 ******************************************/
- (BOOL)sameMonthWithDate:(NSDate*)otherDate
{
    if (self.year == otherDate.year && self.month == otherDate.month) {
        return YES;
    }
    else {
        return NO;
    }
}

- (BOOL)sameYearWithDate:(NSDate*)otherDate
{
    if (self.year == otherDate.year) {
        return YES;
    }
    else {
        return NO;
    }
}

/****************************************************
 *@Description:获取时间的字符串格式
 *@Params:nil
 *@Return:时间的字符串格式
 ****************************************************/
- (NSString*)stringOfDateWithFormatYYYYMMddHHmmss
{
    return [[NSDate defaultDateFormatterWithFormatYYYYMMddHHmmss] stringFromDate:self];
}

- (NSString*)stringOfDateWithFormatYYYYMMdd
{
    return [[NSDate defaultDateFormatterWithFormatYYYYMMdd] stringFromDate:self];
}

- (NSString*)stringOfDateWithFormatMMddHHmm
{
    return [[NSDate defaultDateFormatterWithFormatMMddHHmm] stringFromDate:self];
}

- (NSString*)stringOfDateWithFormatHHmm
{
    return [[NSDate defaultDateFormatterWithFormatHHmm] stringFromDate:self];
}

- (NSString*)stringOfDateWithFormatYYYYMMddHHmmInChinese
{
    return [[NSDate defaultDateFormatterWithFormatYYYYMMddHHmmInChinese] stringFromDate:self];
}

- (NSString*)stringOfDateWithFormatMMddHHmmInChinese
{
    return [[NSDate defaultDateFormatterWithFormatMMddHHmmInChinese] stringFromDate:self];
}

- (NSString *)stringOfDateWithFormatMMddInChinese
{
    return [[NSDate defaultDateFormatterWithFormatMMddInChinese] stringFromDate:self];
}

- (NSString*)stringFromDate
{
    //1分钟前显示 刚刚
    //1小时前显示 几分钟
    //3天前显示 几天前
    //3天或者3天后 3天前

    NSTimeInterval timeInterval = -[self timeIntervalSinceNow];

    if (timeInterval < 60) { /* 1分钟 */
        return @"刚刚";
    }
    else if (timeInterval < 60 * 60) { /* 1小时 */
        return [NSString stringWithFormat:@"%d分钟前", (int)(timeInterval / 60)];
    }
    else if (timeInterval < 60 * 60 * 24) { /* 1天 */
        return [NSString stringWithFormat:@"%d小时前", (int)(timeInterval / (60 * 60))];
    }
    else if (timeInterval < 60 * 60 * 24 * 3) { /* 3天内 */
        return [NSString stringWithFormat:@"%d天前", (int)(timeInterval / (60 * 60 * 24))];
    }
    else { /* 3天后 */
        return @"3天前";
    }
}

- (NSString*)rmqDateString
{
    NSDate* now = [NSDate date];

    NSTimeInterval timeInterval = -[self timeIntervalSinceNow];

    if (timeInterval < 60) { /* 1分钟 */
        return @"刚刚";
    }
    else if (timeInterval < 60 * 60) { /* 1小时 */
        return [NSString stringWithFormat:@"%d分钟前", (int)(timeInterval / 60)];
    }
    else if (timeInterval < 60 * 60 * 6) { /* 6小时 */
        return [NSString stringWithFormat:@"%d小时前", (int)(timeInterval / (60 * 60))];
    }
    else if (now.day - self.day == 0) { /* 1天 */
        return @"今天";
    }
    else if (now.day - self.day == 1) { /* 昨天 */
        return @"昨天";
    }
    else if (now.day - self.day == 2) { /* 前天 */
        return @"前天";
    }
    else {
        return @"3天前";
    }
}

- (NSString*)stringFromDate2
{
    //今年 不显示年份  xx月xx日
    //其他 显示 xxxx年xx月xx日

    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy"];
    NSString* year = [formatter stringFromDate:self];
    if ([[formatter stringFromDate:[NSDate date]] isEqualToString:year]) { /* 今年 */
        [formatter setDateFormat:@"M月d日"];
        return [formatter stringFromDate:self];
    }

    /* 其他 */
    [formatter setDateFormat:@"yyyy年M月d日"];
    return [formatter stringFromDate:self];
}

- (NSString*)stringFromDate3
{
    NSDate* now = [NSDate date];
    NSDateFormatter* formatter = [NSDateFormatter new];
    NSString* returnStr;

    if (now.day - self.day > 2) { /* 3天前 */
        if (now.year == self.year) { /* 今年 */
            [formatter setDateFormat:@"M月d日 %@HH:mm"];
            returnStr = [formatter stringFromDate:self];
        }
        else { /* 去年以前 */
            [formatter setDateFormat:@"yyyy年M月d日 %@HH:mm"];
            returnStr = [formatter stringFromDate:self];
        }
    }
    else if (now.day - self.day == 2) { /* 前天 */
        [formatter setDateFormat:@"%@HH:mm"];
        returnStr = [NSString stringWithFormat:@"前天 %@", [formatter stringFromDate:self]];
    }
    else if (now.day - self.day == 1) { /* 昨天 */
        [formatter setDateFormat:@"%@HH:mm"];
        returnStr = [NSString stringWithFormat:@"昨天 %@", [formatter stringFromDate:self]];
    }
    else { /* 今天 */
        [formatter setDateFormat:@"%@HH:mm"];
        returnStr = [formatter stringFromDate:self];
    }

    NSString* timePeriod = [NSDate getTimePeriod:self.hour];

    return [NSString stringWithFormat:returnStr, timePeriod];
}

- (NSString*)stringFromDate4
{
    NSDate* now = [NSDate date];
    NSDateFormatter* formatter = [NSDateFormatter new];
    NSString* returnStr;

    if (now.day - self.day > 2) { /* 3天前 */
        if (now.year == self.year) { /* 今年 */
            [formatter setDateFormat:@"M月d日"];
            returnStr = [formatter stringFromDate:self];
        }
        else { /* 去年以前 */
            [formatter setDateFormat:@"yyyy年M月d日"];
            returnStr = [formatter stringFromDate:self];
        }
    }
    else if (now.day - self.day == 2) { /* 前天 */
        returnStr = @"前天";
    }
    else if (now.day - self.day == 1) { /* 昨天 */
        returnStr = @"昨天";
    }
    else { /* 今天 */
        [formatter setDateFormat:@"%@HH:mm"];
        returnStr = [formatter stringFromDate:self];
    }

    NSString* timePeriod = [NSDate getTimePeriod:self.hour];

    return [NSString stringWithFormat:returnStr, timePeriod];
}

+ (NSString*)getTimePeriod:(NSInteger)hour
{
    NSString* timePeriod;
    if (hour >= 18) {
        timePeriod = @"晚上";
    }
    else if (hour >= 13) {
        timePeriod = @"下午";
    }
    else if (hour >= 12) {
        timePeriod = @"中午";
    }
    else if (hour >= 6) {
        timePeriod = @"早上";
    }
    else {
        timePeriod = @"凌晨";
    }
    return timePeriod;
}

+ (NSDate*)dateWithTimestamp:(NSNumber*)timestamp
{
    return [NSDate dateWithTimeIntervalSince1970:(timestamp.longLongValue / 1000)];
}

- (NSNumber*)timestampFromDate
{
    return @([self timeIntervalSince1970] * 1000);
}

+ (NSDate*)dateFromTimeInterval:(int64_t)date
{
    NSString* dateStr = [NSString stringWithFormat:@"%lld", date];
    NSString* newDateStr = dateStr;

    if (dateStr.length > 10) {
        newDateStr = [dateStr substringWithRange:NSMakeRange(0, 10)];
    }
    NSDate* confromTimesp = [NSDate dateWithTimeIntervalSince1970:[newDateStr intValue]];
    return confromTimesp;
}

@end
