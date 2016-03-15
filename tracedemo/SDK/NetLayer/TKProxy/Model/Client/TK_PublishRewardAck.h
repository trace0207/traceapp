//
//  TK_PublishRewardAck.h
//  tracedemo
//
//  Created by cmcc on 16/3/15.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "HF_BaseAck.h"


@interface PublishRewardData : TK_BaseJsonModel

//deposit = "1.6";
//rewardId = 64;

@property (nonatomic,strong)NSString * rewardId;
@property (nonatomic,strong)NSString * deposit;



@end


@interface TK_PublishRewardAck : HF_BaseAck

@property (nonatomic,strong) PublishRewardData * data;

@end
