//
//  GlobInfo.h
//  GuanHealth
//
//  Created by hermit on 15/2/11.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserRes.h"
@interface GlobInfo : NSObject

SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(GlobInfo, shareInstance);

@property (nonatomic, strong)       UserRes *usr;
//@property (nonatomic, strong)       NSDictionary *weather;//天气信息

@property (nonatomic,   copy)       NSString *deviceid;      //设备唯一识别码
@property (nonatomic,   copy)       NSString *behaviorInfo;  //用户ip地址
@property (nonatomic,   copy)       NSString *onlineDate;    //活跃日期 格式2015-06-24
//@property (nonatomic,   copy)       NSString *city;          //用户所在城市
@property (nonatomic,   copy)       NSString *account;
@property (nonatomic,   copy)       NSString *password;

@property (nonatomic, assign)       NSInteger userType;
@property (nonatomic, assign)       NSInteger unread_msg_count; //未读消息数
@property (nonatomic, assign)       NSInteger finishedInfo;     //是否完成信息提交 0表示为提交信息
@property (nonatomic, assign)       NSInteger onlineSeconds;    //一天的活跃时间（秒）

//@property (nonatomic, assign)       CGFloat   activeDay;    //用户在线天数

@property (nonatomic, assign)       long      lastUpdateTime;     //上次更新敏感词时间
@property (nonatomic, assign)       long long mLastUpdateTime;    //闹钟更新时间

@property (nonatomic, assign)       BOOL      bPush;
@property (nonatomic, assign)       BOOL      bNeedReloadMain;
@property (nonatomic, assign)       BOOL      bIsFullScreenState;
@property (nonatomic, assign)       BOOL      bDisplayBandView;//NO,展示手环引导页 YES，不展示


- (NSString*)setDeviceid;

- (void)setUserInfo:(NSDictionary*)user;

- (void)saveDeviceToken:(NSString *)token;

- (void)saveBandInfo:(NSDictionary *)bandInfo;

- (NSString *)token;

- (BOOL)hasLogined;

- (void)loginOut;

- (BOOL)isLatestVersion;            //判断是否刚安装或刚更新

@end
