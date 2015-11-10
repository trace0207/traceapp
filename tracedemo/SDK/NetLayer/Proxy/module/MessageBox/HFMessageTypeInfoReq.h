//
//  HFMessageTypeInfoReq.h
//  GuanHealth
//
//  Created by shi_dongdong on 15/5/22.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseHttpReq.h"

@interface HFMessageTypeInfoReq : BaseHttpReq

@property(nonatomic)NSInteger messageType;
@property(nonatomic)NSInteger pageIndex;
@property(nonatomic)NSInteger pageSize;
@end
