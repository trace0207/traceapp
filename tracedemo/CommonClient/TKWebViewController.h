//
//  TKWebViewController.h
//  tracedemo
//
//  Created by cmcc on 16/3/16.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TKIBaseNavWithDefaultBackVC.h"
#import "TK_LoginAck.h"


@protocol TKWebViewDelegate <NSObject>

@optional

-(void)onAddressChange:(Address *)address;

@end

@interface TKWebViewController : TKIBaseNavWithDefaultBackVC


@property (strong,nonatomic) UIWebView *webView;
@property (strong,nonatomic) NSString * defaultURL;
@property (weak,nonatomic)id<TKWebViewDelegate> delegate;

+(void)showWebView:(NSString *)title url:(NSString *) url;

+(void)showWebView:(NSString *)title url:(NSString *) url withDelegate:(id<TKWebViewDelegate>) delegate;

@end
