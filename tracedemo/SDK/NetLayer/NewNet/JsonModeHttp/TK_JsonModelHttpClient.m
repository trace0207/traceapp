//
//  TK_jsonModelHttpClient.m
//  GuanHealth
//
//  Created by luotianjia on 15/8/9.
//  Copyright (c) 2015年 cmcc. All rights reserved.
//

#import "TK_JsonModelHttpClient.h"
#import "TK_JsonModelAck.h"
#import "HF_BaseAck.h"
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
    
//    // 对参数校验
//    if(![ackClass isSubclassOfClass:TK_JsonModelAck.class]){
//        
//        NSError * classError = [[NSError alloc] initWithDomain:@"ClassError" code:TK_CLASS_ERROR userInfo:nil];
//        TK_JsonModelAck * ack = [[TK_JsonModelAck alloc]init];
//        ack.error = classError;
//        block(ack);
//        return;
//    }
        // 发送请求
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:arg.method URLString:requestURL parameters:[arg toDictionary] error:nil];
    request.timeoutInterval = arg.timeoutstr.integerValue;
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DDLogDebug(@"\nAck : 【%@】 \nParams:%@",requestURL,responseObject);
        TK_JsonModelAck * ack = [self parserAckData:ackClass fromDictionary:responseObject];
        block(ack);
    }  failure:^(AFHTTPRequestOperation *operation, NSError *error){
        DDLogDebug(@"\nAck : 【%@】 error code = %@",requestURL,error);
        TK_JsonModelAck * ack = [[ackClass alloc]init];
        ack.error = error;
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
