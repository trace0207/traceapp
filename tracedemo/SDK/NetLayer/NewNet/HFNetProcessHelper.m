//
//  HFRetModel.m
//  GuanHealth
//
//  Created by shi_dongdong on 15/5/27.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFNetProcessHelper.h"

typedef ResponseData* (^ParseClassBlock)(NSDictionary *json, Class class);

ParseClassBlock parseClassTemplate = ^(NSDictionary *json, Class class) {
    NSError* error = nil;
    id Res = [[class alloc] initWithDictionary:json error:&error];
    [Res transfrom];
    return Res;
};

@implementation HFRetModel

@end


@implementation HFNetProcessHelper

+ (BOOL)checkCode:(NSInteger)code
{
    return code == SUCCESS || code == GETVERCODE_SUCCESS || code == REQUEST_SUCCESS || code == NO_SET_USERINFO || code == SEND_CODE;
}


/**
 将返回json解析成 class对象
 **/
+(ResponseData *)parserResponseData:(Class)class fromDictionary:(id)response{

    ResponseData* resp = [[ResponseData alloc] init];
    if (response == nil || ![response isKindOfClass:[NSDictionary class]])
    {
        resp = [[ResponseData alloc]initWithError:HFResponseParamError];
    }else{
        resp  = parseClassTemplate(response,class);
    }
    return resp;
}


+ (void)processResponseObject:(id)response
                    showToast:(BOOL)bShow
                    parseName:(NSString *)name
                   compeltion:(completionRequestBlock)block
{
    
    HFRetModel * ret = [[HFRetModel alloc] init];
    if (response == nil || ![response isKindOfClass:[NSDictionary class]])
    {
        ret.code = - 10086;
        ret.error = _T(@"HF_Common_System_Notes");
    }
    else
    {
        ret.code = [[response valueForKey:@"recode"] integerValue];
        ret.error = [response valueForKey:@"msg"];
    }
    ret.bSuccess = [self checkCode:ret.code];
    
    if (ret.bSuccess)
    {
        Class class = NSClassFromString(name);
        ResponseData * data = parseClassTemplate(response,class);
        ret.data = data;
    }
    
    block(ret);
    
    if (!ret.bSuccess)
    {
        if (bShow)
        {
            if (![ret.error isKindOfClass:[NSNull class]])
            {
                [[HFHUDView shareInstance] ShowTips:ret.error delayTime:1.0 atView:NULL];
            }
        }
    }
}


+ (void)netErrorProcessCenter:(NSString *)error
                    showToast:(BOOL)bShow
                   compeltion:(completionRequestBlock)block
{
    HFRetModel * ret = [[HFRetModel alloc] init];
    ret.code = - 10086;
    ret.error = error;
    ret.bSuccess = NO;
    
    block(ret);
    
    if (bShow)
    {
        if (![ret.error isKindOfClass:[NSNull class]])
        {
            [[HFHUDView shareInstance] ShowTips:ret.error delayTime:1.0 atView:NULL];
        }
    }
}

@end
