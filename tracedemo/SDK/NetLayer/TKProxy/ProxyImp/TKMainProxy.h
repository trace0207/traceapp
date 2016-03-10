//
//  TKMainProxy.h
//  tracedemo
//
//  Created by 罗田佳 on 15/11/14.
//  Copyright © 2015年 trace. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TKPublishShowGoodsArg;




@interface TKMainProxy : NSObject


/**
 发布晒单
 **/
-(void)publishShowGoods:(TKPublishShowGoodsArg *)arg withBlock:(hfAckBlock)block;



/**
 消费者C 端晒单池
 **/
-(void)getShowOrders:(NSInteger) type page:(NSInteger)page  withBlock:(hfAckBlock)block;



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
  获取分类列表
 **/
-(void)getCategoryListWithBolck:(hfAckBlock)block;


/**
 获取品牌列表
 **/
-(void)getBrandListWithBlock:(hfAckBlock)block;






@end
