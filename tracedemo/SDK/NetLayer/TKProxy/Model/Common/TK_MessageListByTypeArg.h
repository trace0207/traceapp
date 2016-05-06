//
//  TK_MessageListByTypeArg.h
//  tracedemo
//
//  Created by cmcc on 16/4/17.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "HF_BaseArg.h"

@interface TK_MessageListByTypeArg : HF_BaseArg

@property (nonatomic,strong) NSString * fromUserId;
@property (nonatomic,strong) NSString * fromUserRole;
@property (nonatomic,strong) NSString * toUserId;
@property (nonatomic,strong) NSString * toUserRole;
@property (nonatomic,assign) NSInteger  pageOffset;
@property (nonatomic,assign) NSInteger  pageSize;

@end
