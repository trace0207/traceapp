//
//  UploadSportDataArg.h
//  GuanHealth
//
//  Created by cmcc on 15/8/10.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HF_BaseArg.h"

@interface UploadSportDataArg : HF_BaseArg

@property (nonatomic,assign)NSInteger schemeId;
@property (nonatomic,assign)NSInteger type;
@property (nonatomic,assign)NSInteger sportId;
@property (nonatomic,assign)NSInteger day;
@end
