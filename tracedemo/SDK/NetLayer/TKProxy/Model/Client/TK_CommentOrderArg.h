//
//  TK_CommentOrderArg.h
//  tracedemo
//
//  Created by 罗田佳 on 15/12/2.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "HF_BaseArg.h"

@interface TK_CommentOrderArg : HF_BaseArg


@property (nonatomic,strong) NSString * showOrderId;
@property (nonatomic,strong) NSString * commenterId;
@property (nonatomic,strong) NSString * beCommentedId;
@property (nonatomic,strong) NSString * comment;

@end
