//
//  TKProxy.h
//  tracedemo
//
//  Created by 罗田佳 on 15/11/14.
//  Copyright © 2015年 trace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKMainProxy.h"
#import "TKUserProxy.h"

@interface TKProxy : NSObject
SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(TKProxy, proxy)
@property (nonatomic,strong)TKMainProxy * mainProxy;
@property (nonatomic,strong)TKUserProxy * userProxy;
@end
