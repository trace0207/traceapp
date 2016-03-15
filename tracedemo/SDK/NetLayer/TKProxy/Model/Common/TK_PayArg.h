//
//  TK_PayArg.h
//  tracedemo
//
//  Created by cmcc on 16/3/15.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "HF_BaseArg.h"

@interface TK_PayArg : HF_BaseArg

@property (nonatomic,strong)NSString *postrewardId;
@property (nonatomic)NSInteger payType;
@property (nonatomic)NSInteger fundType;
@property (nonatomic,strong)NSString *payAmount;
@property (nonatomic)NSInteger bigMoney;
@property (nonatomic,strong)NSString *clientIp;
@end
