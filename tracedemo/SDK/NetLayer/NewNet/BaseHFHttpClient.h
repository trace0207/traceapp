//
//  BaseHFHttpClient.h
//  GuanHealth
//
//  Created by shi_dongdong on 15/5/22.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"
#import "BaseHttpReq.h"
#import "HFNetProcessHelper.h"
#import "Reachability.h"

@interface BaseHFHttpClient : AFHTTPRequestOperationManager

@property (nonatomic, assign) BOOL bNetReachable;

@property (nonatomic, assign) AFNetworkReachabilityStatus netState;

SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(BaseHFHttpClient, shareInstance);

- (void)beginHttpRequest:(BaseHttpReq *)req
                   parse:(NSString *)parseClass
              completion:(completionRequestBlock)block;

- (void)upLoadImage:(UIImage *)image
        httpRequest:(BaseHttpReq *)req
              parse:(NSString *)parseClass
         completion:(completionRequestBlock)block;





/**
 上传图片
 **/
//-(void)uploadImageFile:(UIImage *)image toActionRelativePath:(NSString * )relativePath responseBlock:(responseBlock)block;


/**
 上传文件
 **/
//-(void)uploadFile:(HttpFileReq *)req responseBlock:(responseBlock)block;

///**
// 下载文件
// */
//-(void)downLoadFile:(HttpFileReq *)req responseBlock:(responseBlock)block;


/**
  发送Request请求
 **/
-(void)sendRequest:(BaseHttpReq *)req
     responseBlock:(responseBlock)respBlock;


/**
 发送Post请求
 **/
-(void)sendPost:(BaseHttpReq *)req
     responseBlock:(responseBlock)respBlock;

@end
