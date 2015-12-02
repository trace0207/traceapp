//
//  HF_HttpClient.h
//  GuanHealth
//
//  Created by cmcc on 15/8/10.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "TK_JsonModelHttpClient.h"


typedef void (^hfAckBlock)(HF_BaseAck * ack);

typedef NS_ENUM(NSInteger, HF_RequestError) {
    HF_CLASS_ERROR      = 601, //请求数据的class 不匹配
    HF_TIME_OUT          = 602, // 请求超时
    HF_JSONDECODE_ERROR = 603, // json数据解析异常
};


@interface HF_HttpClient : TK_JsonModelHttpClient

SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(HF_HttpClient, httpClient);
@property (nonatomic, assign) BOOL ISNetReachable;

-(void)sendRequestForHiifit:(HF_BaseArg *)arg withBolck:(hfAckBlock)block;

@end
