//
//  HF_BaseArg.h
//  GuanHealth
//
//  Created by cmcc on 15/8/10.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "TK_JsonModelArg.h"

@interface HF_BaseArg : TK_JsonModelArg

@property(nonatomic,strong)NSString * deviceId;
@property(nonatomic, copy) NSString <Ignore> * behaviorInfo;
@property(nonatomic,strong)NSString <Ignore> *showToastStr;
@property(nonatomic,strong)NSString <Ignore> *showLoadingStr;


@end
