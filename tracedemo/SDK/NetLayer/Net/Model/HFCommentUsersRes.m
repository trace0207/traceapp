//
//  HFCommentUsersRes.m
//  GuanHealth
//
//  Created by shi_dongdong on 15/5/13.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFCommentUsersRes.h"

@implementation HFCommentUsersRes

- (void)transfrom
{
    for (int i = 0; i < [_data count]; i++) {
        HFCommentUsersData * data = [_data objectAtIndex:i];
        [data transfrom];
    }
}

@end
