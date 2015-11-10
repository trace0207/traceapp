//
//  HFMessageTypeInfoRes.m
//  GuanHealth
//
//  Created by shi_dongdong on 15/5/21.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFMessageTypeInfoRes.h"
#import "NSString+HFStrUtil.h"


@implementation HFMessageTypeInfoData

- (void)transfrom
{
    _content = [NSString URLDecodedForString: _content];
    _goalContent = [NSString URLDecodedForString:_goalContent];
}

@end

@implementation HFMessageTypeInfoRes


- (void)transfrom
{
    for (int i = 0; i < [_data count]; i++)
    {
        HFMessageTypeInfoData * data = [_data objectAtIndex:i];
        [data transfrom];
    }
}

@end
