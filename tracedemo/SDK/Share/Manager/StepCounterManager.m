//
//  StepCounterManager.m
//  StepCounter
//
//  Created by renhe on 15/7/25.
//  Copyright (c) 2015年 renhe. All rights reserved.
//

#import "StepCounterManager.h"
#import <UIKit/UIDevice.h>
#import <UIKit/UIAlertView.h>
#import "HFSchemeProxy.h"

@interface StepCounterManager ()

@property (nonatomic, assign) NSInteger stepCountsFromOneDay;//从某天到现在的步数
@property (nonatomic, assign) NSInteger stepCountsFromOneDayTo;//从某天到某天的步数
@property (nonatomic, strong) CMPedometer * pedometer;//适用于iOS8.0以后
@property (nonatomic, strong) CMStepCounter * stepCounter;//适用于iOS7.0以后
@property (nonatomic, assign) BOOL finishUpLoad;//判断是否上传计步成功

@end

@implementation StepCounterManager

#pragma mark - Pubic Methods

- (void)stop
{
    [self _stop];
}

- (void)start;
{
    [self _start:nil];
}

+ (instancetype)sharedManager
{
    static StepCounterManager * _sharedManager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedManager = [[self alloc] init];
        _sharedManager.stepCounterIsAvaliable = NO;
    });
    return _sharedManager;
}
#pragma mark - ProxyFunction
- (NSInteger)getStepCountsFromDate:(NSDate *)date
{
    [self _start:date];
    return self.stepCountsFromOneDay;
}
#pragma mark - Private Methods
- (void)_start:(NSDate *)date
{
    NSDate * zeroDate = nil;
    if (!date)
    {
        zeroDate = [self getTodayZeroHour];
    }else
    {
        zeroDate = date;
    }
    //判断是否协处理器可用
    if ([self isStepCountingAvailable]) {
        //iOS8以上用CMPedometer
        if (IOS8VERSION) {
            [self.pedometer startPedometerUpdatesFromDate:zeroDate withHandler:^(CMPedometerData *pedometerData, NSError *error) {
                self.stepCounterIsAvaliable = YES;
                self.stepCountsFromOneDay = pedometerData.numberOfSteps.integerValue;
                if ([self.delegate respondsToSelector:@selector(StepCounterManagerStepCountsChanged:)]) {
                    [self.delegate StepCounterManagerStepCountsChanged:pedometerData.numberOfSteps.integerValue];
                }
            }];
            //iOS8以下用CMStepCounter
        }else {
//            [self.stepCounter startStepCountingUpdatesToQueue:[NSOperationQueue mainQueue] updateOn:1 withHandler:^(NSInteger numberOfSteps, NSDate *timestamp, NSError *error) {
//                self.stepCounterIsAvaliable = YES;
//                self.stepCountsFromOneDay = numberOfSteps;
//                if ([self.delegate respondsToSelector:@selector(StepCounterManagerStepCountsChanged:)]) {
//                    [self.delegate StepCounterManagerStepCountsChanged:numberOfSteps];
//                }
//            }];
            [self.stepCounter queryStepCountStartingFrom:zeroDate to:[NSDate date] toQueue:[NSOperationQueue mainQueue] withHandler:^(NSInteger numberOfSteps, NSError *error) {
                self.stepCounterIsAvaliable = YES;
                self.stepCountsFromOneDay = numberOfSteps;
                if ([self.delegate respondsToSelector:@selector(StepCounterManagerStepCountsChanged:)]) {
                    [self.delegate StepCounterManagerStepCountsChanged:numberOfSteps];
                }
            }];
        }
    //协处理器不可用时候
    }else{
        if (self.delegate && [self.delegate respondsToSelector:@selector(StepCounterManagerStepCountsChanged:)]) {
            [self.delegate StepCounterManagerStepCountsChanged:-1];
        }
    }
}

- (void)_stop
{
    [self.stepCounter stopStepCountingUpdates];
    [self.pedometer stopPedometerUpdates];
}

- (NSInteger)queryPedometerDataFromDate:(NSDate *)start toDate:(NSDate *)end
{
    if (self.stepCounterIsAvaliable) {
        if (IOS8VERSION) {
            [self.pedometer queryPedometerDataFromDate:start toDate:end withHandler:^(CMPedometerData *pedometerData, NSError *error) {
                self.stepCountsFromOneDayTo = pedometerData.numberOfSteps.integerValue;
            }];
        }else {
            [self.stepCounter queryStepCountStartingFrom:start to:end toQueue:[[NSOperationQueue alloc] init] withHandler:^(NSInteger numberOfSteps, NSError *error) {
                self.stepCountsFromOneDayTo = numberOfSteps;
            }];
        }
    }else{
        self.stepCountsFromOneDayTo = 0;
    }
    return self.stepCountsFromOneDayTo;
}
- (void)uploadStepCounts:(NSInteger)steps dayIndex:(NSInteger)dayIndex withFinishBlock:(finishUpLoadBlock)finishUpLoad
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString * dateStr = [formatter stringFromDate:[self getNowDateFromatAnDate:[NSDate date]]];
    [[[HIIProxy shareProxy] schemeProxy] uploadStepCount:steps date:dateStr withBlock:^(HF_BaseAck *ack) {
        if (ack.recode == 1) {
            finishUpLoad();
        }
    }];
}
- (BOOL)isStepCountingAvailable
{
    BOOL flags = NO;
    if (IOS8VERSION) {
        flags = [CMPedometer isStepCountingAvailable];
    }else {
        flags = [CMStepCounter isStepCountingAvailable];
    }
    return flags;
}

- (NSDate *)getTodayZeroHour
{
    NSDate *date = [NSDate date];
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"CCD"];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier: NSGregorianCalendar];
    [gregorian setTimeZone:gmt];
    NSDateComponents *components = [gregorian components: NSUIntegerMax fromDate: date];
    [components setHour: 0];
    [components setMinute:0];
    [components setSecond: 0];
    return [gregorian dateFromComponents: components];
}

- (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    return destinationDateNow;
}

#pragma mark - Getter

- (CMPedometer *)pedometer
{
    if (!_pedometer) {
        _pedometer = [[CMPedometer alloc] init];
    }
    return _pedometer;
}

- (CMStepCounter *)stepCounter
{
    if (!_stepCounter) {
        _stepCounter = [[CMStepCounter alloc] init];
    }
    return _stepCounter;
}

@end
