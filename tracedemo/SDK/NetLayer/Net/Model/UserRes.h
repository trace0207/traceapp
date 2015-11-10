//
//  UserRes.h
//  GuanHealth
//
//  Created by hermit on 15/3/4.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ResponseData.h"

@interface UserRes : ResponseData

@property (nonatomic, copy) NSString *userVector;
@property (nonatomic, copy) NSString *bdChannelId;//百度云channelID
@property (nonatomic, copy) NSString *addr;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *birthday;//用户生日yyyy-mm-dd
@property (nonatomic, copy) NSString *idcardNum;
@property (nonatomic, copy) NSString *postcode;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *headPortraitUrl;  //头像
@property (nonatomic, copy) NSString *signature;//签名
@property (nonatomic, copy) NSString *bandDeviceId;//手环的id

@property (nonatomic, assign) CGFloat   height;
@property (nonatomic, assign) CGFloat   weight;
@property (nonatomic, assign) CGFloat   activeDay;//在线天数
@property (nonatomic, assign) CGFloat   upLevelDay;//用户升级需天数
@property (nonatomic, assign) CGFloat   nextLevelDay;//当前等级升级下一等级所需天数

@property (nonatomic, assign) NSInteger sex;
@property (nonatomic, assign) NSInteger userId;   //好像被废弃掉了
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, assign) NSInteger level;//等级
@property (nonatomic, assign) NSInteger isPush;//是否推送
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger completionStatus;//个人信息是否填写 0、没有填写 1、已填写
@property (nonatomic, assign) NSInteger isUpdate;//是否需要更新敏感词1：需要 0：不需要
@property (nonatomic, assign) NSInteger deviceType;
@property (nonatomic, assign) NSInteger bindStatus;
@property (nonatomic, assign) NSInteger isPraisePush;
@property (nonatomic, assign) NSInteger isFansPush;
@property (nonatomic, assign) NSInteger isCommPush;
@property (nonatomic, assign) NSInteger isSmsRemind;
@property (nonatomic, assign) NSInteger isMobileRemind;
@property (nonatomic, assign) NSInteger score;


- (BOOL)hasSetUserInfo;

//- (BOOL)hasBind;

- (BOOL)isGirl;

- (NSString *)getBirthdayStr;

- (NSString *)getSexStr;

- (NSString *)getHeight;

- (NSString *)getWeight;

- (NSString *)getAge;

@end
