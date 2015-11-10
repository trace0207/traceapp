//
//  HFLikeUsersReq.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/7/8.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseHttpReq.h"

@interface HFLikeUsersReq : BaseHttpReq

@property (nonatomic, assign) NSInteger weiboType;
@property (nonatomic, assign) NSInteger weiboId;
@property (nonatomic, assign) NSInteger pageOffset;
@property (nonatomic, assign) NSInteger pageSize;

@end
