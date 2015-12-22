//
//  TK_jsonModelHttpClient.m
//  GuanHealth
//
//  Created by luotianjia on 15/8/9.
//  Copyright (c) 2015年 cmcc. All rights reserved.
//

#import "TK_JsonModelHttpClient.h"
#import "TK_JsonModelAck.h"
#import "TK_JsonModelArg.h"
#import "HF_BaseAck.h"
#import "TK_HttpFileData.h"
//#import "NSURL.h"
//typedef void (^jsonModelAckBlock)(TK_JsonModelAck * ack);


@implementation TK_JsonModelHttpClient



-(BOOL)isNetEnable{

    return YES;
}

-(void)sendRequestForJsonModel:(TK_JsonModelArg *)arg withAckBlock:(jsonModelAckBlock)block{

    
    NSString * requestURL = [arg.baseUrl stringByAppendingString:arg.relativeUrl];
    DDLogDebug(@"\nRequest : 【%@】 \nParams:%@",requestURL,[arg toDictionary]);
    Class ackClass = [arg getAckClass]; //NSClassFromString(arg.ackClassName);
        // 发送请求
    NSMutableURLRequest *request = nil;
    
    
    if([arg respondsToSelector:@selector(tkGetFileData)])
    {
        
        TK_HttpFileData * data = [arg performSelector:@selector(tkGetFileData) withObject:nil withObject:nil];
        
        DDLogDebug(@"\nwithData :%@",[data toDictionary]);
        request = [self.requestSerializer multipartFormRequestWithMethod:@"POST"
                                                               URLString:requestURL
                                                              parameters:[arg toDictionary]
                                               constructingBodyWithBlock: ^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFileData:data.tkData
                                        name:data.name
                                    fileName:data.displayName
                                    mimeType:data.type];
        }
                                                                   error:nil];
        
        
    }else
    {
      request  = [self.requestSerializer requestWithMethod:arg.method
                                                 URLString:requestURL
                                                parameters:[arg toDictionary]
                                                      error:nil];
    }
    
    
    request.timeoutInterval = arg.timeoutstr.integerValue;
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request
                                                                      success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DDLogDebug(@"\nAck : 【%@】 \nParams:%@",requestURL,responseObject);
        TK_JsonModelAck * ack = [self parserAckData:ackClass fromDictionary:responseObject];
        if([arg respondsToSelector:@selector(tkTransferFromArg)])
        {
            ack.transferFromArg = [arg performSelector:@selector(tkTransferFromArg) withObject:nil];
        }
        block(ack);
    }  failure:^(AFHTTPRequestOperation *operation, NSError *error){
        DDLogDebug(@"\nAck : 【%@】 error code = %@",requestURL,error);
        TK_JsonModelAck * ack = [[ackClass alloc]init];
        ack.error = error;
        if([arg respondsToSelector:@selector(tkTransferFromArg)])
        {
            ack.transferFromArg = [arg performSelector:@selector(tkTransferFromArg) withObject:nil];
        }
        block(ack);
    }];
    
    [self.operationQueue addOperation:operation];
}





/**
 将返回json解析成 class对象
 **/
-(TK_JsonModelAck *)parserAckData:(Class)class fromDictionary:(id)response{
    
    TK_JsonModelAck* resp ;
    if (response == nil || ![response isKindOfClass:[NSDictionary class]])
    {
        resp = [[class alloc]init];
    }else{
        resp  = [[class alloc]initWithDictionary:response error:nil];
    }
    return resp;
}



@end
