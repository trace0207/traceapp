//
//  TKPayProxy.h
//  tracedemo
//
//  Created by cmcc on 16/3/14.
//  Copyright © 2016年 trace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import  "Pingpp.h"

@interface TKPayProxy : NSObject


-(void)aliPay:(NSObject *)charge
    urlScheme:(NSString *)scheme
withCompletion:(PingppCompletion)completionBlock;

@end
