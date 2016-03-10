//
//  TK_GetOrdersArg.h
//  tracedemo
//
//  Created by 罗田佳 on 15/11/14.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "HF_BaseArg.h"

@interface TK_GetOrdersArg : HF_BaseArg
@property (nonatomic) NSInteger categoryId;
@property (nonatomic) NSInteger pageOffset;
@property (nonatomic) NSInteger pageSize;
@end
