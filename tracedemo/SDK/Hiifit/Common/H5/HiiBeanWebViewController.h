//
//  HiiBeanWebViewController.h
//  GuanHealth
//
//  Created by 朱伟特 on 16/1/7.
//  Copyright © 2016年 ChinaMobile. All rights reserved.
//

#import "TKIBaseNavWithDefaultBackVC.h"
#define KEY_ADD_HABIT   @"addHabit"
#define KEY_ADD_FRIEND  @"addFriend"

@interface HiiBeanWebViewController : TKIBaseNavWithDefaultBackVC

@property (nonatomic,   copy)          NSString     *from;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, assign)          HIModuleType moduleType;
@property (nonatomic, strong) NSMutableDictionary      *param;

@end
