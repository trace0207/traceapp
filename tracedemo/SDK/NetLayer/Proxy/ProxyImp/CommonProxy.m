//
//  CommonProxy.m
//  GuanHealth
//
//  Created by cmcc on 15/6/4.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "CommonProxy.h"
#import "CheckUpdateReq.h"
#import "CheckUpdateRes.h"
#import "HFSensitiveWordsReq.h"
#import "HFSensitiveWordsRes.h"
#import "HFDBCenter.h"
#import "HFOnlineTimeReq.h"
#import "HFOnlineTimeRes.h"
#import "HFShareReq.h"
#import "HFFriendsRankReq.h"
#import "HFWorldRankReq.h"
#import "BaseHFHttpClient.h"
#import "MBProgressHUD.h"
#import "UIKitTool.h"

@implementation CommonProxy


/**
 检查版本刚更新
 */
-(void)checkUpdate:(NSString*)version success:(checkUpdateBlock) block{

    CheckUpdateReq * req = [[CheckUpdateReq alloc] init];
    req.deviceType = 4;
    req.version = version;
    req.credentialType = CREDENTIAL_TYPE;
    
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:@"CheckUpdateRes" completion:^(HFRetModel *ret) {
        if (ret.bSuccess)
        {
            CheckUpdateRes * res = (CheckUpdateRes *)ret.data;
            block(res);
        }
        else
        {
            DDLogInfo(@"版本更新检查 请求失败  ！！！ ");
            CheckUpdateRes * res = [[CheckUpdateRes alloc]init];
            res.strategyType = 0;
            block(res);
        }
    }];
}

- (void)getAllSensitiveWords
{
    HFSensitiveWordsReq *req = [[HFSensitiveWordsReq alloc]init];
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:@"HFSensitiveWordsRes" completion:^(HFRetModel *ret) {
        if (ret.bSuccess)
        {
            HFSensitiveWordsRes * res = (HFSensitiveWordsRes *)ret.data;
            NSDictionary *dic = (NSDictionary *)res.data;
            NSString *word = [dic objectForKey:@"sensitiveWords"];
            long time = [[dic objectForKey:@"lastUpdateTime"]longValue];
            [[GlobInfo shareInstance]setLastUpdateTime:time];
            NSArray *words = [word componentsSeparatedByString:@"|"];
            [[HFDBCenter shareInstance]updateSensitiveWords:words];
        }
    }];
    
}

- (void)uploadUserActive:(NSString *)onlineDate complete:(complete)success
{
    HFOnlineTimeReq *req = [[HFOnlineTimeReq alloc]init];
    req.onlineSeconds = [GlobInfo shareInstance].onlineSeconds;
    req.onlineDate = onlineDate;
    
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:@"HFOnlineTimeRes" completion:^(HFRetModel *ret) {
        if (ret.bSuccess)
        {
            //HFOnlineTimeRes *res = (HFOnlineTimeRes *)ret.data;
            //[[GlobInfo shareInstance]setActiveDay:res.activeDay];
        }
        success(ret.bSuccess);
    }];
}

- (void)feedback:(HFFeedbackReq *)req completion:(complete)finished
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIKitTool getAppdelegate].window animated:YES];
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:nil completion:^(HFRetModel *ret) {
        finished(ret.bSuccess);
        [hud hide:YES];
    }];
}

- (void)shareAction:(NSInteger)moduleId completion:(complete)finished
{
    HFShareReq *req = [[HFShareReq alloc]init];
    req.modelId = moduleId;
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:nil completion:^(HFRetModel *ret) {
        finished(ret.bSuccess);
    }];
}
//好友排行
- (void)getFriendsRank:(getRankBlock)block
{
    HFFriendsRankReq *req = [[HFFriendsRankReq alloc]init];
  
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:@"UploadGameRes" completion:^(HFRetModel *ret) {
        UploadGameRes *res = (UploadGameRes*)ret.data;
        block(res, ret.bSuccess);
    }];
}
//世界排行
- (void)getWorldRank:(getRankBlock)block
{
    HFWorldRankReq *req = [[HFWorldRankReq alloc]init];
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:@"UploadGameRes" completion:^(HFRetModel *ret) {
        UploadGameRes *res = (UploadGameRes*)ret.data;
        block(res, ret.bSuccess);
    }];
}

@end
