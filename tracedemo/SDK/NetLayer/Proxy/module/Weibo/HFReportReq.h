//
//  HFReportReq.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/6/15.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseHttpReq.h"

@interface HFReportReq : BaseHttpReq

@property (nonatomic, assign) NSInteger weiboType;
@property (nonatomic, assign) NSInteger weiboId;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, assign) NSInteger informType;

@end
