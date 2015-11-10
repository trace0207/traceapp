//
//  HFBindPhoneReq.h
//  GuanHealth
//
//  Created by 栋栋 施 on 15/6/18.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseHttpReq.h"

@interface HFBindPhoneReq : BaseHttpReq

@property(nonatomic,copy)NSString * phoneNumber;
@property(nonatomic,copy)NSString * passWord;
@property(nonatomic)NSInteger sourceAccountType;
@property(nonatomic)NSInteger deviceType;
@end
