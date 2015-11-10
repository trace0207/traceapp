//
//  HFSudoPostsReq.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/7/9.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseHttpReq.h"

@interface HFSudoPostsReq : BaseHttpReq

@property (nonatomic, assign) NSInteger weiboType;
@property (nonatomic, assign) NSInteger pageOffset;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) NSInteger modelId;
@property (nonatomic, assign) NSInteger habitId;

@end
