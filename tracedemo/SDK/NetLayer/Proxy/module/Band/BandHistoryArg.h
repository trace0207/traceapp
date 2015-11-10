//
//  BandHistoryArg.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/9/7.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "HF_BaseArg.h"

@interface BandHistoryArg : HF_BaseArg
@property (nonatomic, assign) NSInteger day;//默认为7天，最大不能超过31天
@end
