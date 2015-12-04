//
//  TK_AppraiseBuyerArg.h
//  tracedemo
//
//  Created by 罗田佳 on 15/12/2.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "HF_BaseArg.h"

@interface TK_AppraiseBuyerArg : HF_BaseArg
@property (nonatomic,strong) NSString * purchaserId;
@property (assign,nonatomic) NSInteger score;

@end
