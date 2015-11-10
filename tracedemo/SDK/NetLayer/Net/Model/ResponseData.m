//
//  ResponseData.m
//  GuanHealth
//
//  Created by hermit on 15/2/13.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ResponseData.h"

@implementation ResponseData


-(id)initWithError:(HFRequestError)errorCode{

    self = [super init];
    _requestSuccess = NO;
    _recode = errorCode;
    switch (errorCode) {
        case HFNetDisable:// = - 10085, // 网络不可用
            _msg = _T(@"HF_Common_CheckNet");
            break;
        case HFRequestTimeOut:// = -10086,//  请求超时
            _msg = @"请求超时";
            break;
        case HFRequestParamError: //= -10087,// 请求参数异常
            _msg = @"请求参数错误";
            break;
        case HFResponseParamError:// = -10088,// 反回的参数异常
            _msg = @"服务端数据异常";
            break;
        case HFRequestSendError: //= - 10089,//  请求过程异常， 可能是网络问题
            _msg = _T(@"HF_Common_CheckNet");
            break;
        default:
            _msg = @"请检查您的网络设置！";
            break;
    }
    return self;
}

- (id)init{
    self = [super init];
    if (self) {
        _msg = @"请检查您的网络设置！";
        _recode = HFNetDisable;
    }
    return self;
}


- (BOOL)success
{
    return self.recode == SUCCESS200 || self.recode == SUCCESS || self.recode == GETVERCODE_SUCCESS || self.recode == REQUEST_SUCCESS || self.recode == NO_SET_USERINFO || self.recode == SEND_CODE;
}

- (void)parseJSON:(id)dicJson{
    if (dicJson == nil || ![dicJson isKindOfClass:[NSDictionary class]]) {
        return ;
    }
    
    self.recode = [[dicJson valueForKey:@"recode"] integerValue];
    self.msg = [dicJson valueForKey:@"msg"];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName{
    return YES;
}

- (void)transfrom
{
    
}

@end
