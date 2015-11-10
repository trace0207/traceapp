//
//  HFLoginReq.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/6/16.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseHttpReq.h"

@interface HFLoginReq : BaseHttpReq

@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *passWord;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *bdChannelId;


@property (nonatomic, assign) NSInteger sourceAccountType;
@property (nonatomic, assign) NSInteger sex;
@property (nonatomic, assign) int deviceType;
//@property (nonatomic, assign) long lastUpdateTime;

@end
