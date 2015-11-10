//
//  HttpFileReq.m
//  GuanHealth
//
//  Created by cmcc on 15/7/23.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HttpFileReq.h"
#import "HttpFileResp.h"

@implementation HttpFileReq


-(NSString *)responseClassName{

    return NSStringFromClass([HttpFileResp class]);
}

@end
