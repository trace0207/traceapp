//
//  TKUserCenter.m
//  tracedemo
//
//  Created by cmcc on 15/11/11.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKUserCenter.h"

@interface TKUser(){

    
}

@property (nonatomic, copy,readwrite) NSString *userId;

@end
@implementation TKUser



@end

@interface TKUserCenter(){

}

@property(nonatomic,strong,readwrite)TKUser * user;
@end

@implementation TKUserCenter


SYNTHESIZE_SINGLETON_FOR_CLASS_PROTOTYPE(TKUserCenter,instance);


-(TKUser *)user{

    if(!self.user){
    
        self.user  = [[TKUser alloc] init];
    }
    return _user;
}

-(BOOL)isLogin{
    return false;
}

-(void)onLoginSuccess:(TKUser *)user{
    
}

-(void)doLogin:(NSString *)userName password:(NSString *)password{

    
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

@end
