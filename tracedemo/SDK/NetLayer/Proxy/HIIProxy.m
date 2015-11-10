//
//  HIIProxy.m
//  GuanHealth
//
//  Created by cmcc on 15/6/3.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HIIProxy.h"
#import "CommonProxy.h"


@implementation HIIProxy

SYNTHESIZE_SINGLETON_FOR_CLASS_PROTOTYPE(HIIProxy, shareProxy)
@synthesize userProxy;
@synthesize commProxy;
@synthesize habitProxy;
@synthesize messageBoxProxy;
@synthesize weiboProxy;
@synthesize activityProxy;
@synthesize homeProxy;
@synthesize schemeProxy;
@synthesize bandProxy;
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (UserProxy *)userProxy
{
    if (!userProxy)
    {
        userProxy = [[UserProxy alloc] init];
    }
    return userProxy;
}

- (CommonProxy *)commProxy
{
    if (!commProxy)
    {
        commProxy = [[CommonProxy alloc] init];
    }
    return commProxy;
}

- (HabitProxy *)habitProxy
{
    if (!habitProxy)
    {
        habitProxy = [[HabitProxy alloc] init];
    }
    return habitProxy;
}

- (MessageBoxProxy *)messageBoxProxy
{
    if (!messageBoxProxy)
    {
        messageBoxProxy = [[MessageBoxProxy alloc] init];
    }
    return messageBoxProxy;
}

- (HFWeiBoProxy *)weiboProxy
{
    if (!weiboProxy)
    {
        weiboProxy = [[HFWeiBoProxy alloc]init];
    }
    return weiboProxy;
}

- (HFActivityProxy *)activityProxy
{
    if (!activityProxy) {
        activityProxy = [[HFActivityProxy alloc] init];
    }
    return activityProxy;
}

- (HFHomeProxy *)homeProxy
{
    if (!homeProxy) {
        homeProxy = [[HFHomeProxy alloc]init];
    }
    return homeProxy;
}

-(HFSchemeProxy *)schemeProxy{

    if(!schemeProxy){
    
        schemeProxy = [[HFSchemeProxy alloc] init];
    }
    return schemeProxy;
}

- (HFBandProxy *)bandProxy
{
    if (!bandProxy)
    {
        bandProxy = [[HFBandProxy alloc] init];
    }
    return bandProxy;
}

@end
