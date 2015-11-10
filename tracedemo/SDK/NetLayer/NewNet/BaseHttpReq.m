//
//  BaseHttpReq.m
//  GuanHealth
//
//  Created by shi_dongdong on 15/5/21.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseHttpReq.h"
#import "ResponseData.h"

@implementation BaseHttpReq

- (id)init
{
    self = [super init];
    if (self)
    {
        _deviceid = [GlobInfo shareInstance].deviceid;
        _behaviorInfo = [GlobInfo shareInstance].behaviorInfo;
        _responseClassName = NSStringFromClass([ResponseData class]);
        _showToastStr = @"YES";
        _showLoadingStr = @"NO";
    }
    return self;
}

- (BOOL)showToast;
{
    return [@"YES" isEqualToString:_showToastStr];
}

- (BOOL)showLoading{

    return [@"YES" isEqualToString:_showLoadingStr];
}

-(NSString *)reqMothod
{
    return @"POST";
}

-(NSString *)reqUrl
{
    return @"www.fartherClass.com";
}

- (CGFloat)reqTimeOut
{
    return 60.0f;
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

@end
