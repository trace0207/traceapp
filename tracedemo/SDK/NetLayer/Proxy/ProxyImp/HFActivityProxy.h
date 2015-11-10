//
//  HFActivityProxy.h
//  GuanHealth
//
//  Created by 栋栋 施 on 15/6/23.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HFActivityListRes.h"
#import "HFUploadResultReq.h"
#import "UploadGameRes.h"
#import "GetSudoKuRes.h"
#import "HF_BaseAck.h"
#import "HF_BaseArg.h"
#import "HF_HttpClient.h"

@class HFMainActivityData;

//typedef void (^activityMainSuccessBlock)(NSArray * data);
typedef void (^activityMainBlock)(NSArray *data, BOOL success);
typedef void(^uploadResult)(UploadGameRes *result);
typedef void (^activityListSuccessBlock)(NSArray<HFActivityListData> * data,NSInteger total);
typedef void (^activityCompleteBlock)(BOOL finish);
typedef void(^getSudoBlock)(GetSudoKuData *data, BOOL success);

@interface HFActivityProxy : NSObject

- (void)requestBannerActivitiesPosition:(NSInteger)position
                               complete:(activityMainBlock)block;

- (void)requestActivityListAtPageIndex:(NSInteger)index
                               Success:(activityListSuccessBlock)success
                                  Fail:(activityCompleteBlock)fail;

- (void)uploadResult:(HFUploadResultReq *)req completion:(uploadResult)finished;

- (void)getSudoData:(getSudoBlock)block;

- (void)loadActivityWindow:(hfAckBlock)block;//获取活动浮窗
@end
