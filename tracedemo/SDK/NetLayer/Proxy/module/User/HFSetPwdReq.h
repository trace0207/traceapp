//
//  HFSetPwdReq.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/6/17.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseHttpReq.h"

@interface HFSetPwdReq : BaseHttpReq

@property (nonatomic, copy)NSString *phoneNumber;
@property (nonatomic, copy)NSString *passWord;
@property (nonatomic, assign) NSInteger deviceType;

@end
