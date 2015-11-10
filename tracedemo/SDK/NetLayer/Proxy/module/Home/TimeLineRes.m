//
//  TimeLineRes.m
//  GuanHealth
//
//  Created by hermit on 15/4/5.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "TimeLineRes.h"

@implementation TimeLineRes

- (void)transfrom
{
    for (int i = 0; i < [_data count]; i++)
    {
        Data * data = [_data objectAtIndex:i];
        [data transfrom];
    }
}


@end
