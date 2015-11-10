//
//  HFDeleteWeiboReq.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/6/15.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseHttpReq.h"

@interface HFDeleteWeiboReq : BaseHttpReq

@property (nonatomic, assign) NSInteger weiboType;
@property (nonatomic, assign) NSInteger weiboId;

@end
