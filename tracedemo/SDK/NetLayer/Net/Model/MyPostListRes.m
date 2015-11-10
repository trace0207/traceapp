//
//  MyPostListRes.m
//  GuanHealth
//
//  Created by hermit on 15/5/7.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "MyPostListRes.h"

@implementation MyPostListRes

- (void)transfrom
{
    for (int i = 0; i < [_data count]; i++) {
        PostDetailData * data = [_data objectAtIndex:i];
        [data transfrom];
    }
}

@end
