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



-(TKMainProxy *)mainProxy{
    
    if(!_mainProxy)
    {
        _mainProxy = [[TKMainProxy alloc] init];
        DDLogInfo(@"init MainProxy object");
    }
    return _mainProxy;
}


@end
