//
//  HF_HttpClient.h
//  GuanHealth
//
//  Created by cmcc on 15/8/10.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "TK_JsonModelHttpClient.h"
@class TK_JsonModelFileArg,HF_BaseAck;

typedef void (^hfAckBlock)(HF_BaseAck * ack);
typedef void (^hfMutableAckBlock)(NSArray<__kindof HF_BaseAck *> *acks);

typedef NS_ENUM(NSInteger, HF_RequestError) {
    HF_CLASS_ERROR      = 601, //请求数据的class 不匹配
    HF_TIME_OUT          = 602, // 请求超时
    HF_JSONDECODE_ERROR = 603, // json数据解析异常
};


@interface HF_HttpClient : TK_JsonModelHttpClient

SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(HF_HttpClient, httpClient);
@property (nonatomic, assign) BOOL ISNetReachable;

/**
 *  发送一个Arg请求
 *
 *  @param arg   <#arg description#>
 *  @param block <#block description#>
 */
-(void)sendRequestForHiifit:(HF_BaseArg *)arg withBolck:(hfAckBlock)block;

/**
 *  发送多个 Arg请求
 *
 *  @param args    <#args description#>
 *  @param loading <#loading description#>
 *  @param block   <#block description#>
 */
-(void)sendMUtableArgsForHiffit:(NSArray<__kindof HF_BaseArg *> *)args
                    showLoading:(BOOL) loading
                     toastError:(BOOL) toastError
                      withBlock:(hfMutableAckBlock) block;

@end
