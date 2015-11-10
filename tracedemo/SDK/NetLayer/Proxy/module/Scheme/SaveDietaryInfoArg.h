//
//  SaveDietaryInfoArg.h
//  GuanHealth
//
//  Created by cmcc on 15/8/10.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HF_BaseArg.h"

@interface SaveDietaryInfoArg : HF_BaseArg

@property(nonatomic)NSInteger schemeId;
@property(nonatomic)NSInteger day;
@property(nonatomic)NSInteger mealType;
@property(nonatomic,strong)NSString * picAddr;
@property(nonatomic)NSInteger operateType;
@end
