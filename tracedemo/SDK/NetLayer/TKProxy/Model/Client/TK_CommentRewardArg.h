//
//  TK_CommentRewardArg.h
//  tracedemo
//
//  Created by 罗田佳 on 15/12/2.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "HF_BaseArg.h"

@interface TK_CommentRewardArg : HF_BaseArg


@property (nonatomic,strong) NSString * postrewardId;
@property (nonatomic,strong) NSString * commenterId;
@property (nonatomic,strong) NSString * beCommentedId;
@property (nonatomic,strong) NSString * comment;

@end
