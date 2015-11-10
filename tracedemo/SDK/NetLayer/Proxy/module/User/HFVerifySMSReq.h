//
//  HFVerifySMSReq.h
//  GuanHealth
//
//  Created by 栋栋 施 on 15/6/18.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseHttpReq.h"

@interface HFVerifySMSReq : BaseHttpReq

@property(nonatomic,copy)NSString * phoneNumber;
@property(nonatomic)NSInteger codeType;
@property(nonatomic,copy)NSString * code;

@end
