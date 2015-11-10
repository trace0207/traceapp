//
//  HFWeiBoProxy.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/6/15.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HFDeleteWeiboReq.h"
#import "HFReportReq.h"
#import "HFSubmitCommentReq.h"
#import "HFCommentLikeListRes.h"
#import "HFCommentUsersRes.h"
#import "HFSubmitPraiseReq.h"
#import "HFSubmitLikeRes.h"
#import "MyPostListRes.h"
#import "HFGetPostListReq.h"
#import "HFGetPostsReq.h"
#import "HFSudoPostsReq.h"
#import "PostDetailRes.h"
#import "HFPostDetailReq.h"
#import "HFUploadPostReq.h"
#import "HFPostBarReq.h"
#import "HFPostBarPersonalReq.h"
#import "HFLikeUsersReq.h"
#import "HFNetProcessHelper.h"
typedef void(^likeUsersComplete)(NSArray<HFCommentLikeListData> *likeUsersData, BOOL success);
typedef void(^commentUsersComplete)(HFRetModel *ret);
typedef void(^getPostListBlock)(NSArray<PostDetailData> *postList, BOOL success);
typedef void(^getPostDetailBlock)(PostDetailData *post, BOOL success);

@interface HFWeiBoProxy : NSObject

- (void)deleteWeiboType:(NSInteger)weiboType
             andWeiboId:(NSInteger)weiboId
                success:(complete)complete;
- (void)deleteWeiboCommentType:(NSInteger)weiboType
                  andCommentId:(NSInteger)commentId
                    andWeiboId:(NSInteger)weiboId
                       success:(complete)complete;
- (void)reportWeiboType:(NSInteger)weiboType
             andWeiboId:(NSInteger)weiboId
              andUserId:(NSInteger)userId
             informType:(NSInteger)informType
                success:(complete)complete;

- (void)getLikeUsers:(HFLikeUsersReq *)req
                complete:(likeUsersComplete)block;

//- (void)getLikeUsersType:(NSInteger)weiboType
//                 weiboId:(NSInteger)weiboId
//                complete:(likeUsersComplete)block;

- (void)getCommentUsersType:(NSInteger)weiboType
                    weiboId:(NSInteger)weiboId
                   complete:(commentUsersComplete)block;

- (void)submitCommentType:(HFSubmitCommentReq *)req
                 complete:(complete)success;


- (void)submitPraiseType:(HFSubmitPraiseReq *)req
                complete:(responseBlock)block;

- (void)followAction:(NSInteger)userId isFollow:(BOOL)is completion:(complete)complete;

//发现里面的帖子列表
- (void)getPostList:(HFGetPostListReq *)req completion:(getPostListBlock)block;

//个人中心帖子列表
- (void)getUserCenterPost:(HFGetPostsReq *)req completion:(getPostListBlock)block;

//数独主页帖子列表
- (void)getSudoPosts:(HFSudoPostsReq *)req completion:(getPostListBlock)block;

- (void)getPostDetail:(HFPostDetailReq *)req completion:(getPostDetailBlock)block;
//上传帖子
- (void)uploadPost:(HFUploadPostReq *)req completion:(complete)complete;
//贴吧帖子列表
- (void)getPostBar:(HFPostBarReq *)req completion:(getPostListBlock)block;
//贴吧个人帖子列表
- (void)getPostBarPersonal:(HFPostBarPersonalReq *)req completion:(getPostListBlock)block;

@end
