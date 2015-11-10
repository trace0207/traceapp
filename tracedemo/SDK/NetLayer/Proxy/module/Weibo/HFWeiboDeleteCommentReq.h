//
//  HFWeiboDeleteCommentReq.h
//  GuanHealth
//
//  Created by 朱伟特 on 15/8/17.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseHttpReq.h"

@interface HFWeiboDeleteCommentReq : BaseHttpReq

@property (nonatomic, assign) NSInteger weiboType;
@property (nonatomic, assign) NSInteger commentId;
@property (nonatomic, assign) NSInteger weiboId;

@end
