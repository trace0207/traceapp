//
//  HFThirdPartyCenter.h
//  GuanHealth
//
//  Created by 栋栋 施 on 15/6/15.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HFThirdPartyCenter : NSObject

SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(HFThirdPartyCenter, shareInstance)

- (void)startInit;

- (void)shareSDKShare:(UIViewController *)controller HiifitType:(NSInteger)type dataDic:(NSDictionary *)dataDic;

//邀请好友
- (void)shareSDKInviteFriends:(UIViewController *)controller;

- (BOOL)QQInstall;

- (BOOL)WXInstall;

@end
