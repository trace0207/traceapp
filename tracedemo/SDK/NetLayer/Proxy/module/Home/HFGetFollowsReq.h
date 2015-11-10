//
//  HFGetFollowsReq.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/7/9.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseHttpReq.h"

@interface HFGetFollowsReq : BaseHttpReq

@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) NSInteger userId;

@end
