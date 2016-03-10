//
//  TK_ModifyPasswordArg.h
//  tracedemo
//
//  Created by cmcc on 16/3/6.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "HF_BaseArg.h"

@interface TK_ModifyPasswordArg : HF_BaseArg

@property (nonatomic,copy) NSString *mobile;
@property (nonatomic,copy) NSString *smsCode;
@property (nonatomic,copy) NSString *password;
@property (nonatomic,assign) NSInteger role;

@end
