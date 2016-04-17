//
//  TK_MessageCenterArg.h
//  tracedemo
//
//  Created by cmcc on 16/4/16.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "HF_BaseArg.h"

@interface TK_MessageCenterArg : HF_BaseArg
@property (nonatomic,strong) NSString * fromUserRole;
@property (nonatomic,strong) NSString * fromUserId;
@property (nonatomic,strong) NSString * toUserRole;
@property (nonatomic,strong) NSString * toUserId;
@property (nonatomic,assign) NSInteger pageOffset;
@property (nonatomic,assign) NSInteger pageSize;

@end
