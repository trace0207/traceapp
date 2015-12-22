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
        //        dispatch_group_enter(group);
        
        TK_UploadImageArg * arg = [[TK_UploadImageArg alloc] init];
        arg.showToastStr = @"NO";
        arg.image = images[i];
        arg.fileType = type;
        arg.needCompress = 1;
        [array addObject:arg];
    }
    [self sendMutableArg:array withBlock:block];
}



/**
 *  通用 的多个 arg 请求队列
 *  不loading ，不提示 error
 *  @param args  <#args description#>
 *  @param block <#block description#>
 */
-(void)sendMutableArg:(NSArray<__kindof TK_JsonModelArg *><TK_TransferArgProtocol> *)args
            withBlock:(tkMutableArgBlock)block
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    NSMutableArray * array = [[NSMutableArray alloc]init];
    hfAckBlock  oneBlock = ^(HF_BaseAck * ack)
    {
        dispatch_group_async(group,queue,^{
            [array addObject:ack];
            DDLogInfo(@"TKGroup ack at  index = %@",ack.transferFromArg);
        });
        dispatch_group_leave(group);
    };
    
    for(int i = 0;i<args.count;i++)
    {
        dispatch_group_enter(group);
        dispatch_group_async(group,queue,^{
            args[i].transferFromArg = @(i);
            [[HF_HttpClient httpClient] sendRequestForHiifit:args[i] withBolck:oneBlock];
            
        });
        
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"结束了整组的请求队列");
        NSArray * array2 = [array sortedArrayUsingComparator:^NSComparisonResult(HF_BaseAck * obj1, HF_BaseAck * obj2) {
            return (NSInteger)obj1.transferFromArg > (NSInteger)obj2.transferFromArg ? NSOrderedDescending:NSOrderedDescending;
        }];
        block(array2);
    });

}

@end
