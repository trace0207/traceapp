//
//  CheckUpdateRes.h
//  GuanHealth
//
//  Created by cmcc on 15/6/4.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseHttpReq.h"

@interface CheckUpdateRes : ResponseData
@property(nonatomic)int strategyType;
@property(nonatomic,strong)NSString * updateUrl;
@property(nonatomic,strong)NSString * tips;
@property(nonatomic,strong)NSString * version;
@end
