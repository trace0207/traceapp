//
//  TKUserCenter.m
//  tracedemo
//
//  Created by cmcc on 15/11/11.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKUserCenter.h"

@implementation TKUser

@end

@interface TKUserCenter(){

}

@property(nonatomic,strong)TKUser * user;
@end

@implementation TKUserCenter


SYNTHESIZE_SINGLETON_FOR_CLASS_PROTOTYPE(TKUserCenter,instance);

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
@end
