//
//  HFMessageManager.m
//  GuanHealth
//
//  Created by shi_dongdong on 15/5/22.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "MessageBoxProxy.h"
#import "HFMessageBoxReq.h"
#import "HFMessageTypeInfoReq.h"
#import "HFMessageTypeInfoRes.h"
#import "HFMessageBoxRes.h"
#import "HFMessageSetReq.h"
@implementation MessageBoxProxy

- (void)hasUnReadMessageWithCompletion:(messageBlock)block
{
    HFMessageBoxReq * req = [[HFMessageBoxReq alloc] init];
    
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:@"HFMessageBoxRes" completion:^(HFRetModel *ret) {
        if (ret.bSuccess)
        {
            HFMessageBoxRes * res = (HFMessageBoxRes *)ret.data;
            block(res.data);
        }
    }];
}

- (void)reqMessageInfoWithType:(NSInteger)type
                        atPage:(NSInteger)page
                       success:(messageInfoSuccessBlock)successBlock
                          fail:(messageInfoFailBlock)fail
{
    HFMessageTypeInfoReq * req = [[HFMessageTypeInfoReq alloc] init];
    if (type == 1)
    {
        type = 2;
    }
    else if (type == 2)
    {
        type = 1;
    }
    req.messageType = type + 1;
    req.pageIndex = page;
    req.pageSize = kPageSize;
    
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:@"HFMessageTypeInfoRes" completion:^(HFRetModel *ret) {
        if (ret.bSuccess)
        {
            HFMessageTypeInfoRes * res = (HFMessageTypeInfoRes *)ret.data;
            successBlock(res.data);
        }
        else
        {
            fail();
        }
    }];
}

- (void)resetMessageInfoStateWithType:(NSInteger)type withCompletion:(messageStateBlock)block
{
    HFMessageSetReq * req = [[HFMessageSetReq alloc] init];
    if (type == 1)
    {
        type = 2;
    }
    else if (type == 2)
    {
        type = 1;
    }
    req.messageType = type + 1;
    
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:nil completion:^(HFRetModel *ret) {
        if (ret.bSuccess)
        {
            block();
        }
    }];
}

@end
