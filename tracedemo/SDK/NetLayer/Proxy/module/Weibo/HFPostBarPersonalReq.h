//
//  HFPostBarPersonalReq.h
//  GuanHealth
//
//  Created by 朱伟特 on 15/8/12.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseHttpReq.h"

@interface HFPostBarPersonalReq : BaseHttpReq

@property (nonatomic, assign) NSInteger weiboType;
@property (nonatomic, assign) NSInteger pageOffset;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, assign) NSInteger habitId;
@property (nonatomic, assign) NSInteger schemeId;

@end
