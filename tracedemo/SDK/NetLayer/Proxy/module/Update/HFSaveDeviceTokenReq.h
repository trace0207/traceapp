//
//  HFSaveDeviceTokenReq.h
//  GuanHealth
//
//  Created by 罗田佳 on 15/6/12.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseHttpReq.h"

@interface HFSaveDeviceTokenReq : BaseHttpReq

@property(nonatomic)int deviceType;
@property(nonatomic,strong)NSString * bdChannelId;
@property(nonatomic,strong)NSString * iOSCredentialType;

@end
