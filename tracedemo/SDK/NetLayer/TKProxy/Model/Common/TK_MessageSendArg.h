//
//  TK_MessageSendArg.h
//  tracedemo
//
//  Created by cmcc on 16/4/17.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "HF_BaseArg.h"

@interface TK_MessageSendArg : HF_BaseArg

@property (nonatomic,strong) NSString * fromUserId;
@property (nonatomic,strong) NSString * fromUserRole;
@property (nonatomic,strong) NSString * toUserId;
@property (nonatomic,strong) NSString * toUserRole;
@property (nonatomic,strong) NSString * pageOffset;
@property (nonatomic,strong) NSString * pageSize;
@property (nonatomic,strong) NSString * content;


@end
