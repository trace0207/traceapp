//
//  CommonProxy.h
//  GuanHealth
//
//  Created by cmcc on 15/6/4.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "CheckUpdateRes.h"
#import "HFSensitiveWordsRes.h"
#import "HFFeedbackReq.h"
#import "UploadGameRes.h"
typedef void (^checkUpdateBlock)(CheckUpdateRes *);
typedef void(^getRankBlock)(UploadGameRes *data, BOOL success);

@interface CommonProxy : NSObject

/**
  检查版本更新
 **/
-(void)checkUpdate:(NSString*)version success:(checkUpdateBlock) block;
//获取敏感词汇
- (void)getAllSensitiveWords;
//上次用户活跃时间
- (void)uploadUserActive:(NSString *)onlineDate complete:(complete)success;
//意见反馈
- (void)feedback:(HFFeedbackReq *)req completion:(complete)finished;
//分享
- (void)shareAction:(NSInteger)moduleId completion:(complete)finished;
//好友排行
- (void)getFriendsRank:(getRankBlock)block;
//世界排行
- (void)getWorldRank:(getRankBlock)block;
@end
