//
//  HFGetMyModulesReq.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/7/9.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFGetMyModulesReq.h"

@implementation HFGetMyModulesReq
-(NSString *)reqUrl
{
    return @"CloudHealth/req/mobile/common/haimodule/hai-module!listUserModel.action";
}
@end
