//
//  TKMainProxy.m
//  tracedemo
//
//  Created by 罗田佳 on 15/11/14.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKMainProxy.h"
#import "HF_HttpClient.h"
#import "HF_BaseArg.h"
#import "HF_BaseAck.h"
#import "TK_GetOrdersArg.h"
#import "TK_GetOrdersAck.h"
#import "TK_PraiseOrderArg.h"
#import "TK_PraiseRewardArg.h"
#import "TK_CommentOrderArg.h"
#import "TK_CommentRewardArg.h"
#import "TK_AppraiseBuyerArg.h"


@implementation TKMainProxy

/**
 *  获取晒单列表
 *
 *  @param type  晒单类型
 *  @param block 回调block
 */
-(void)getShowOrders:(NSInteger) type withBlock:(hfAckBlock)block{
    
    TK_GetOrdersArg * arg = [[TK_GetOrdersArg alloc] init];
    arg.type = type;
    arg.ackClassName = NSStringFromClass([TK_GetOrdersAck class]);
    [[HF_HttpClient httpClient]sendRequestForHiifit:arg withBolck:block];
}




/**
 *  赞 晒单
 *
 *  @param orderId 晒单ID
 *  @param userId  当前用户ID
 */
-(void)praiseShowOrders:(NSString *)orderId withUserId:(NSString * )userId withBlock:(hfAckBlock)block
{
    TK_PraiseOrderArg * arg = [[TK_PraiseOrderArg alloc] init];
    arg.showOrderId = orderId;
    arg.praiserId = userId;
    [[HF_HttpClient httpClient] sendRequestForHiifit:arg withBolck:block];
}

/**
 *  评论 晒单
 *
 *  @param orderId 晒单ID
 *  @param userId  当前用户ID
 *  @param comment  评论内容
 *  @param userId  被评论的userID
 */
-(void)commentShowOrders:(NSString *)orderId
              withUserId:(NSString * )fromUserId
             withContent:(NSString *)comment
         beCommentUserId:(NSString *)toUserId
               withBlock:(hfAckBlock)block
{
    
    TK_CommentOrderArg * arg = [[TK_CommentOrderArg alloc] init];
    arg.showOrderId = orderId;
    arg.commenterId = fromUserId;
    arg.beCommentedId = toUserId;
    arg.comment = comment;
    [[HF_HttpClient httpClient] sendRequestForHiifit:arg withBolck:block];

}


/**
 *  赞悬赏
 *
 *  @param orderId 悬赏ID
 *  @param userId  当前用户ID
 */
-(void)praiseReward:(NSString *)rewardId withUserId:(NSString * )userId withBlock:(hfAckBlock)block
{
    TK_PraiseRewardArg * arg = [[TK_PraiseRewardArg alloc] init];
    arg.postrewardId = rewardId;
    arg.praiserId = userId;
    [[HF_HttpClient httpClient] sendRequestForHiifit:arg withBolck:block];
}

/**
 *  评论悬赏
 *
 *  @param rewardId 悬赏ID
 *  @param userId  当前用户ID
 *  @param comment  评论内容
 *  @param userId  被评论的userID
 */
-(void)commentReward:(NSString *)rewardId
          withUserId:(NSString * )fromUserId
         withContent:(NSString *)comment
     beCommentUserId:(NSString *)toUserId
           withBlock:(hfAckBlock)block
{
    
    TK_CommentRewardArg * arg = [[TK_CommentRewardArg alloc] init];
    arg.postrewardId = rewardId;
    arg.commenterId = fromUserId;
    arg.beCommentedId = toUserId;
    arg.comment = comment;
    [[HF_HttpClient httpClient] sendRequestForHiifit:arg withBolck:block];
    
}


/**
 *  评价买手
 *
 *  @param buyerId 买手ID
 *  @param score   得分  1-5
 *  @param block   回调
 */
-(void)appraiseBuyer:(NSString *)buyerId
           withScore:(NSInteger)score
           withBlock:(hfAckBlock)block
{
    TK_AppraiseBuyerArg * arg = [[TK_AppraiseBuyerArg alloc] init];
    arg.score = score;
    arg.purchaserId = buyerId;
    [[HF_HttpClient httpClient] sendRequestForHiifit:arg withBolck:block];
}


@end
