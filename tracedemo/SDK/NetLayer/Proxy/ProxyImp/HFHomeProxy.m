//
//  HFHomeProxy.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/7/8.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFHomeProxy.h"
#import "HFTimeLineReq.h"
#import "TimeLineRes.h"
#import "HFClosePushReq.h"
#import "HFDeleteMessageReq.h"
#import "FHGetModulesReq.h"
#import "HFGetMyModulesReq.h"
#import "HFTakeModulesReq.h"
#import "HFDeleteHabitReq.h"
@implementation HFHomeProxy

- (void)getTimeLineData:(NSInteger)messageId
              direction:(NSInteger)direction
               complete:(timeLineSuccessBlock)block
{
    HFTimeLineReq *req = [[HFTimeLineReq alloc]init];
    req.id = messageId;
    req.direction = direction;
    req.size = 10;
    
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:@"TimeLineRes" completion:^(HFRetModel *ret) {
        TimeLineRes *res = (TimeLineRes *)ret.data;
        block(res.data,ret.bSuccess);
    
    }];
}

- (void)switchPush:(BOOL)isPush pushType:(HFPushType)type success:(complete)complete
{
    HFClosePushReq *req = [[HFClosePushReq alloc]init];
    switch (type) {
        case HFPushFuns:
            req.isFansPush = isPush ? 1 : 0;
            break;
        case HFPushPraise:
            req.isPraisePush = isPush ? 1 : 0;
            break;
        case HFpushComm:
            req.isCommPush = isPush ? 1 : 0;
            break;
        default:
            break;
    }
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:nil completion:^(HFRetModel *ret) {
        complete (ret.bSuccess);
    }];
}
- (void)switchPush:(NSDictionary *)pushDic success:(complete)complete
{
    HFClosePushReq * req = [[HFClosePushReq alloc] init];
    req.isPraisePush = [[pushDic objectForKey:@"praisePush"] integerValue];
    req.isCommPush = [[pushDic objectForKey:@"commenPush"] integerValue];
    req.isFansPush = [[pushDic objectForKey:@"fansPush"] integerValue];
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:nil completion:^(HFRetModel *ret) {
        complete (ret.bSuccess);
    }];
}
- (void)deleteMessage:(NSInteger)messageId success:(complete)complete
{
    HFDeleteMessageReq *req = [[HFDeleteMessageReq alloc]init];
    req.messageId = messageId;
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:nil completion:^(HFRetModel *ret) {
        complete (ret.bSuccess);
    }];
}

- (void)getModulesList:(modulesListSuccessBlock)block
{
    FHGetModulesReq *req = [[FHGetModulesReq alloc]init];
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:@"HiModuleListRes" completion:^(HFRetModel *ret) {
        HiModuleListRes *res = (HiModuleListRes *)ret.data;
        block(res.data,ret.bSuccess);
    }];
}

- (void)getMyModules:(getMyModulesBlock)block
{
    HFGetMyModulesReq *req = [[HFGetMyModulesReq alloc]init];
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:@"ModuleRes" completion:^(HFRetModel *ret) {
        ModuleRes *res = (ModuleRes *)ret.data;
        block(res.data,ret.bSuccess);
    }];
}

- (void)subscriptionModules:(NSString *)mudulesString completion:(complete)finished
{
    HFTakeModulesReq *req = [[HFTakeModulesReq alloc]init];
    req.subscriptionModelList = mudulesString;
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:nil completion:^(HFRetModel *ret) {
        finished(ret.bSuccess);
    }];
}

- (void)deleteHabit:(NSInteger)habitId completion:(complete)finished
{
    HFDeleteHabitReq *req = [[HFDeleteHabitReq alloc]init];
    req.habitId = habitId;
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:nil completion:^(HFRetModel *ret) {
        finished(ret.bSuccess);
    }];
}

- (void)getFollows:(HFGetFollowsReq *)req completion:(getFollowsBlock)block
{
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:@"FriendsRes" completion:^(HFRetModel *ret) {
        FriendsRes *res = (FriendsRes *)ret.data;
        block(res.data, ret.bSuccess);
    }];
}

- (void)getFuns:(HFGetFunsReq *)req completion:(getFunsBlock)block
{
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:@"FriendsRes" completion:^(HFRetModel *ret) {
        FriendsRes *res = (FriendsRes *)ret.data;
        block(res.data, ret.bSuccess);
    }];
}

@end
