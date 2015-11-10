//
//  HFWeiboDeleteCommentReq.m
//  GuanHealth
//
//  Created by 朱伟特 on 15/8/17.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFWeiboDeleteCommentReq.h"

@implementation HFWeiboDeleteCommentReq
-(NSString *)reqUrl
{
    return @"CloudHealth/req/mobile/common/weibo/weibo-comment!delWeiboComment.action";
}

@end
