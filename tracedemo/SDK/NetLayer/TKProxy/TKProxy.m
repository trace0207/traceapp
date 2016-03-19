//
//  TKProxy.m
//  tracedemo
//
//  Created by 罗田佳 on 15/11/14.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKProxy.h"


@implementation TKProxy

SYNTHESIZE_SINGLETON_FOR_CLASS_PROTOTYPE(TKProxy, proxy);



-(NSString *)tkBaseUrl
{
    if(!_tkBaseUrl)
    {
        return @"https://114.55.30.32";// 开发环境
//        return @"http://www.sungool.com"//域名
//        return @"http://183.131.13.104:8080";// 测试环境
//        return @"http://183.131.13.104:8080";// 预发布环境
//        return @"http://183.131.13.104:8080";// 商用环境
        
    }
    else return _tkBaseUrl;
}


-(TKMainProxy *)mainProxy{
    
    if(!_mainProxy)
    {
        _mainProxy = [[TKMainProxy alloc] init];
        DDLogInfo(@"init MainProxy object");
    }
    return _mainProxy;
}

-(TKUserProxy *)userProxy{

    if(!_userProxy){
    
        _userProxy = [[TKUserProxy alloc] init];
        DDLogInfo(@"init UserProxy ");
        
    }
    return _userProxy;
}


@end
