//
//  TKIBaseNavWithDefaultBackVC.h
//  tracedemo
//
//  Created by 罗田佳 on 15/11/20.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKBaseViewController.h"
#import "TK_BaseNavSettingViewController.h"

@interface TKIBaseNavWithDefaultBackVC : TK_BaseNavSettingViewController

@property (nonatomic,assign)BOOL hidDefaultBackBtn;
@property (nonatomic,strong)NSString * navTitle;

@end
