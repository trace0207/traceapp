//
//  TKBuyerCenterViewController.h
//  tracedemo
//
//  Created by zhuxiaoxia on 16/3/31.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TKIBaseNavWithDefaultBackVC.h"

@interface TKBuyerCenterViewController : TKIBaseNavWithDefaultBackVC
@property (nonatomic,assign)BOOL isBuyer;

+(void)showUserPage:(NSString *)userId isBuyer:(BOOL)isBuyer;


@end
