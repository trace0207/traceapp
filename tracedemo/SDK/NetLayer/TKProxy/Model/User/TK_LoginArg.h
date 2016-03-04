//
//  TK_LoginArg.h
//  tracedemo
//
//  Created by 罗田佳 on 15/11/20.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "HF_BaseArg.h"

@interface TK_LoginArg : HF_BaseArg

@property (nonatomic,copy)NSString * mobile;
@property (nonatomic,copy)NSString * password;
@property (nonatomic,assign)NSInteger role;
@property (nonatomic,copy)NSString *token;

@end
