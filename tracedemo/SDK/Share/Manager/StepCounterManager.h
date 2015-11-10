//
//  StepCounterManager.h
//  StepCounter
//
//  Created by renhe on 15/7/25.
//  Copyright (c) 2015年 renhe. All rights reserved.
//

#import <CoreMotion/CoreMotion.h>

typedef void (^finishUpLoadBlock)();
/**
 *  当步数发生改变时的回调协议
 */
@protocol StepCounterManagerDelegate<NSObject>

//今天0时到目前的步数
- (void)StepCounterManagerStepCountsChanged:(NSInteger)StepCounts;

@end

@interface StepCounterManager : NSObject

@property (nonatomic , weak) id<StepCounterManagerDelegate> delegate;

//判断用户手机是否支持计步
@property (nonatomic, assign) BOOL stepCounterIsAvaliable;

//@return 单例对象，需要设置代理才能拿到回调的步数
+ (instancetype)sharedManager;

//停止记步
- (void)stop;

//开始记步
- (void)start;

//获取从某一天到今天的步数
- (NSInteger)getStepCountsFromDate:(NSDate *)date;
//获取从某天到某天的步数
- (NSInteger)queryPedometerDataFromDate:(NSDate *)start toDate:(NSDate *)end;
//上传计步数
- (void)uploadStepCounts:(NSInteger)steps dayIndex:(NSInteger)dayIndex withFinishBlock:(finishUpLoadBlock)finishUpLoad;
@end
