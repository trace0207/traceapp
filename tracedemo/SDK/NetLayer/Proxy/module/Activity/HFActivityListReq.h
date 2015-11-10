//
//  HFActivityListReq.h
//  GuanHealth
//
//  Created by 栋栋 施 on 15/6/23.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseHttpReq.h"

@interface HFActivityListReq : BaseHttpReq

@property(nonatomic)NSInteger pageIndex;
@property(nonatomic)NSInteger pageSize;

@end
