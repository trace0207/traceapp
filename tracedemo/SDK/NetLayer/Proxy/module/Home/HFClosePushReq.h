//
//  HFClosePushReq.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/7/8.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseHttpReq.h"

@interface HFClosePushReq : BaseHttpReq

@property (nonatomic, assign) NSInteger isFansPush;
@property (nonatomic, assign) NSInteger isPraisePush;
@property (nonatomic, assign) NSInteger isCommPush;

@end
