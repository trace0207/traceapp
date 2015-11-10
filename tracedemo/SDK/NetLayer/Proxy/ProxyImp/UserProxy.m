//
//  UserProxy.m
//  GuanHealth
//
//  Created by cmcc on 15/6/3.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "UserProxy.h"
#import "HFSaveDeviceTokenReq.h"
#import "HFSaveDeviceTokenRes.h"
#import "DataRes.h"
#import "HFLoginReq.h"
#import "DataRes.h"
#import "HFLogoutReq.h"
#import "HFHabitHelper.h"
#import "HFRegisterReq.h"
#import "HFSetPwdReq.h"
#import "HFBindPhoneReq.h"
#import "HFVerifySMSReq.h"
#import "HFPreRegisterReq.h"
#import "HFSentVercodeReq.h"
#import "HFGetUserInfoReq.h"
#import "HFGetUserHomeReq.h"

@implementation UserProxy


-(BOOL)saveDeviceToken :(NSString *) deviceToken{
    if (deviceToken.length==0) {
        return NO;
    }
    HFSaveDeviceTokenReq * req = [[HFSaveDeviceTokenReq alloc]init];
    
    req.deviceType = HIOSTypeIOS;// android 3  ios 4
    req.bdChannelId = deviceToken;
    req.iOSCredentialType = CREDENTIAL_TYPE; // IOS 推送证书类型， 1 个人版， 2 企业
    
    DDLogInfo(@"save deviceToken : %@",deviceToken);

    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:@"HFSaveDeviceTokenRes" completion:^(HFRetModel *ret) {
        if (ret.bSuccess)
        {
            HFSaveDeviceTokenRes * res = (HFSaveDeviceTokenRes *)ret.data;
            if(res.recode == 1){
                DDLogInfo(@"save deviceToken Success : %@",deviceToken);
            }
        }
        
    }];
    
    return true;
    
}

- (void)registerWithMobile:(NSString *)mobile andPassword:(NSString *)password success:(complete)complete
{
    HFRegisterReq *req = [[HFRegisterReq alloc]init];
    req.phoneNumber = mobile;
    req.passWord = [password MD5Digest];
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:[UIKitTool getAppdelegate].window animated:YES];
    
    
    WS(weakSelf)
    
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:@"DataRes" completion:^(HFRetModel *ret) {
        if (ret.bSuccess)
        {
            DataRes * res = (DataRes *)ret.data;
            
            HFUserInfoModel * model = [[HFUserInfoModel alloc] init];
            model.account = mobile;
            model.password = password;
            model.userType = HIUserTypeMobile;
            [weakSelf savaUserInfo:model andUser:res.user];
        }
        
        [HUD hide:YES];
        complete(ret.bSuccess);
    }];
}

- (void)loginWithModel:(HFUserInfoModel*)userModel complete:(LoginFinishBlock)finish
{
    HFLoginReq *req = [[HFLoginReq alloc]init];
    
    req.account = userModel.account;
    if (userModel.password.length>0) {
        req.passWord = [userModel.password MD5Digest];
    }
    req.photo = userModel.photo;
    req.sex = userModel.sex;
    req.sourceAccountType = userModel.userType;
    req.nickName = userModel.nickname;
    
    WS(weakSelf)
    
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:@"DataRes" completion:^(HFRetModel *ret) {
        if (ret.bSuccess)
        {
            DataRes * res = (DataRes *)ret.data;
            //登陆数据持久化
            [weakSelf savaUserInfo:userModel andUser:res.user];
        }
        
        finish(ret.bSuccess);
    }];
}

- (void)setPassword:(NSString *)password andMobile:(NSString *)mobile success:(complete)complete
{
    HFSetPwdReq *req = [[HFSetPwdReq alloc]init];
    req.passWord = [password MD5Digest];
    req.phoneNumber = mobile;
    WS(weakSelf)
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:[UIKitTool getAppdelegate].window animated:YES];
    
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:@"DataRes" completion:^(HFRetModel *ret) {
        if (ret.bSuccess)
        {
            DataRes * res = (DataRes *)ret.data;
            
            HFUserInfoModel * model = [[HFUserInfoModel alloc] init];
            model.account = mobile;
            model.password = [password MD5Digest];
            model.userType = HIUserTypeMobile;
            
            //登陆数据持久化
            [weakSelf savaUserInfo:model andUser:res.user];
        }
        
        [HUD hide:YES];
        complete(ret.bSuccess);
        
    }];
}

- (void)thirdPartLoginWithType:(ShareType)userType complete:(LoginFinishBlock)finish
{
    
    WS(weakSelf)
    [ShareSDK getUserInfoWithType:userType
                      authOptions:nil
                           result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error)
     {
         if (result)
         {
             [weakSelf transfromLocalLogin:userInfo withType:userType complete:finish];
         }
         else
         {
             [[HFHUDView shareInstance] ShowTips:[error errorDescription] delayTime:1.0 atView:nil];
         }
     }];
}


- (void)autoLoginWithComplete:(LoginFinishBlock)block
{
    BOOL bAutoLogin = NO;
    
    HIUserType type = (HIUserType)[[GlobInfo shareInstance] userType];
    
    if (type == HIUserTypeMobile)
    {
        if ([[GlobInfo shareInstance] hasLogined])
        {
            bAutoLogin = YES;
        }
    }
    else
    {
        ShareType shareType = [self transfromHIUserType:type];
        
        id<ISSPlatformCredential> credential = [ShareSDK getCredentialWithType:shareType];
        
        NSInteger expireSec = [[credential expired] timeIntervalSince1970];
        NSInteger nowSec = [[NSDate date] timeIntervalSince1970];
        
        if ([credential token] != nil && nowSec < expireSec)
        {
            //实现自动登录
            bAutoLogin = YES;
        }
    }
    
    if (bAutoLogin)
    {
        [self inToAutoLoginProcessWithcomplete:block];
    }
    else
    {
        block(NO);
    }
    
}

- (void)bindPhoneNum:(NSString *)phone
            password:(NSString *)password
            complete:(LoginFinishBlock)block
{
    HFBindPhoneReq * req = [[HFBindPhoneReq alloc] init];
    req.phoneNumber = phone;
    req.passWord = [password MD5Digest];
    req.sourceAccountType = [GlobInfo shareInstance].userType; //1：新浪2微信3qq
    req.deviceType = 4;//设备类型 3：安卓；4：ios
    
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:@"DataRes" completion:^(HFRetModel *ret) {
        if (ret.bSuccess)
        {
            DataRes * res = (DataRes *)ret.data;
            HFUserInfoModel * model = [[HFUserInfoModel alloc] init];
            model.account = [GlobInfo shareInstance].account;
            model.password = [password MD5Digest];
            model.userType = [GlobInfo shareInstance].userType;
            [self savaUserInfo:model andUser:res.user];
        }
        block(ret.bSuccess);
    }];
}

- (void)logoutWithComplete:(LoginFinishBlock)block
{
    HFLogoutReq *req = [[HFLogoutReq alloc]init];
    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:nil completion:^(HFRetModel *ret) {
        block(ret.bSuccess);
    }];
    
    HIUserType type = (HIUserType)[[GlobInfo shareInstance] userType];
    
    if (type !=  HIUserTypeMobile)
    {
        ShareType sharetype = [self transfromHIUserType:type];
        [ShareSDK cancelAuthWithType:sharetype];
    }
    
    [[HFHabitHelper shareInstance] cancelAllLocalNotication];
    [kUserDefaults removeObjectForKey:kParamAccount];
    [kUserDefaults removeObjectForKey:kParamUserInfo];
    [kUserDefaults removeObjectForKey:kParamPassword];
    [kUserDefaults removeObjectForKey:kParamUserType];
    [kUserDefaults removeObjectForKey:kParamLastDate];
    [kUserDefaults synchronize];
}

- (void)modifyWithInfo:(HFModifyInfoReq *)req success:(complete)complete
{
    [[BaseHFHttpClient shareInstance]beginHttpRequest:req parse:nil completion:^(HFRetModel *ret) {
        complete (ret.bSuccess);
    }];
}

- (void)PreRegisterWihtMobile:(NSString *)mobile success:(complete)complete
{
    HFPreRegisterReq *req = [[HFPreRegisterReq alloc]init];
    req.phoneNumber = mobile;
    [[BaseHFHttpClient shareInstance]beginHttpRequest:req parse:nil completion:^(HFRetModel *ret) {
        complete (ret.bSuccess);
    }];
}

- (void)sentVercodeWithMobile:(NSString *)mobile success:(complete)complete
{
    HFSentVercodeReq *req = [[HFSentVercodeReq alloc]init];
    req.phoneNumber = mobile;
    [[BaseHFHttpClient shareInstance]beginHttpRequest:req parse:nil completion:^(HFRetModel *ret) {
        complete (ret.bSuccess);
    }];
}

- (void)checkVercode:(HFCheckVercodeReq *)req success:(complete)complete
{
    [[BaseHFHttpClient shareInstance]beginHttpRequest:req parse:nil completion:^(HFRetModel *ret) {
        complete (ret.bSuccess);
    }];
}

- (void)getUserInfo:(complete)complete
{
    HFGetUserInfoReq *req = [[HFGetUserInfoReq alloc]init];
    
    [[BaseHFHttpClient shareInstance]beginHttpRequest:req parse:@"DataRes" completion:^(HFRetModel *ret) {
        if (ret.bSuccess) {
            DataRes *res = (DataRes*)ret.data;
            NSDictionary *dic = [res.user toDictionary];
            [[GlobInfo shareInstance]setUserInfo:dic];
            complete(YES);
        }else {
            complete(NO);
        }
    }];
}

- (void)getUserHomePage:(NSInteger)userId completion:(getUserHomeBlock)block
{
    HFGetUserHomeReq *req = [[HFGetUserHomeReq alloc]init];
    req.userId = userId;
    [[BaseHFHttpClient shareInstance]beginHttpRequest:req parse:@"HomePageRes" completion:^(HFRetModel *ret) {
        HomePageRes *res = (HomePageRes*)ret.data;
        block(res.data, ret.bSuccess);
    }];
}

#pragma mark -
#pragma mark private method

- (void)inToAutoLoginProcessWithcomplete:(LoginFinishBlock)block
{
    UserRes *user = [GlobInfo shareInstance].usr;
    
    HFUserInfoModel * model = [[HFUserInfoModel alloc] init];
    model.account = [GlobInfo shareInstance].account;
    model.password = [GlobInfo shareInstance].password;
    model.nickname = user.nickName;
    model.sex = user.sex;
    model.userType = [GlobInfo shareInstance].userType;
    
    [[[HIIProxy shareProxy] userProxy] loginWithModel:model complete:^(BOOL finish) {
        block(finish);
    }];
}

- (void)transfromLocalLogin:(id<ISSPlatformUser>)userInfo withType:(ShareType)userType complete:(LoginFinishBlock)block
{
    HIUserType type = [self transfromShareType:userType];
    
    HFUserInfoModel * model = [[HFUserInfoModel alloc] init];
    model.photo = [userInfo profileImage];
    model.account = [userInfo uid];
    model.sex = [userInfo gender];
    model.nickname = [userInfo nickname];
    model.userType = type;
    [self loginWithModel:model complete:^(BOOL finish) {
        block(finish);
    }];
}

- (HIUserType)transfromShareType:(ShareType)userType
{
    HIUserType type;
    if (userType == ShareTypeSinaWeibo)
    {
        type = HIUserTypeWeiBo;
    }
    else if(userType == ShareTypeQQSpace)
    {
        type = HIUserTypeWeQQ;
    }
    else
    {
        type = HIUserTypeWeChat;
    }
    return type;
}

- (ShareType)transfromHIUserType:(HIUserType)userType
{
    ShareType type;
    if (userType == HIUserTypeWeQQ)
    {
        type = ShareTypeQQSpace;
    }
    else if(userType == HIUserTypeWeiBo)
    {
        type = ShareTypeSinaWeibo;
    }
    else
    {
        type = ShareTypeWeixiTimeline;
    }
    return type;
}

//保存信息
- (void)savaUserInfo:(HFUserInfoModel*)userModel andUser:(UserRes *)user
{
    NSDictionary *dic = [user toDictionary];
    [[GlobInfo shareInstance]setUserInfo:dic];
    [[GlobInfo shareInstance]setAccount:userModel.account];
    [[GlobInfo shareInstance]setPassword:userModel.password];
    [[GlobInfo shareInstance]setUserType:userModel.userType];
    
//    if (user.activeDay>0) {
//        [[GlobInfo shareInstance]setActiveDay:user.activeDay];
//    }
    //保存token到服务器
    [self saveDeviceToken:[[GlobInfo shareInstance] token]];
    
    [[[HIIProxy shareProxy] habitProxy] checkNeedUpdateWithCompletion:^(BOOL finish) {
        if (!finish)
        {
            DDLogInfo(@"拉取习惯闹钟列表失败!");
        }
    }];
}

//保存token
//-(BOOL)saveDeviceToken :(NSString *) deviceToken{
//    if (deviceToken.length==0) {
//        return NO;
//    }
//    HFSaveDeviceTokenReq * req = [[HFSaveDeviceTokenReq alloc]init];
//    
//    req.deviceType = HIOSTypeIOS;// android 3  ios 4
//    req.bdChannelId = deviceToken;
//    req.iOSCredentialType = @"2"; // IOS 推送证书类型， 1 个人版， 2 企业
//    
//    DDLogInfo(@"save deviceToken : %@",deviceToken);
//    
//    [[BaseHFHttpClient shareInstance] beginHttpRequest:req parse:@"HFSaveDeviceTokenRes" success:^(ResponseData *responseData) {
//        HFSaveDeviceTokenRes * res = (HFSaveDeviceTokenRes *)responseData;
//        if(res.recode == 1){
//            DDLogInfo(@"save deviceToken Success : %@",deviceToken);
//        }
//        
//    } fail:^{
//        NSLog(@"save deviceToken !!!请求失败");
//    }];
//    return true;
//}

@end
