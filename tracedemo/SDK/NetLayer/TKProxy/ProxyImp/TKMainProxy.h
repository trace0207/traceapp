//
//  TKMainProxy.h
//  tracedemo
//
//  Created by 罗田佳 on 15/11/14.
//  Copyright © 2015年 trace. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 *
 *  @param ack  返回一组 Ack
 */
typedef void (^tkMutableArgBlock)(NSArray<__kindof TK_JsonModelAck *> * ack);



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


/**
 *  上传图片
 *
 *  @param image <#image description#>
 *  @param block <#block description#>
 */
-(void)uploadImage:(UIImage *)image
          withType:(NSInteger)type
         withBlock:(hfAckBlock)block;


/**
 *  上传多张图片
 *
 *  @param images <#images description#>
 *  @param type   <#type description#>
 *  @param block  <#block description#>
 */
-(void)uploadMutableImages:(NSArray *)images
                              withtype:(NSInteger)type
                             withBlock:(tkMutableArgBlock)block;


/**
 *  通用 的多个 arg 请求队列
 *  不loading ，不提示 error
 *  @param args  <#args description#>
 *  @param block <#block description#>
 */
-(void)sendMutableArg:(NSArray<__kindof TK_JsonModelArg *><TK_HttpFileProtocol> *)args
            withBlock:(tkMutableArgBlock)block;


@end
