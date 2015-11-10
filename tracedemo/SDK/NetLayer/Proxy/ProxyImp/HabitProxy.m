//
//  HFHabitManager.m
//  GuanHealth
//
//  Created by shi_dongdong on 15/6/3.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HabitProxy.h"
#import "HFHabitAlarmClockRes.h"
#import "HFHabitAlarmClockReq.h"

#import "HFHabitAlarmClockUpdateReq.h"
#import "HFHabitAlarmClockDeleteReq.h"
#import "HFHabitAlarmClockAddReq.h"

#import "HFHabitSignInfoReq.h"
#import "HFHabitSignInfoRes.h"

#import "HFHabitSignReq.h"
#import "HFHabitUnSignReq.h"

#import "HFHabitListReq.h"
#import "HFHabitListRes.h"

#import "HFAddHabitReq.h"

#import "HFCreatHabitReq.h"

#import "HFHabitIsLatestReq.h"
#import "HFHabitIsLatestRes.h"
#import "HFCreateHabitRes.h"

#import "HFHabitHelper.h"

#import "HFHabitDeleteReq.h"

#import "HFDBCenter.h"
#import "BaseHFHttpClient.h"

@implementation HabitProxy

- (void)requestHabitAndAlarmClockInfoWithCompletion:(habitFinishBlock)block{
    WS(weakSelf)
    HFHabitAlarmClockReq * req = [[HFHabitAlarmClockReq alloc] init];
    
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:@"HFHabitAlarmClockRes" completion:^(HFRetModel *ret) {
        if (ret.bSuccess)
        {
            HFHabitAlarmClockRes * res = (HFHabitAlarmClockRes *)ret.data;
            [weakSelf saveHabitAndAlarmInf:res];
        }
        block(ret.bSuccess);
    }];
}

- (void)updateAlarmClockWithAlarmClockData:(HFHabitAlramClockListData *)data habitID:(NSInteger)habitId completion:(habitFinishBlock)block
{
    WS(weakSelf)
    HFHabitAlarmClockUpdateReq * req = [[HFHabitAlarmClockUpdateReq alloc] init];
    req.clockId = data.clockId;
    req.habitId = habitId;
    req.weeks = data.weeks;
    req.hour = data.hour;
    req.minute = data.minute;
    req.status = data.status;
    
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:nil completion:^(HFRetModel *ret) {
        if (ret.bSuccess)
        {
            [weakSelf checkNeedUpdateWithCompletion:^(BOOL finish) {
                block(finish);
            }];
        }
        else
        {
            block(NO);
        }
    }];
}

- (void)deletaAlarmClockWithClockId:(NSInteger)clockId completion:(habitFinishBlock)block
{
    WS(weakSelf)
    HFHabitAlarmClockDeleteReq * req = [[HFHabitAlarmClockDeleteReq alloc] init];
    req.clockId = clockId;
    
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:nil completion:^(HFRetModel *ret) {
        if (ret.bSuccess)
        {
            [weakSelf checkNeedUpdateWithCompletion:^(BOOL finish) {
                block(finish);
            }];
        }
        else
        {
            block(NO);
        }
    }];
}

- (void)addAlarmClockWithAlarmClockData:(HFHabitAlramClockListData *)data habitID:(NSInteger)habitId completion:(habitFinishBlock)block
{
    WS(weakSelf)
    HFHabitAlarmClockAddReq * req = [[HFHabitAlarmClockAddReq alloc] init];
    req.habitId = habitId;
    req.hour = data.hour;
    req.minute = data.minute;
    req.weeks = data.weeks;
    req.status = data.status;
    
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:nil completion:^(HFRetModel *ret) {
        if (ret.bSuccess)
        {
            [weakSelf checkNeedUpdateWithCompletion:^(BOOL finish) {
                block(finish);
            }];
        }
        else
        {
            block(NO);
        }
    }];
    
}

- (void)requestHabitInfoWithHabitId:(NSInteger)habitId
                            Success:(habitSignInfoSuccessBlock)success
                               fail:(habitSignInfoFailBlock)fail
{
    HFHabitSignInfoReq * req = [[HFHabitSignInfoReq alloc] init];
    req.habitId = habitId;
    
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:@"HFHabitSignInfoRes" completion:^(HFRetModel *ret) {
        if (ret.bSuccess)
        {
            HFHabitSignInfoRes * res = (HFHabitSignInfoRes *)ret.data;
            success(res);
        }
        else
        {
            fail();
        }
    }];

}

- (void)habitSignOperator:(BOOL)state withHabitID:(NSInteger)habitID completion:(habitFinishBlock)block
{
    //WS(weakSelf)
    if (state)
    {
        HFHabitSignReq * req = [[HFHabitSignReq alloc] init];
        req.habitId = habitID;
        
        [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:nil completion:^(HFRetModel *ret) {
            block(ret.bSuccess);
        }];
    }
    else
    {
        HFHabitUnSignReq * req = [[HFHabitUnSignReq alloc] init];
        req.habitId = habitID;
        
        [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:nil completion:^(HFRetModel *ret) {
            block(ret.bSuccess);
        }];
    }
}

- (void)requestHabitListWithTime:(NSInteger)day Success:(habitListSuccessBlock)success fail:(habitListFailBlock)fail
{
    HFHabitListReq * req = [[HFHabitListReq alloc] init];
    req.day = day;
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:@"HFHabitListRes"  completion:^(HFRetModel *ret) {
        if (ret.bSuccess)
        {
            HFHabitListRes * res = (HFHabitListRes *)ret.data;
            success(res);
        }
        else
        {
            fail();
        }
    }];
}

- (void)addHabitWithHabitId:(NSInteger)habitId
                    andData:(HFHabitAlramClockListData *)data
                 completion:(habitFinishBlock)block;
{
    HFAddHabitReq * req = [[HFAddHabitReq alloc] init];
    req.habitId = habitId;
    req.hour = data.hour;
    req.minute = data.minute;
    req.weeks = data.weeks;
    req.status = data.status;
    WS(weakSelf)
    
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:nil completion:^(HFRetModel *ret) {
        if (ret.bSuccess)
        {
            [weakSelf checkNeedUpdateWithCompletion:^(BOOL finish) {
                block(finish);
            }];
        }
        else
        {
            block(NO);
        }
    }];
}

- (void)creatHabitWithHabitName:(NSString *)habitName
                         andDes:(NSString *)desInfo
                        andData:(HFHabitAlramClockListData *)data
                        Success:(createSuccessBlock)success
                           fail:(createHabitFailBlock)fail
{
    HFCreatHabitReq * req = [[HFCreatHabitReq alloc] init];
    req.habitName = habitName;
    req.hour = data.hour;
    req.minute = data.minute;
    req.weeks = data.weeks;
    req.status = data.status;
    req.habitNote = desInfo;
    WS(weakSelf)
    
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:@"HFCreateHabitRes" completion:^(HFRetModel *ret) {
        if (ret.bSuccess)
        {
            [weakSelf checkNeedUpdateWithCompletion:^(BOOL finish) {
                HFCreateHabitRes *res = (HFCreateHabitRes*)ret.data;
                success(res);
            }];
        }
        else
        {
            fail();
        }
    }];
}

//删除某一个习惯
- (void)deleteHabitWithId:(NSInteger)habitID completion:(habitFinishBlock)block
{
    WS(weakSelf)
    HFHabitDeleteReq * req = [[HFHabitDeleteReq alloc] init];
    req.habitId = habitID;
    
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:nil completion:^(HFRetModel *ret) {
        if (ret.bSuccess)
        {
            [weakSelf checkNeedUpdateWithCompletion:^(BOOL finish) {
                block(finish);
            }];
        }
        else
        {
            block(NO);
        }
    }];
}

//检查习惯或者闹钟是否有更新
- (void)checkNeedUpdateWithCompletion:(habitFinishBlock)block
{
    WS(weakSelf)
    HFHabitIsLatestReq * req = [[HFHabitIsLatestReq alloc] init];
    req.lastUpdateTime = [GlobInfo shareInstance].mLastUpdateTime;
    
    
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:@"HFHabitIsLatestRes" completion:^(HFRetModel *ret) {
        if (ret.bSuccess)
        {
            HFHabitIsLatestRes * res = (HFHabitIsLatestRes *)ret.data;
            if (res.isUpdate == 1)
            {
                //这里有个漏洞，如果拉数据的时候失败，没有办法处理
                [weakSelf requestHabitAndAlarmClockInfoWithCompletion:^(BOOL finish) {
                    [weakSelf saveLastUpdateTime:res.lastUpdateTime];
                    block(finish);
                }];
            }
            else
            {
                //从数据库里面拼装出数据
                [weakSelf readDataSourceFromDB];
                [weakSelf saveLastUpdateTime:res.lastUpdateTime];
                block(YES);
            }
        }
        else
        {
            [weakSelf readDataSourceFromDB];
            block(NO);
        }
    }];
}


#pragma mark -
#pragma mark private
- (void)saveHabitAndAlarmInf:(HFHabitAlarmClockRes *)res
{
    [[HFHabitHelper shareInstance] saveAlarmRes:res];
    [[HFDBCenter shareInstance] updateHabitList:res.data];
}

- (void)readDataSourceFromDB
{
    HFHabitAlarmClockRes * res = [[HFHabitAlarmClockRes alloc] init];
    res.data = [[HFDBCenter shareInstance] getHabitList];
    [[HFHabitHelper shareInstance] saveAlarmRes:res];
}

- (void)saveLastUpdateTime:(long)lastTime
{
    [GlobInfo shareInstance].mLastUpdateTime = lastTime;
}

- (BOOL)isResEmpty
{
    HFHabitAlarmClockRes * res = [[HFHabitHelper shareInstance] alarmClockRes];
    if (res)
    {
        return YES;
    }
    return NO;
}

@end
