//
//  TK_JsonModelAck.m
//  GuanHealth
//
//  Created by cmcc on 15/8/9.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "TK_JsonModelAck.h"

@implementation TK_JsonModelAck


-(instancetype)init
{
    if(!self)
    {
        self = [super init];
    }
    return  self;
}


-(instancetype)initWithTKError:(NSError *)error
{
    if(!self)
    {
        self = [super init];
    }
    self.error = error;
    return self;
}

@end
