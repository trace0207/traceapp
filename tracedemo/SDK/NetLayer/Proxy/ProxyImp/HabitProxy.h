//
//  HFHabitManager.h
//  GuanHealth
//
//  Created by shi_dongdong on 15/6/3.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HFHabitAlarmClockRes.h"
#import "HFHabitSignInfoRes.h"
#import "HFHabitListRes.h"
#import "HFCreateHabitRes.h"
@class HFHabitIsLatestRes;
@class HFHabitAlarmClockData;

typedef void (^habitAlarmClockSuccessBlock) (HFHabitAlarmClockRes * res);
typedef void (^habitAlarmClockfailBlock) (void);

typedef void (^habitFinishBlock) (BOOL finish);

typedef void (^habitSignInfoSuccessBlock) (HFHabitSignInfoRes * res);
typedef void (^habitSignInfoFailBlock) (void);

typedef void (^habitListSuccessBlock)(HFHabitListRes * res);
typedef void (^habitListFailBlock)(void);

typedef void (^habitCheckUpdateSuccessBlock)(HFHabitIsLatestRes * res);
typedef void (^habitCheckUpdateFailBlock)(void);

typedef void (^createSuccessBlock)(HFCreateHabitRes * res);
typedef void (^createHabitFailBlock)(void);

@interface HabitProxy : NSObject

//获取习惯以及闹钟详情
- (void)requestHabitAndAlarmClockInfoWithCompletion:(habitFinishBlock)block;

//重设闹钟
- (void)updateAlarmClockWithAlarmClockData:(HFHabitAlramClockListData *)data habitID:(NSInteger)habitId completion:(habitFinishBlock)block;

//删除闹钟
- (void)deletaAlarmClockWithClockId:(NSInteger)clockId completion:(habitFinishBlock)block;

//新增闹钟
- (void)addAlarmClockWithAlarmClockData:(HFHabitAlramClockListData *)data habitID:(NSInteger)habitId completion:(habitFinishBlock)block;

//获取连续打卡天数的接口
- (void)requestHabitInfoWithHabitId:(NSInteger)habitId
                            Success:(habitSignInfoSuccessBlock)success
                               fail:(habitSignInfoFailBlock)fail;

//打卡或者取消打卡
- (void)habitSignOperator:(BOOL)state withHabitID:(NSInteger)habitID completion:(habitFinishBlock)block;

//获取习惯列表
- (void)requestHabitListWithTime:(NSInteger)day Success:(habitListSuccessBlock)success fail:(habitListFailBlock)fail;
//添加一个习惯
- (void)addHabitWithHabitId:(NSInteger)habitId
                    andData:(HFHabitAlramClockListData *)data
                 completion:(habitFinishBlock)block;
//创建一个习惯
- (void)creatHabitWithHabitName:(NSString *)habitName
                         andDes:(NSString *)desInfo
                        andData:(HFHabitAlramClockListData *)data
                        Success:(createSuccessBlock)success
                           fail:(createHabitFailBlock)fail;

//删除某个习惯
- (void)deleteHabitWithId:(NSInteger)habitID completion:(habitFinishBlock)block;

//检查是否要更新本地数据
- (void)checkNeedUpdateWithCompletion:(habitFinishBlock)block;

@end
