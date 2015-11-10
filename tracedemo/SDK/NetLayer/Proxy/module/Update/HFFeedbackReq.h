//
//  HFFeedbackReq.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/7/9.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseHttpReq.h"

@interface HFFeedbackReq : BaseHttpReq

@property (nonatomic, assign) NSInteger source;
@property (nonatomic,   copy) NSString *suggest;
@property (nonatomic,   copy) NSString *telephone;
@property (nonatomic,   copy) NSString *email;

@end
