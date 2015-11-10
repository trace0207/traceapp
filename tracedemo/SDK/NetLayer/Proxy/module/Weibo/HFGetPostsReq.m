//
//  HFGetPostsReq.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/7/9.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFGetPostsReq.h"

@implementation HFGetPostsReq
-(NSString *)reqUrl
{
    return @"CloudHealth/req/mobile/common/weibo/weibo!userWeiBoList.action";
}
@end
