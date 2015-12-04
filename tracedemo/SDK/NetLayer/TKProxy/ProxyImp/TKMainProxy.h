//
//  TKMainProxy.h
//  tracedemo
//
//  Created by 罗田佳 on 15/11/14.
//  Copyright © 2015年 trace. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TKMainProxy : NSObject


/**
 *  获取晒单列表
 *
 *  @param type  晒单类型
 *  @param block 回调block
 */
-(void)getShowOrders:(NSInteger) type withBlock:(hfAckBlock)block;



/**
 *  赞 晒单
 *
 *  @param orderId 晒单ID
 *  @param userId  当前用户ID
 */
-(void)praiseShowOrders:(NSString *)orderId withUserId:(NSString * )userId withBlock:(hfAckBlock)block;

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
               withBlock:(hfAckBlock)block;


/**
 *  赞悬赏
 *
 *  @param rewardId 悬赏ID
 *  @param userId  当前用户ID
 */
-(void)praiseReward:(NSString *)rewardId withUserId:(NSString * )userId withBlock:(hfAckBlock)block;

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
           withBlock:(hfAckBlock)block;


/**
 *  评价买手
 *
 *  @param buyerId 买手ID
 *  @param score   得分  1-5
 *  @param block   回调
 */
-(void)appraiseBuyer:(NSString *)buyerId
           withScore:(NSInteger)score
           withBlock:(hfAckBlock)block;


@end
