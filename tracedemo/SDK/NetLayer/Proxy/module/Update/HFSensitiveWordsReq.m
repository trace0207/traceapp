//
//  HFSensitiveWordsReq.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/6/16.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFSensitiveWordsReq.h"

@implementation HFSensitiveWordsReq
-(NSString *)reqUrl
{
    return @"CloudHealth/req/mobile/common/weibo/sensitive!getAllSensitiveWords.action";
}
@end
