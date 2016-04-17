//
//  AppDelegate.h
//  tracedemo
//
//  Created by cmcc on 15/9/7.
//  Copyright (c) 2015年 trace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TK_BaseAppDelegate.h"
#import "BaseNavViewController.h"

typedef void(^complete)(BOOL finished);

@interface AppDelegate : TK_BaseAppDelegate
@property (assign, nonatomic) BOOL appActiviting;

- (void)goMainViewController;
- (void)goLoginViewController;
- (void)goGuideViewController;

- (void)pushHabitDetailFromNotication:(UILocalNotification *)notification;
- (void)goModuleDetail:(NSInteger)moduleId;

+(BaseNavViewController *)getMainNavigation;
+(AppDelegate *)getAppDelegate;
+(UIViewController *)appRootViewController;
-(void)logouToLoginView;
@end

