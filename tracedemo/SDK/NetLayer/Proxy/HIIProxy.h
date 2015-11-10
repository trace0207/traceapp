//
//  HIIProxy.h
//  GuanHealth
//
//  Created by cmcc on 15/6/3.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserProxy.h"
#import "CommonProxy.h"
#import "HabitProxy.h"
#import "MessageBoxProxy.h"
#import "HFWeiBoProxy.h"
#import "HFActivityProxy.h"
#import "HFHomeProxy.h"
#import "HFSchemeProxy.h"
#import "HFBandProxy.h"
@interface HIIProxy : NSObject

SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(HIIProxy, shareProxy)

@property (nonatomic,strong,readonly)UserProxy * userProxy;
@property (nonatomic,strong,readonly)CommonProxy * commProxy;
@property (nonatomic,strong,readonly)HabitProxy * habitProxy;
@property (nonatomic,strong,readonly)MessageBoxProxy * messageBoxProxy;
@property (nonatomic,strong,readonly)HFWeiBoProxy *weiboProxy;
@property (nonatomic,strong,readonly)HFActivityProxy * activityProxy;
@property (nonatomic,strong,readonly)HFHomeProxy *homeProxy;
@property (nonatomic,strong,readonly)HFSchemeProxy *schemeProxy;
@property (nonatomic,strong,readonly)HFBandProxy * bandProxy;
@end
