//
//  TK_JsonArg.m
//  GuanHealth
//
//  Created by cmcc on 15/8/9.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "TK_JsonModelArg.h"
#import "TK_JsonModelAck.h"
#import "NSString+HFStrUtil.h"


@interface TK_JsonModelArg()<TK_TransferArgProtocol>

@end

@implementation TK_JsonModelArg

-(instancetype)init{

    self = [super init];
    _method = @"POST";
    _timeoutstr = @"20";
    return self;
}


-(Class)getAckClass
{
    NSString * className = NSStringFromClass([self class]);
    
    Class ackClass = nil;
    
    if([NSString isStrEmpty:self.ackClassName])
    {
       ackClass = NSClassFromString([className stringByReplacingOccurrencesOfString:@"Arg" withString:@"Ack"]);
    }else
    {
        ackClass = NSClassFromString(self.ackClassName);
    }
    
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


-(id)tkTransferFromArg
{
    return self.transferFromArg;
}

//-(id)tkTransferFromArg
//{
//    return self.transferFromArg;
//}


@end
