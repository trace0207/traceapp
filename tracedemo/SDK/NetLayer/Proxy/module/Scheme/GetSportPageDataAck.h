//
//  GetSportPageDataAck.h
//  GuanHealth
//
//  Created by luotianjia on 15/8/10.
//  Copyright (c) 2015年 cmcc. All rights reserved.
//

@class HF_BaseAck;
#import "GetSuggestAck.h"

@interface GetSportPageDataAck : HF_BaseAck
@property (nonatomic, strong) GetSuggestData * data;
@end
