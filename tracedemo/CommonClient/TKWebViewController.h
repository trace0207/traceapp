//
//  TKWebViewController.h
//  tracedemo
//
//  Created by cmcc on 16/3/16.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TKIBaseNavWithDefaultBackVC.h"

@interface TKWebViewController : TKIBaseNavWithDefaultBackVC

@property (strong,nonatomic) UIWebView *webView;
@property (strong,nonatomic) NSString * defaultURL;

@end
