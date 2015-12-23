//
//  LoadSchemeInfoAck.h
//  GuanHealth
//
//  Created by cmcc on 15/8/10.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

@class HF_BaseAck;
#import "LoadSchemeDataAck.h"
@interface LoadSchemeInfoAck : HF_BaseAck
@property (nonatomic, strong) NSArray<LoadSchemeDataAck> *data;

@end
