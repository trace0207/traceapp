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
#import "TK_UploadImageArg.h"
#import "TKPublishShowGoodsArg.h"
#import "TK_BrandListArg.h"
#import "TK_PayArg.h"
#import "TK_PublishRewardArg.h"
#import "TK_CategoryListArg.h"



@implementation TKMainProxy




/**
 发布晒单
 **/
-(void)publishShowGoods:(TKPublishShowGoodsArg *)arg withBlock:(hfAckBlock)block
{
#if B_Client == 0
    arg.role = 1;
#endif
    
    [[HF_HttpClient httpClient]sendRequestForHiifit:arg withBolck:block];
    
}


/**
 *  获取晒单列表
 *
 *  @param type  晒单类型
 *  @param block 回调block
 */
-(void)getShowOrders:(NSInteger) type
                page:(NSInteger)page
           withBlock:(hfAckBlock)block{
    
    TK_GetOrdersArg * arg = [[TK_GetOrdersArg alloc] init];
    arg.categoryId = type;
    arg.pageSize = 20;
    arg.pageOffset = page;
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



/**
 *  上传图片
 *
 *  @param image <#image description#>
 *  @param block <#block description#>
 */
-(void)uploadImage:(UIImage *)image
          withType:(NSInteger)type
         withBlock:(hfAckBlock)block
{
    
    TK_UploadImageArg * arg = [[TK_UploadImageArg alloc] init];
    arg.image = image;
    arg.fileType = type;
    arg.needCompress = 1;
    [[HF_HttpClient httpClient] sendRequestForHiifit:arg withBolck:block];
}




-(void)uploadMutableImages:(NSArray *)images
                  withtype:(NSInteger)type
                 withBlock:(tkMutableArgBlock)block
{
    
    NSMutableArray * array = [[NSMutableArray alloc] init];
    for(int i = 0;i<images.count;i++)
    {
        TK_UploadImageArg * arg = [[TK_UploadImageArg alloc] init];
        arg.showToastStr = @"NO";
        arg.image = images[i];
        arg.fileType = type;
        arg.needCompress = 1;
        [array addObject:arg];
    }
    [[HF_HttpClient httpClient] sendMUtableArgsForHiffit:array showLoading:NO toastError:NO withBlock:^(NSArray<__kindof HF_BaseAck *> *acks) {
       
//        DDLogInfo(@"ack back %@",acks);
        block(acks);
    }];
}



/**
 获取分类列表
 **/
-(void)getCategoryListWithBolck:(hfAckBlock)block
{
    TK_CategoryListArg * arg = [[TK_CategoryListArg alloc] init];
    [[HF_HttpClient httpClient] sendRequestForHiifit:arg withBolck:block];
}


/**
 获取品牌列表
 **/
-(void)getBrandListWithBlock:(hfAckBlock)block
{
    TK_BrandListArg * arg = [[TK_BrandListArg alloc] init];
    [[HF_HttpClient httpClient] sendRequestForHiifit:arg withBolck:block];
}



/**
 发布悬赏
 **/
-(void)publishReward:(TK_PublishRewardArg *)arg withBlock:(hfAckBlock)block;
{
    [[HF_HttpClient httpClient] sendRequestForHiifit:arg withBolck:block];
}

/**
 支付
 **/
-(void)tkPay:(TK_PayArg *)arg withBolco:(hfAckBlock)block
{
    [[HF_HttpClient httpClient] sendRequestForHiifit:arg withBolck:block];
}


@end
