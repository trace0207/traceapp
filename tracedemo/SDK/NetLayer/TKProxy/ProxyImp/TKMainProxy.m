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
#import "TK_RewardListForBuyerAck.h"
#import "TK_RewardListForBuyerArg.h"
#import "ActionTools.h"
#import "TK_AcceptRewardArg.h"
#import "TK_ReleaseRewardArg.h"
#import "TK_GetInviteCodeArg.h"
#import "TK_GetUserPageDataListArg.h"
#import "TK_GetBuyerHomePageListArg.h"
#import "TK_GetBuyerUserInfoArg.h"
#import "TK_GetRewardByIdArg.h"
#import "TK_BoxListArg.h"


@implementation TKMainProxy




/**
 发布晒单
 **/
-(void)publishShowGoods:(TKPublishShowGoodsArg *)arg withBlock:(hfAckBlock)block
{
#if B_Client == 0
    arg.role = @"1";
#endif
    
    [[HF_HttpClient httpClient]sendRequestForHiifit:arg withBolck:block];
    
}


/**
 *  获取晒单列表
 *
 *  @param type  晒单类型
 *  @param block 回调block
 */
-(void)getShowOrders:(NSString *) type
             brandId:(NSString *) brandId
                page:(NSInteger)page
           withBlock:(hfAckBlock)block{
    
    TK_GetOrdersArg * arg = [[TK_GetOrdersArg alloc] init];
    arg.categoryId = type;
    arg.pageSize = 20;
    arg.brandId = brandId;
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
    arg.showLoadingStr = @"YES";
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
    [[HF_HttpClient httpClient] sendMUtableArgsForHiffit:array showLoading:NO toastError:NO withBlock:block];
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





/**
 根据ID 查询悬赏详情
 **/
-(void)queryRewardById:(NSString *)rewardId withBlock:(hfAckBlock)block
{
    TK_GetRewardByIdArg * arg = [[TK_GetRewardByIdArg alloc] init];
    arg.postrewardId = rewardId;
    arg.showLoadingStr = @"YES";
    [[HF_HttpClient httpClient] sendRequestForHiifit:arg withBolck:block];
}


#pragma mark   BClient

/**
 根据类目查询我的客户的悬赏ID
 **/
-(void)getMyRewardList:(NSString *)categoryId
                  page:(NSInteger)page
          rewardStatus:(NSInteger)status
             withBlock:(hfAckBlock)block
{
    
    TK_RewardListForBuyerArg * arg = [[TK_RewardListForBuyerArg alloc] init];
    arg.pageSize = 20;
    arg.pageOffset = page;
    arg.rewardStatus = status;
    [[HF_HttpClient httpClient] sendRequestForHiifit:arg withBolck:block];
}

/**
 根据类目查询悬赏广场的悬赏
 **/
-(void)getRewardList:(NSString *)categoryId
             brandId:(NSString *) brandId
                page:(NSInteger)page
                type:(HomePageType)type
        rewardStatus:(NSInteger)status
           withBlock:(hfAckBlock)block
{
    TK_RewardListForBuyerArg * arg = [[TK_RewardListForBuyerArg alloc] init];
    
    arg.ackClassName = @"TK_RewardListForBuyerAck";
    if(type == B_AllReward)
    {
        arg.relativeUrl = [ActionTools getRelativePathByString:@"TK_RewardListForBuyerArg1"];
    }
    else if(type == C_AllReward)
    {
        arg.relativeUrl = [ActionTools getRelativePathByString:@"TK_CGetRewardListArg"];
    }else if(type == B_MyUserReward)
    {
        arg.relativeUrl = [ActionTools getRelativePathByString:@"TK_RewardListForBuyerArg"];
    }
    arg.rewardStatus = status;
    //默认的是查我的客户的悬赏
    arg.pageSize = 20;
    arg.pageOffset = page;
    arg.categoryId = categoryId;
    arg.brandId = brandId;
    [[HF_HttpClient httpClient] sendRequestForHiifit:arg withBolck:block];
}



/**
 生成邀请码
 **/
-(void)createInviteCode:(hfAckBlock)block
{
    TK_GetInviteCodeArg * arg = [[TK_GetInviteCodeArg alloc] init];
    arg.role = @"0";
    [[HF_HttpClient httpClient] sendRequestForHiifit:arg withBolck:block];
}


/**
 接单
 **/
-(void)accept:(NSString *)buyerId
     rewardId:(NSString *)rewardId
     needDays:(NSInteger) days
    withBlock:(hfAckBlock)block
{
    
    TK_AcceptRewardArg * arg = [[TK_AcceptRewardArg alloc] init];
    arg.purchaserId = buyerId;
    arg.purchaserDay = days;
    arg.postrewardId = rewardId;
    arg.showLoadingStr = @"YES";
    [[HF_HttpClient httpClient] sendRequestForHiifit:arg withBolck:block];
    
    
}


/**
 释放悬赏
 source  0 买手接单时释放到公共池， 1 消费者在拒绝买手发货时间释放到 公共池  2消费者  24 小时未同意发货时间释放到公共池
 **/
-(void)releaseReward:(NSString *)rewardId source:(NSInteger)source withBlock:(hfAckBlock)block
{
    TK_ReleaseRewardArg * arg = [[TK_ReleaseRewardArg alloc] init];
    
    arg.postrewardId = rewardId;
    arg.source = source;
    arg.showLoadingStr = @"YES";
    [[HF_HttpClient httpClient] sendRequestForHiifit:arg withBolck:block];
    
}



/**
 查询买手基本信息
 **/
-(void)getBuyerUserInfo:(NSString *)userId withBlock:(hfAckBlock)block
{
    TK_GetBuyerUserInfoArg * arg = [[TK_GetBuyerUserInfoArg alloc] init];
    arg.purchaserId = userId;
    arg.ackClassName = @"TK_GetUserHomePageAck";
    [[HF_HttpClient httpClient] sendRequestForHiifit:arg withBolck:block];
}


/**
 查询买手主页晒单列表
 **/
-(void)getBuyerHomePageOrders:(NSString *)userId  page:(NSInteger)page withBlock:(hfAckBlock)block
{
    TK_GetBuyerHomePageListArg * arg = [[TK_GetBuyerHomePageListArg alloc] init];
    arg.purchaserId = userId;
    arg.pageSize = 20;
    arg.pageOffset = page;
    arg.ackClassName = @"TK_GetOrdersAck";
    [[HF_HttpClient httpClient] sendRequestForHiifit:arg withBolck:block];
}



#pragma  mark  MSGBox

/**
 获取消息盒子数据
 **/
-(void)getMessageCenter:(TK_MessageCenterArg *)newArg withBlock:(hfAckBlock)block
{
//    TK_MessageCenterArg * newArg = [[TK_MessageCenterArg alloc] init];
    [[HF_HttpClient httpClient] sendRequestForHiifit:newArg withBolck:block];
}

/**
 根据类目查询消息列表
 **/
-(void)getMesssageListById:(NSString *)toId withBolck:(hfAckBlock)block
{
}

/**
 发送消息
 **/
-(void)tkSendMessage:(NSString *)toId content:(NSString *)content withBlock:(hfAckBlock)block
{
}


/**
 查询通知的消息列表
 **/
-(void)tkGetNotifyMsgList:(NSInteger)boxId withBlock:(hfAckBlock)block
{
    TK_BoxListArg * arg = [[TK_BoxListArg alloc] init];
    arg.pageSize = 100;
    arg.pageOffset = 0;
    arg.boxType = boxId;
    [[HF_HttpClient httpClient] sendRequestForHiifit:arg withBolck:block];
}


#pragma  mark CClient

//-(void)getCRewardList:(NSString *)categoryId page:(NSInteger)page rewardStatus:(NSInteger)status withBlock:(hfAckBlock)block
//{
//    TK_CGetRewardListArg * arg = [[TK_CGetRewardListArg alloc] init];
//    arg.ackClassName = @"TK_RewardListForBuyerAck";
//    [[HF_HttpClient httpClient] sendRequestForHiifit:arg withBolck:^(HF_BaseAck *ack) {
//        
//        block(ack);
//    }];
//}


/**
 查询用户主页的  晒单列表
 **/
-(void)getCustomerPageOrders:(NSString *)userId page:(NSInteger) page  withBolocl:(hfAckBlock)block
{
    TK_GetUserPageDataListArg * arg = [[TK_GetUserPageDataListArg alloc] init];
    arg.ackClassName = @"TK_GetOrdersAck";
    arg.userId = userId;
    arg.pageSize = 20;
    arg.pageOffset = page;
    [[HF_HttpClient httpClient] sendRequestForHiifit:arg withBolck:block];
}

@end
