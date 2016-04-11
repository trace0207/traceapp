//
//  TK_RewardListForBuyerArg.h
//  tracedemo
//  买手端悬赏广场
//  Created by cmcc on 16/3/16.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "HF_BaseArg.h"

@interface TK_RewardListForBuyerArg : HF_BaseArg


@property (nonatomic,copy)NSString * categoryId;
@property (nonatomic,assign)NSInteger pageOffset;
@property (nonatomic,assign)NSInteger pageSize;
@property (nonatomic,assign)NSInteger rewardStatus;
@property (nonatomic,copy)NSString * brandId;

@end
