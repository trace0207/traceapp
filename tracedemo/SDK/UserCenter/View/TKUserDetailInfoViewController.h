//
//  TKUserDetailInfoViewController.h
//  tracedemo
//
//  Created by cmcc on 15/12/13.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKIBaseNavWithDefaultBackVC.h"
@class TKUserCenter,TKUser;

@interface TKUserDetailInfoViewController : TKIBaseNavWithDefaultBackVC

@property (nonatomic,strong) NSString * userId;
@property (nonatomic,strong) TKUser * user;

@end
