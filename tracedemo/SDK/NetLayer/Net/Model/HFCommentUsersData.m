//
//  HFCommentUsersData.m
//  GuanHealth
//
//  Created by shi_dongdong on 15/5/13.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFCommentUsersData.h"
#import "NSString+HFStrUtil.h"

@implementation HFCommentUsersData

- (void)transfrom
{
    _content = [NSString URLDecodedForString:_content];
}

@end
