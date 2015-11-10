//
//  HFGetPostListReq.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/7/9.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseHttpReq.h"

@interface HFGetPostListReq : BaseHttpReq

@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger pageOffset;
@property (nonatomic, assign) NSInteger pageSize;

@end
