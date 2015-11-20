//
//  TK_BaseNavSettingViewController.h
//  tracedemo
//
//  Created by 罗田佳 on 15/11/20.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKBaseViewController.h"
#import "UIViewController+TKNavigationBarSetting.h"

@interface TK_BaseNavSettingViewController : TKBaseViewController


-(void)TKI_setBarDefaultLeftBack;
-(void)TKI_setBarDefaultTitle:(NSString *) title;
-(void)TKI_setBarLeftActiveText:(NSString *)text;
-(void)TKI_setBarRightDefaultText:(NSString *)text;

-(void)TKI_leftBarAction;
-(void)TKI_rightBarAction;

@end
