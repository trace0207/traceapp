//
//  HFUploadResultReq.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/7/9.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseHttpReq.h"

@interface HFUploadResultReq : BaseHttpReq

@property (nonatomic, assign) NSInteger gameId;
@property (nonatomic, assign) NSInteger degree;
@property (nonatomic, assign) NSInteger flag;
@property (nonatomic, assign) NSInteger spendTime;

@end
