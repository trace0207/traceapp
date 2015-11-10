//
//  HFBandProxy.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/9/7.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReportBandArg.h"
#import "BandHistoryAck.h"

@interface HFBandProxy : NSObject

//绑定和解绑,如果没有bandId为空为解绑
- (void)bindingBand:(NSString *)bandId withBlock:(hfAckBlock)block;

//上报手环数据
- (void)reportBandInfo:(ReportBandArg *)arg withBlock:(hfAckBlock)block;

//查询手环历史数据,day为多少天的数据，默认是7天数据
- (void)queryBandHistory:(NSInteger)day withBlock:(hfAckBlock)block;

//上报步数
- (void)uploadStep:(NSInteger)step withBlock:(hfAckBlock)block;

//4.9	设置手环短信提醒和来电提醒开关
- (void)uploadMsgPush:(BOOL)msgState  withPhonePush:(BOOL)phoneState withBlock:(hfAckBlock)block;

@end
