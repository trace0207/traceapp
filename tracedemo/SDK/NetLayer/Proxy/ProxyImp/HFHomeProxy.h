//
//  HFHomeProxy.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/7/8.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HiModuleListRes.h"
#import "ModuleRes.h"
#import "FriendsRes.h"
#import "HFGetFollowsReq.h"
#import "HFGetFunsReq.h"
#import "HFGetPostListReq.h"

@class Data;

typedef void (^timeLineSuccessBlock)(NSArray<Data> *data,BOOL success);
typedef void(^modulesListSuccessBlock)(NSArray<HiModuleData> *modulesList, BOOL success);
typedef void(^getMyModulesBlock)(NSArray<ModelData>*myModules, BOOL success);
typedef void(^getFollowsBlock)(NSArray<FriendsData>  *friends,BOOL success);
typedef void(^getFunsBlock)(NSArray<FriendsData>  *funs,BOOL success);

@interface HFHomeProxy : NSObject

- (void)getTimeLineData:(NSInteger)messageId
              direction:(NSInteger)direction
               complete:(timeLineSuccessBlock)block;

//- (void)switchPush:(BOOL)isPush pushType:(HFPushType)type success:(complete)complete;

- (void)switchPush:(NSDictionary *)pushDic success:(complete)complete;

- (void)deleteMessage:(NSInteger)messageId success:(complete)complete;

- (void)getModulesList:(modulesListSuccessBlock)block;

- (void)getMyModules:(getMyModulesBlock)block;

- (void)subscriptionModules:(NSString *)mudulesString completion:(complete)finished;

- (void)deleteHabit:(NSInteger)habitId completion:(complete)finished;

- (void)getFollows:(HFGetFollowsReq *)req completion:(getFollowsBlock)block;

- (void)getFuns:(HFGetFunsReq *)req completion:(getFunsBlock)block;

@end
