//
//  HF_BaseAck.m
//  GuanHealth
//
//  Created by cmcc on 15/8/10.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HF_BaseAck.h"

@implementation HF_BaseAck

- (BOOL)sucess
{
    if (self.recode == 1)
    {
        return YES;
    }
    
    return NO;
}

@end
