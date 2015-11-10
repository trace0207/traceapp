//
//  HFCheckVercodeReq.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/7/7.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseHttpReq.h"

@interface HFCheckVercodeReq : BaseHttpReq

@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, assign) NSInteger codeType;

@end
