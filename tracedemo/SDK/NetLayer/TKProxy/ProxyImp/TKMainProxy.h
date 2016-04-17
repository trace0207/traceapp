//
//  TKMainProxy.h
//  tracedemo
//
//  Created by 罗田佳 on 15/11/14.
//  Copyright © 2015年 trace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TK_MessageCenterArg.h"
@class TK_PayArg,TKPublishShowGoodsArg ,TK_PublishRewardArg;




@interface TKMainProxy : NSObject


/**
 发布晒单
 **/
-(void)publishShowGoods:(TKPublishShowGoodsArg *)arg withBlock:(hfAckBlock)block;



/**
 消费者C 端晒单池
 **/
-(void)getShowOrders:(NSString *) type
             brandId:(NSString *) brandId
                page:(NSInteger)page  withBlock:(hfAckBlock)block;



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

/**
 发布悬赏
 **/
-(void)publishReward:(TK_PublishRewardArg *)arg withBlock:(hfAckBlock)block;

/**
 支付
 **/
-(void)tkPay:(TK_PayArg *)arg withBolco:(hfAckBlock)block;


/**
 根据ID 查询悬赏详情
 **/
-(void)queryRewardById:(NSString *)rewardId withBlock:(hfAckBlock)block;

#pragma mark   BClient

/**
 B根据类目查询我的客户的悬赏ID
 **/
-(void)getMyRewardList:(NSString *)categoryId
                  page:(NSInteger)page
          rewardStatus:(NSInteger)status
             withBlock:(hfAckBlock)block;

/**
 B根据类目查询悬赏广场的悬赏
 **/
-(void)getRewardList:(NSString *)categoryId
             brandId:(NSString *) brandId
                page:(NSInteger)page
                type:(HomePageType)type
        rewardStatus:(NSInteger)status
           withBlock:(hfAckBlock)block;


/**
 生成邀请码
 **/
-(void)createInviteCode:(hfAckBlock)block;



/**
 接单
 **/
-(void)accept:(NSString *)buyerId rewardId:(NSString *)rewardId needDays:(NSInteger) days withBlock:(hfAckBlock)block;


/**
 释放悬赏  
 source  0 买手接单时释放到公共池， 1 消费者在拒绝买手发货时间释放到 公共池  2消费者  24 小时未同意发货时间释放到公共池
 **/
-(void)releaseReward:(NSString *)rewardId source:(NSInteger)source withBlock:(hfAckBlock)block;


/**
 查询买手基本信息
 **/
-(void)getBuyerUserInfo:(NSString *)userId withBlock:(hfAckBlock)block;


/**
 查询买手主页晒单列表
 **/
-(void)getBuyerHomePageOrders:(NSString *)userId  page:(NSInteger)page withBlock:(hfAckBlock)block;


#pragma  mark  MSGBox

/**
 获取消息盒子数据
 **/
-(void)getMessageCenter:(TK_MessageCenterArg *)arg withBlock:(hfAckBlock)block;

/**
 根据类目查询消息列表
 **/
-(void)getMesssageListById:(NSString *)toId withBolck:(hfAckBlock)block;

/**
 发送消息
 **/
-(void)tkSendMessage:(NSString *)toId content:(NSString *)content withBlock:(hfAckBlock)block;

/**
 查询通知的消息列表
 **/
-(void)tkGetNotifyMsgList:(NSInteger)boxId withBlock:(hfAckBlock)block;

#pragma  mark CClient

/**
 查询C端悬赏广场
 **/
//-(void)getCRewardList:(NSString *)categoryId
//                 page:(NSInteger)page
//         rewardStatus:(NSInteger)status
//            withBlock:(hfAckBlock)block;


/**
 查询用户主页的  晒单列表
 **/
-(void)getCustomerPageOrders:(NSString *)userId page:(NSInteger) page  withBolocl:(hfAckBlock)block;


@end
