//
//  TK_GetUserPageDataListArg.h
//  tracedemo
//
//  Created by cmcc on 16/4/14.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "HF_BaseArg.h"

@interface TK_GetUserPageDataListArg : HF_BaseArg

@property (nonatomic,strong) NSString* userId;
@property (assign,nonatomic) NSInteger pageOffset;
@property (assign,nonatomic) NSInteger pageSize;

@end
