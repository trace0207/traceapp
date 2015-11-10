//
//  HFModifyInfoReq.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/7/6.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseHttpReq.h"

@interface HFModifyInfoReq : BaseHttpReq

@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *year;
@property (nonatomic, copy) NSString *month;
@property (nonatomic, copy) NSString *day;

@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat weight;

@property (nonatomic, assign) NSInteger sex;

@end
