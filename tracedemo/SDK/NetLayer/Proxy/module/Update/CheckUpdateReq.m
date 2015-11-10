//
//  CheckUpdateReq.m
//  GuanHealth
//
//  Created by cmcc on 15/6/4.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "CheckUpdateReq.h"

@implementation CheckUpdateReq

- (BOOL)showToast
{
    return NO;
}

- (NSString *)reqMothod
{
    return @"POST";
}

-(NSString *)reqUrl
{
    return @"CloudHealth/mobile/common/app/app-version!getVersionStrategy.action";
}


@end
