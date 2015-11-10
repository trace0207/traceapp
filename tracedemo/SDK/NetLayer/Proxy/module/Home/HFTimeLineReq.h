//
//  HFTimeLineReq.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/7/8.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseHttpReq.h"

@interface HFTimeLineReq : BaseHttpReq

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, assign) NSInteger direction;

@end
