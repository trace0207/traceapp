//
//  TK_BoxListArg.h
//  tracedemo
//
//  Created by cmcc on 16/4/17.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "HF_BaseArg.h"

@interface TK_BoxListArg : HF_BaseArg

@property (nonatomic,assign) NSInteger boxType;
@property (nonatomic,assign) NSInteger pageSize;
@property (nonatomic,assign) NSInteger pageOffset;

@end
