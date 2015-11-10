//
//  TK_jsonModelHttpClient.h
//  GuanHealth
//
//  Created by luotianjia on 15/8/9.
//  Copyright (c) 2015年 cmcc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"
#import "TK_JsonModelArg.h"
#import "TK_JsonModelAck.h"


typedef NS_ENUM(NSInteger, TK_RequestError) {
    TK_CLASS_ERROR      = 601, //请求数据的class 不匹配
    TK_TIME_OUT          = 602, // 请求超时
    TK_JSONDECODE_ERROR = 603, // json数据解析异常
};


typedef void (^jsonModelAckBlock)(TK_JsonModelAck * ack);

@interface TK_JsonModelHttpClient : AFHTTPRequestOperationManager




-(BOOL)isNetEnable;


-(void)sendRequestForJsonModel:(TK_JsonModelArg *)arg withAckBlock:(jsonModelAckBlock)block;

@end
