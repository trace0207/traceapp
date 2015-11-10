//
//  HFModifyInfoReq.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/7/6.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFModifyInfoReq.h"

@implementation HFModifyInfoReq

- (instancetype)init
{
    self = [super init];
    if (self) {
        UserRes *user = [GlobInfo shareInstance].usr;
        self.nickName = user.nickName;
        self.sex = user.sex;
        self.height = user.height;
        self.weight = user.weight;
    }
    return self;
}

-(NSString *)reqUrl
{
    return @"CloudHealth/req/mobile/common/user/user-base-info!doModBaseInfo.action";
}

@end
