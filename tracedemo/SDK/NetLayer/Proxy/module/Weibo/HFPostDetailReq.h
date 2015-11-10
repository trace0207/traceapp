//
//  HFPostDetailReq.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/7/10.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseHttpReq.h"

@interface HFPostDetailReq : BaseHttpReq
@property (nonatomic, assign) NSInteger weiboType;
@property (nonatomic, assign) NSInteger weiboId;
@end
