//
//  TKUserCenter.m
//  tracedemo
//
//  Created by cmcc on 15/11/11.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKUserCenter.h"
#import "TK_LoginAck.h"
#import "GlobNotifyDefine.h"
#import "TK_CategoryListAck.h"
#import "NSString+HFStrUtil.h"
#import "Pingpp.h"
#import "TKProxy.h"

@interface TKUser(){

    
}

@end
@implementation TKUser

- (NSString *)getSexString
{
    return self.sex == 1?@"女":@"男";
}

@end

@interface TKUserCenter(){

}

@property(nonatomic,strong,readwrite)TKUser * user;
@end

@implementation TKUserCenter


SYNTHESIZE_SINGLETON_FOR_CLASS_PROTOTYPE(TKUserCenter,instance);


-(TKUser *)user{

    if(!_user){
    
        _user  = [[TKUser alloc] init];
    }
    return _user;
}

-(TKUser *)tempUserData{

    if(!_tempUserData){
    
        _tempUserData = [[TKUser alloc] init];
    }
    return _tempUserData;
}


-(BOOL)isLogin{
    return self.user && self.user.isLogin;
}

-(void)onLoginSuccess:(TKUser *)user{
    
    
    self.user  = user;
    self.user.isLogin = YES;
    // TODO test 下面是测试代码
//    self.user.address = @"浙江省杭州市西湖区西溪路555号7号楼401";
//    self.user.signature = @"走自己的路，让别人的BB吧";
//    self.user.headPortraitUrl = TKDefaultHead;
//    self.user.nickName = ;
//    self.user.score = 88;
    [[NSNotificationCenter defaultCenter] postNotificationName:TKUserLoginSuccess object:nil];
}


-(void)logout
{
    self.user.isLogin = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:TKUserLoginOut object:nil];
}



-(void)doLogin:(NSString *)userName password:(NSString *)password{

    
    //deviceId=123&mobile=18867102687&password=123456
    WS(weakSelf)
    [[TKProxy proxy].userProxy login:userName withValue:password withBlock:^(HF_BaseAck * ack){
        DDLogInfo(@"LoginData init %@",ack);
        if(ack.sucess){
            TK_LoginAck * loginAck = (TK_LoginAck *)ack;
            LoginAckData * loginData = (LoginAckData *)loginAck.data;
            TKUser * user = [[TKUser alloc] init];
            user.ackData = loginData;
            user.userId = loginData.id;
            user.nickName = loginData.nickName;
            user.mobile = loginData.mobile;
            user.signature = loginData.signature;
            user.headPortraitUrl = loginData.headerUrl;
            user.guarantee = loginData.guarantee;
            user.vip = loginData.vip;
            [self performSelectorOnMainThread:@selector(onLoginSuccess:) withObject:user waitUntilDone:NO];
            [weakSelf.userNormalVM restBuyerCateList:[loginData.beSubscribeCateList copy]];
        }
        
    }];

}

-(void)initFromLocalHistory{
    _user = [[TKUser alloc] init];
    _user.userId = @"100000";
    _user.nickName = @"trace990";
}

-(TKUser *)getUser{

    return _user;
}

-(TK_UserNormalViewModel *)userNormalVM{

    if(!_userNormalVM){
    
        _userNormalVM = [[TK_UserNormalViewModel alloc] init];
    }
    return _userNormalVM;
    
}

/**
 更新头像
 **/
-(void)updateHeadUrl:(NSString *)headUrl block:(tkUpdateUserInfoBlock)block
{
    TK_SetUserInfoArg * arg = [self buildUserInfoArgFromLocal];
    arg.headerUrl = headUrl;
    [self updateUserInfo:arg block:block];
}

/**
 更新性别
 **/
-(void)updateSex:(NSInteger)sex block:(tkUpdateUserInfoBlock)block
{
    TK_SetUserInfoArg * arg = [self buildUserInfoArgFromLocal];
    arg.sex = sex;
    [self updateUserInfo:arg block:block];
}

/**
 更新昵称
 **/
-(void)updateNickname:(NSString *)nickname block:(tkUpdateUserInfoBlock)block
{
    TK_SetUserInfoArg * arg = [self buildUserInfoArgFromLocal];
    arg.nickName = nickname;
    [self updateUserInfo:arg block:block];
}

/**
 更新个性签名
 **/
-(void)updateSignature:(NSString *)signature block:(tkUpdateUserInfoBlock)block
{
    TK_SetUserInfoArg * arg = [self buildUserInfoArgFromLocal];
    arg.signature = signature;
    [self updateUserInfo:arg block:block];
    
}

- (void)updateUserInfo:(TK_SetUserInfoArg *)arg block:(tkUpdateUserInfoBlock)block
{
    [[TKProxy proxy].userProxy updateUserInfo:arg
                                    withBlock:^(HF_BaseAck *ack) {
                                        
                                        if(ack.sucess)
                                        {
                                            [self updateLocalUserInfo:arg];
                                            block(YES);
                                        }else
                                        {
                                            block(NO);
                                        }
                                        
                                    }];
}

-(void)initAppData
{
    
    [Pingpp setDebugMode:YES];
    
    [[TKProxy proxy].mainProxy getBrandListWithBlock:^(HF_BaseAck *ack) {
        
        if(ack.sucess)
        {
            [self.userNormalVM resetBrandList:(TK_BrandListAck *)ack];
        }
        else
        {
            DDLogInfo(@"get user BrandList failed");
        }
        
//        DDLogInfo(@"%@",ack);
    }];
    
    [[TKProxy proxy].mainProxy getCategoryListWithBolck:^(HF_BaseAck *ack) {
        
        if(ack.sucess)
        {
//            TK_CategoryListAck * k = (TK_CategoryListAck*)ack;
            [self.userNormalVM resetCategorys:(TK_CategoryListAck *)ack];
//            DDLogInfo(@"abc%@",[NSString ArrayToNSString:k.data withSeparator:@";"]);
        }
        else
        {
              DDLogInfo(@"get user category failed");
        }
        
    }];

}


-(TK_SetUserInfoArg *)buildUserInfoArgFromLocal
{
    TK_SetUserInfoArg * arg = [[TK_SetUserInfoArg alloc] init];
    // TODO
    arg.nickName = self.user.nickName;
    arg.headerUrl = self.user.headPortraitUrl;
    arg.address = self.user.address;
    arg.signature = self.user.signature;
    arg.sex = self.user.sex;
#if B_Clent == 1
    arg.role = 0;
#else
    arg.role = 1;
#endif

    return arg;
}

- (void)updateLocalUserInfo:(TK_SetUserInfoArg *)arg
{
    self.user.sex = arg.sex;
    self.user.headPortraitUrl = arg.headerUrl;
    self.user.address = arg.address;
    self.user.signature = arg.signature;
    self.user.nickName = arg.nickName;
}


@end
