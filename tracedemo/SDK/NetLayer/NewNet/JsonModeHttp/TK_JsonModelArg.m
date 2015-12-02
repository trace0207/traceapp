//
//  TK_JsonArg.m
//  GuanHealth
//
//  Created by cmcc on 15/8/9.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "TK_JsonModelArg.h"
#import "TK_JsonModelAck.h"
@implementation TK_JsonModelArg

-(instancetype)init{

    self = [super init];
    _timeout = 20.0f;
    return self;
}


-(Class)getAckClass
{
    NSString * className = NSStringFromClass([self class]);
    Class ackClass = NSClassFromString([className stringByReplacingOccurrencesOfString:@"Arg" withString:@"Ack"]);
    if(!ackClass || ![ackClass isSubclassOfClass:[self getDefaultAckClass]])
    {
   
        return [self getDefaultAckClass];
    }
    return ackClass;
}

-(Class)getDefaultAckClass
{
    return [TK_JsonModelAck class];
}

@end
