//
//  TK_PayAck.h
//  tracedemo
//
//  Created by cmcc on 16/3/15.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "HF_BaseAck.h"

@interface PayCharge : TK_BaseJsonModel

@property (nonatomic,copy) NSString * postrewardId;
@property (nonatomic,copy) NSDictionary * charge;

@end


@interface TK_PayAck : HF_BaseAck


@property (nonatomic,copy)PayCharge * data;

@end
