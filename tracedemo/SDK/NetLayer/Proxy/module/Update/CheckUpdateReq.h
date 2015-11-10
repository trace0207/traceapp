//
//  CheckUpdateReq.h
//  GuanHealth
//
//  Created by cmcc on 15/6/4.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseHttpReq.h"

@interface CheckUpdateReq : BaseHttpReq

@property(nonatomic)int deviceType;
@property(nonatomic,strong)NSString * version;
@property(nonatomic,strong)NSString * credentialType;

@end
