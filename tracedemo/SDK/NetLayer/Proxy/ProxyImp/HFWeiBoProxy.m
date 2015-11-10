//
//  HFWeiBoProxy.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/6/15.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFWeiBoProxy.h"
#import "HFLikeUsersReq.h"
#import "HFCommentsReq.h"
#import "HFFollowReq.h"
#import "HFCancelFolReq.h"
#import "HFWeiboDeleteCommentReq.h"
#import "BaseHFHttpClient.h"

@implementation HFWeiBoProxy

- (void)deleteWeiboType:(NSInteger)weiboType
             andWeiboId:(NSInteger)weiboId
                success:(complete)complete
{
    HFDeleteWeiboReq *req = [[HFDeleteWeiboReq alloc]init];
    req.weiboType = weiboType;
    req.weiboId = weiboId;
    
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:nil completion:^(HFRetModel *ret) {
        complete(ret.bSuccess);
    }];
}
- (void)deleteWeiboCommentType:(NSInteger)weiboType
                  andCommentId:(NSInteger)commentId
                    andWeiboId:(NSInteger)weiboId
                       success:(complete)complete{
    HFWeiboDeleteCommentReq * req = [[HFWeiboDeleteCommentReq alloc] init];
    req.weiboType = weiboType;
    req.commentId = commentId;
    req.weiboId = weiboId;
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:nil completion:^(HFRetModel *ret) {
        complete(ret.bSuccess);
    }];
}
- (void)reportWeiboType:(NSInteger)weiboType
             andWeiboId:(NSInteger)weiboId
              andUserId:(NSInteger)userId
             informType:(NSInteger)informType
                success:(complete)complete
{
    HFReportReq *req = [[HFReportReq alloc]init];
    req.weiboType = weiboType;
    req.weiboId = weiboId;
    req.userId = userId;
    req.informType = informType;
    
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:nil completion:^(HFRetModel *ret) {
        complete(ret.bSuccess);
    }];
}

- (void)getLikeUsersType:(NSInteger)weiboType
                 weiboId:(NSInteger)weiboId
                complete:(likeUsersComplete)block
{
    HFLikeUsersReq *req = [[HFLikeUsersReq alloc]init];
    req.weiboType = weiboType;
    req.weiboId = weiboId;
    req.pageOffset = 0;
    req.pageSize = MAX_INPUT;
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:@"HFCommentLikeListRes" completion:^(HFRetModel *ret) {
        HFCommentLikeListRes *res = (HFCommentLikeListRes *)ret.data;
        block(res.data,ret.bSuccess);
    }];
}

- (void)getLikeUsers:(HFLikeUsersReq *)req
            complete:(likeUsersComplete)block
{
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:@"HFCommentLikeListRes" completion:^(HFRetModel *ret) {
        HFCommentLikeListRes *res = (HFCommentLikeListRes *)ret.data;
        block(res.data,ret.bSuccess);
    }];
}


- (void)getCommentUsersType:(NSInteger)weiboType
                    weiboId:(NSInteger)weiboId
                   complete:(commentUsersComplete)block
{
    HFCommentsReq *req = [[HFCommentsReq alloc]init];
    req.weiboType = weiboType;
    req.weiboId = weiboId;
    req.pageOffset = 0;
    req.pageSize = MAX_INPUT;
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:@"HFCommentUsersRes" completion:^(HFRetModel *ret) {
        block(ret);
    }];
}

- (void)submitCommentType:(HFSubmitCommentReq *)req
                 complete:(complete)success
{
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:nil completion:^(HFRetModel *ret) {
        success(ret.bSuccess);
    }];
}

- (void)submitPraiseType:(HFSubmitPraiseReq *)req
                complete:(responseBlock)block;
{
    
    req.showLoadingStr = @"YES";
    [[BaseHFHttpClient shareInstance]sendPost:req responseBlock:block];
}

- (void)followAction:(NSInteger)userId isFollow:(BOOL)is completion:(complete)complete
{
    BaseHttpReq *req = nil;
    if (is) {
        HFFollowReq *re = [[HFFollowReq alloc]init];
        re.followId = userId;
        req = re;
    }else{
        HFCancelFolReq *re = [[HFCancelFolReq alloc]init];
        re.followId = userId;
        req = re;
    }
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:@"MyPostListRes" completion:^(HFRetModel *ret) {
        complete(ret.bSuccess);
    }];
}

- (void)getPostList:(HFGetPostListReq *)req completion:(getPostListBlock)block
{
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:@"MyPostListRes" completion:^(HFRetModel *ret) {
        MyPostListRes *res = (MyPostListRes*)ret.data;
        block(res.data, ret.bSuccess);
    }];
}

- (void)getUserCenterPost:(HFGetPostsReq *)req completion:(getPostListBlock)block
{
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:@"MyPostListRes" completion:^(HFRetModel *ret) {
        MyPostListRes *res = (MyPostListRes*)ret.data;
        block(res.data, ret.bSuccess);
    }];
}

- (void)getSudoPosts:(HFSudoPostsReq *)req completion:(getPostListBlock)block
{
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:@"MyPostListRes" completion:^(HFRetModel *ret) {
        MyPostListRes *res = (MyPostListRes*)ret.data;
        block(res.data, ret.bSuccess);
    }];
}
- (void)getPostBar:(HFPostBarReq *)req completion:(getPostListBlock)block
{
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:@"MyPostListRes" completion:^(HFRetModel *ret) {
        MyPostListRes * res = (MyPostListRes *)ret.data;
        block(res.data, ret.bSuccess);
    }];
}
- (void)getPostBarPersonal:(HFPostBarPersonalReq *)req completion:(getPostListBlock)block
{
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:@"MyPostListRes" completion:^(HFRetModel *ret) {
        MyPostListRes * res = (MyPostListRes *)ret.data;
        block(res.data, ret.bSuccess);
    }];
}
- (void)getPostDetail:(HFPostDetailReq *)req completion:(getPostDetailBlock)block
{
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:@"PostDetailRes" completion:^(HFRetModel *ret) {
        PostDetailRes *res = (PostDetailRes*)ret.data;
        block(res.data, ret.bSuccess);
    }];
}

- (void)uploadPost:(HFUploadPostReq *)req completion:(complete)complete
{
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:nil completion:^(HFRetModel *ret) {
        complete(ret.bSuccess);
    }];
}

@end
