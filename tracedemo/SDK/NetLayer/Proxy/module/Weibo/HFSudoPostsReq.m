//
//  HFSudoPostsReq.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/7/9.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFSudoPostsReq.h"

@implementation HFSudoPostsReq
-(NSString *)reqUrl
{
    return @"CloudHealth/req/mobile/common/weibo/weibo!listWeiboByType.action";
}
@end
