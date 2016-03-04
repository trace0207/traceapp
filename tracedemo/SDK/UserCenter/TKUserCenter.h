//
//  TKUserCenter.h
//  tracedemo
//
//  Created by cmcc on 15/11/11.
//  Copyright © 2015年 trace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TK_UserNormalViewModel.h"


@interface TKUser : NSObject
@property (nonatomic, assign)CGFloat score;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *vip;


@property (nonatomic, copy) NSString *birthday;//用户生日yyyy-mm-dd
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *headPortraitUrl;  //头像
@property (nonatomic, copy) NSString *signature;//签名
@property (nonatomic, copy) NSString *deviceId;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *guarantee; //保证金
@property (nonatomic,assign)NSInteger sex;
@property (nonatomic, assign)BOOL isLogin;
@end



@interface TKUserCenter : NSObject


SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(TKUserCenter, instance);

@property (nonatomic,strong)TK_UserNormalViewModel * userNormalVM;
@property (nonatomic,strong)TKUser * tempUserData;

-(void)initFromLocalHistory;
-(BOOL)isLogin;
-(void)onLoginSuccess:(TKUser *)user;
-(void)doLogin:(NSString *)userName password:(NSString *)password;
-(TKUser *)getUser;
@end
