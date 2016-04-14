//
//  TK_GetBuyerHomePageListArg.h
//  tracedemo
//
//  Created by cmcc on 16/4/14.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "HF_BaseArg.h"

@interface TK_GetBuyerHomePageListArg : HF_BaseArg

@property (nonatomic,strong) NSString * purchaserId;
@property (nonatomic,assign) NSInteger  pageOffset;
@property (nonatomic,assign) NSInteger  pageSize;

@end
