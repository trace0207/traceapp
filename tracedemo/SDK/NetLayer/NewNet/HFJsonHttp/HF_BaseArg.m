//
//  HF_BaseArg.m
//  GuanHealth
//
//  Created by cmcc on 15/8/10.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HF_BaseArg.h"
#import "ActionTools.h"

@implementation HF_BaseArg

-(instancetype)init{

    if (self)
    {
        self = [super init];
        _deviceId = [GlobInfo shareInstance].deviceid;
//        _behaviorInfo = [GlobInfo shareInstance].behaviorInfo;
        _showToastStr = @"YES";
        _showLoadingStr = @"NO";
    }
//    self.ackClassName = NSStringFromClass([HF_BaseAck class]);
    self.baseUrl = TKBaseURL;
    self.method = @"POST";
    self.relativeUrl = [ActionTools getRelativePathByArgClass:[self class]];
    return self;
}

-(Class)getDefaultAckClass
{
    return [HF_BaseAck class];
}

@end
