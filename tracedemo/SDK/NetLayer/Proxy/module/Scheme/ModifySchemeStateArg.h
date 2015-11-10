//
//  ModifySchemeStateArg.h
//  GuanHealth
//
//  Created by cmcc on 15/8/10.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HF_BaseArg.h"

@interface ModifySchemeStateArg : HF_BaseArg
@property (nonatomic,assign)NSInteger operateType;
@property (nonatomic,assign)NSInteger schemeId;
@end
