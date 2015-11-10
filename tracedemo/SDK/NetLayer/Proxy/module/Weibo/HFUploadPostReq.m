//
//  HFUploadPostReq.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/7/10.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFUploadPostReq.h"

@implementation HFUploadPostReq

- (NSString *)reqUrl
{
    if (self.tiebaId>0) {
        return @"CloudHealth/req/mobile/common/weibo/weibo!updateTieba.action";
    }else {
        return @"CloudHealth/req/mobile/common/weibo/weibo!recordWeibo.action";
    }
}

@end
