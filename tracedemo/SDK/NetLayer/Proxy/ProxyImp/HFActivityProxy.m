//
//  HFActivityProxy.m
//  GuanHealth
//
//  Created by 栋栋 施 on 15/6/23.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFActivityProxy.h"
#import "HFMainActivityReq.h"
#import "HFMainActivityRes.h"
#import "HFActivityListReq.h"
#import "HFGetSudoDataReq.h"
#import "HFActivityWindowArg.h"
#import "HFActivityWindowAck.h"

@implementation HFActivityProxy

- (void)requestBannerActivitiesPosition:(NSInteger)position complete:(activityMainBlock)block
{
    HFMainActivityReq * req = [[HFMainActivityReq alloc] init];
    req.position = position;
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:@"HFMainActivityRes" completion:^(HFRetModel *ret) {
        if (ret.bSuccess)
        {
            HFMainActivityRes * res = (HFMainActivityRes *)ret.data;
            block(res.data,YES);
        }else {
            block(nil,NO);
        }
    }];
}

- (void)requestActivityListAtPageIndex:(NSInteger)index
                               Success:(activityListSuccessBlock)success
                                  Fail:(activityCompleteBlock)fail
{
    HFActivityListReq * req = [[HFActivityListReq alloc] init];
    req.pageIndex = index;
    req.pageSize = 10;

    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:@"HFActivityListRes" completion:^(HFRetModel *ret) {
        if (ret.bSuccess)
        {
            HFActivityListRes * res = (HFActivityListRes *)ret.data;
            success(res.data,res.total);
        }
        else
        {
            fail(NO);
        }
    }];
}

- (void)uploadResult:(HFUploadResultReq *)req completion:(uploadResult)finished
{
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:@"UploadGameRes" completion:^(HFRetModel *ret) {
        finished((UploadGameRes *)ret.data);
    }];
}

- (void)getSudoData:(getSudoBlock)block
{
    HFGetSudoDataReq *req = [[HFGetSudoDataReq alloc]init];
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:@"GetSudoKuRes" completion:^(HFRetModel *ret) {
        GetSudoKuRes *res = (GetSudoKuRes *)ret.data;
        block(res.data, ret.bSuccess);
    }];
}

- (void)loadActivityWindow:(hfAckBlock)block
{
    HFActivityWindowArg * arg = [[HFActivityWindowArg alloc] init];
    arg.ackClassName = NSStringFromClass([HFActivityWindowAck class]);
    [[HF_HttpClient httpClient] sendRequestForHiifit:arg withBolck:block];
}
@end
