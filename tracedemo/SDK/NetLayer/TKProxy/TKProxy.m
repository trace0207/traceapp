//
//  TKProxy.m
//  tracedemo
//
//  Created by 罗田佳 on 15/11/14.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKProxy.h"
#import "TKMainProxy.h"
#import "TKUserProxy.h"

@implementation TKProxy

SYNTHESIZE_SINGLETON_FOR_CLASS_PROTOTYPE(TKProxy, proxy);



-(NSString *)tkBaseUrl
{
    if(!_tkBaseUrl)
    {
        return @"http:www.baidu";
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
