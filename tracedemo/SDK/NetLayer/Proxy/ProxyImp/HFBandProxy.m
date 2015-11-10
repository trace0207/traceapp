//
//  HFBandProxy.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/9/7.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "HFBandProxy.h"
#import "BindingArg.h"
#import "BandHistoryArg.h"
#import "HFUploadArg.h"
#import "HFBandRemindSetArg.h"
@implementation HFBandProxy

- (void)bindingBand:(NSString *)bandId withBlock:(hfAckBlock)block
{
    BindingArg * arg = [[BindingArg alloc] init];
    if (bandId.length>0) {
        arg.bandDeviceId = bandId;
    }
    [[HF_HttpClient httpClient]sendRequestForHiifit:arg withBolck:block];
}

- (void)reportBandInfo:(ReportBandArg *)arg withBlock:(hfAckBlock)block
{
    [[HF_HttpClient httpClient]sendRequestForHiifit:arg withBolck:block];
}

- (void)queryBandHistory:(NSInteger)day withBlock:(hfAckBlock)block
{
    BandHistoryArg *arg = [[BandHistoryArg alloc]init];
    arg.day = day;
    arg.ackClassName = NSStringFromClass([BandHistoryAck class]);
    [[HF_HttpClient httpClient]sendRequestForHiifit:arg withBolck:block];
}

- (void)uploadStep:(NSInteger)step withBlock:(hfAckBlock)block
{
    HFUploadArg *arg = [[HFUploadArg alloc]init];
    arg.step = step;
    [[HF_HttpClient httpClient]sendRequestForHiifit:arg withBolck:block];
}

- (void)uploadMsgPush:(BOOL)msgState  withPhonePush:(BOOL)phoneState withBlock:(hfAckBlock)block
{
    HFBandRemindSetArg * arg = [[HFBandRemindSetArg alloc] init];
    arg.isMessagePush = msgState;
    arg.isMobilePush = phoneState;
    [[HF_HttpClient httpClient]sendRequestForHiifit:arg withBolck:block];
}


@end
