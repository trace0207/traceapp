//
//  HF_BaseAck.m
//  GuanHealth
//
//  Created by cmcc on 15/8/10.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

@class HF_BaseAck;

@implementation HF_BaseAck


-(instancetype)init
{

    self = [super init];
    self.successCode = @"200";
    return self;
}


- (BOOL)sucess
{
    if (self.recode == self.successCode.integerValue)
    {
        return YES;
    }
    
    return NO;
}

-(NSInteger)recode
{

    if(self.error)
    {
        return self.error.code;
    }
    
    return _recode;
}

-(NSString *)msg
{
    if(self.error)
    {
        return [self changeMsgFromErrorCode:self.error.code];
    }else
    return _msg;
}

-(NSString *)changeMsgFromErrorCode:(NSInteger)code
{
    NSString * msg = @"请求错误";
    switch (code) {
    
            //  处理 HTTP 请求 NFNetworking 返回的 Error
        case -1016:
            msg = @"网络请求返回了错误信息";
            break;
        default:
            break;
    }
    return msg;
}

@end
