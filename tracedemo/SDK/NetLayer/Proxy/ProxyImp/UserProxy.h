//
//  UserProxy.h
//  GuanHealth
//
//  Created by cmcc on 15/6/3.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HFSaveDeviceTokenReq.h"
#import "HFUserInfoModel.h"
#import "HFModifyInfoReq.h"
#import "HFCheckVercodeReq.h"
#import "HomePageRes.h"
#import "AppDelegate.h"
#import <ShareSDK/ShareSDK.h>

typedef void (^saveDeviceTokenBlock)(HFSaveDeviceTokenReq *);
typedef void (^LoginFinishBlock) (BOOL finish);
typedef void(^getUserHomeBlock)(HomeData *userInfo, BOOL success);
@interface UserProxy : NSObject

//通用登录方法
- (void)loginWithModel:(HFUserInfoModel*)userModel complete:(LoginFinishBlock)finish;

//新用户注册
- (void)registerWithMobile:(NSString *)mobile andPassword:(NSString *)password success:(complete)complete;

//第三方用户登录
- (void)thirdPartLoginWithType:(ShareType)userType complete:(LoginFinishBlock)finish;

//自动登陆
- (void)autoLoginWithComplete:(LoginFinishBlock)block;

//重设密码
- (void)setPassword:(NSString *)password andMobile:(NSString *)mobile success:(complete)complete;

//登出用户
- (void)logoutWithComplete:(LoginFinishBlock)block;

//绑定手机号
- (void)bindPhoneNum:(NSString *)phone
            password:(NSString *)password
            complete:(LoginFinishBlock)block;

//修改个人信息
- (void)modifyWithInfo:(HFModifyInfoReq *)req success:(complete)complete;

//预注册
- (void)PreRegisterWihtMobile:(NSString *)mobile success:(complete)complete;

//发送验证码
- (void)sentVercodeWithMobile:(NSString *)mobile success:(complete)complete;

//检验验证码
- (void)checkVercode:(HFCheckVercodeReq *)req success:(complete)complete;

//获取用户信息
- (void)getUserInfo:(complete)complete;

//获取用户主页信息
- (void)getUserHomePage:(NSInteger)userId completion:(getUserHomeBlock)block;


@end
