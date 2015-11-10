//
//  HFSubmitCommentReq.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/7/8.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFSubmitCommentReq.h"

@implementation HFSubmitCommentReq
-(NSString *)reqUrl
{
    return @"CloudHealth/req/mobile/common/weibo/weibo-comment!publishWeiboComment.action";
}
@end
