//
//  TK_AcceptRewardArg.h
//  tracedemo
//
//  Created by cmcc on 16/3/18.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "HF_BaseArg.h"

@interface TK_AcceptRewardArg : HF_BaseArg


@property (nonatomic,strong)NSString * purchaserId;
@property (nonatomic,strong)NSString * postrewardId;
@property (nonatomic,assign)NSInteger  purchaserDay;

@end
