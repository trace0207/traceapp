//
//  TK_jsonModelHttpClient.h
//  GuanHealth
//
//  Created by luotianjia on 15/8/9.
//  Copyright (c) 2015年 cmcc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"
@class TK_JsonModelArg,TK_HttpFileData,TK_JsonModelAck;


typedef NS_ENUM(NSInteger, TK_RequestError) {
    TK_CLASS_ERROR      = 601, //请求数据的class 不匹配
    TK_TIME_OUT          = 602, // 请求超时
    TK_JSONDECODE_ERROR = 603, // json数据解析异常
};


typedef void (^jsonModelAckBlock)(TK_JsonModelAck * ack);

/**
 *  传送文件协议。 
    如果http请求中需要携带 file文件，则实现这个协议的方法
 */
@protocol TK_HttpFileProtocol <NSObject>
@required
-(TK_HttpFileData *)tkGetFileData;
@end



/**
 *  参数透传协议。  默认的接口全部实现该协议
    用于 arg 需要和 ack对应的场景。 会在 ack中透传回来 arg 中的原始数据
 */
@protocol TK_TransferArgProtocol <NSObject>
@required
-(id)tkTransferFromArg;
@end



@interface TK_JsonModelHttpClient : AFHTTPRequestOperationManager
-(BOOL)isNetEnable;
-(void)sendRequestForJsonModel:(TK_JsonModelArg *)arg withAckBlock:(jsonModelAckBlock)block;
@end
