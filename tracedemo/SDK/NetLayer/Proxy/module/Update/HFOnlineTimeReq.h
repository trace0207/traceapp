//
//  HFOnlineTimeReq.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/6/24.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseHttpReq.h"

@interface HFOnlineTimeReq : BaseHttpReq

@property (nonatomic,   copy) NSString *onlineDate;
@property (nonatomic, assign) NSInteger onlineSeconds;

@end
