//
//  sijiacheWebViewcontroller.m
//  rentCar
//
//  Created by duonuo on 14-6-21.
//  Copyright (c) 2014年 duonuo. All rights reserved.
//

#import "WebViewController.h"
#import "UserCenterViewController.h"
#import "HFHabitRecordViewController.h"
#import "HFHabitTimeDetailViewController.h"
#import "HFThirdPartyCenter.h"
#import "WebViewJavascriptBridge.h"
#import "NSString+HFStrUtil.h"
#import "HFAddHabitViewController.h"

@interface WebViewController () <UIWebViewDelegate>

@property(nonatomic,strong) WebViewJavascriptBridge* bridge;
@property (nonatomic, strong) NSDictionary * activityDic;

@end

@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //self.title = @"加载中...";
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *urlString = [self.param valueForKey:kParamURL];
    
    self.from = [self.param valueForKey:kParamFrom];
    NSURL * url = [NSURL URLWithString:urlString];
    if (url) {
        NSURLRequest* request = [NSURLRequest requestWithURL:url];
        _webView.scalesPageToFit = YES;
        [_webView loadRequest:request];
    }
    if (_moduleType != 0 && _moduleType != HIModuleTypeBanner && _moduleType != HIModuleTypeGame && _moduleType != HIModuleTypeActivity) {
        [self addRightBarItemWithImageName:@"icon_share"];
    }
    
    _bridge = [WebViewJavascriptBridge bridgeForWebView:_webView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"ObjC received message from JS: %@", data);
        responseCallback(@"Response for message from ObjC");
    }];
    
    [_bridge registerHandler:@"umengEvent" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"umengEvent called: %@", data);
        NSDictionary * dict = (NSDictionary *)data;
        NSString * key = [dict objectForKey:@"key"];
        NSString * value = [dict objectForKey:@"value"];
        [MobClick event:[dict objectForKey:@"result"] attributes:@{key : value}];
    }];
    
    [_bridge registerHandler:@"gotoPersonalHomepage" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSString * userID = (NSString *)data;
        [self goUserCenterView:[userID intValue]];
    }];
    
    [_bridge registerHandler:@"gotoHabitHomeActivity" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSDictionary * dict = (NSDictionary *)data;
        
        NSInteger habitId = [[dict objectForKey:@"habitId"] integerValue];
        NSString * habitName = [[dict objectForKey:@"habitName"] URLDecodedForString];
        NSString * habitUrl = [dict objectForKey:@"habitUrl"];
        NSString * habitNote = [dict objectForKey:@"note"];
        [self goHabitRecordVC:habitId habitName:habitName habitIconUrl:habitUrl habitNote:habitNote];
        
    }];
    
    [_bridge registerHandler:@"gotoHabitSettingsActivity" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSDictionary * dict = (NSDictionary *)data;
        
        NSInteger habitId = [[dict objectForKey:@"habitId"] integerValue];
        NSString * habitName = [[dict objectForKey:@"habitName"] URLDecodedForString];
        NSString * habitUrl = [dict objectForKey:@"habitUrl"];
        
        [self goHabitRecordVC:habitId habitName:habitName habitIconUrl:habitUrl habitNote:nil];
        
    }];
    
    [_bridge registerHandler:@"share" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSDictionary * dic = [(NSDictionary *)data objectForKey:@"shareText"];
        [[HFThirdPartyCenter shareInstance] shareSDKShare:self HiifitType:_moduleType dataDic:dic];
    }];
    
    [_bridge registerHandler:@"close" handler:^(id data, WVJBResponseCallback responseCallback) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [_bridge registerHandler:@"setShareBtn" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSDictionary * dic = (NSDictionary *)data;
        if ([[dic objectForKey:@"hidden"] isEqual:@0]) {
            [self addRightBarItemWithImageName:@"icon_share"];
            self.activityDic = dic;
        }
        if ([[dic objectForKey:@"hidden"] isEqual:@1]) {
            self.navigationItem.rightBarButtonItem = nil;
        }
    }];
}


- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (![[BaseHFHttpClient shareInstance] bNetReachable]) {
        [self.webView stopLoading];
        [[HFHUDView shareInstance] ShowTips:_T(@"HF_Common_Check_Net") delayTime:1.0 atView:NULL];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftBarItemAction:(id)sender
{
    if ([_webView canGoBack]) {
        [_webView goBack];
    }else{
        if (self.moduleType == HIModuleTypeHealthNews) {
            [MobClick event:Scheme_HealthReport_Back];
        }
        [super leftBarItemAction:sender];
    }
}

- (void)rightBarItemAction:(id)sender
{
    if (self.moduleType == HIModuleTypeHealthNews) {
        [MobClick event:Scheme_HealthReport_Share];
    }
    //需要替换为第三方的分享
    if (self.moduleType == HIModuleTypeActivity || self.moduleType == HIModuleTypeBanner) {
        [[HFThirdPartyCenter shareInstance] shareSDKShare:self HiifitType:_moduleType dataDic:self.activityDic];
    }else{
        [[HFThirdPartyCenter shareInstance] shareSDKShare:self HiifitType:_moduleType dataDic:nil];
    }
}

- (void)goUserCenterView:(int)userid
{
    UserCenterViewController *vc = [[UserCenterViewController alloc]init];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInt:userid] forKey:kParamUserId];
    vc.param = dic;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)addJSToWebView
{
    NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"js"];
    NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    [_webView stringByEvaluatingJavaScriptFromString:appHtml];
}

- (void)goHabitRecordVC:(NSInteger)habitId
              habitName:(NSString *)habitName
           habitIconUrl:(NSString *)habitIconUrl
              habitNote:(NSString *)note
{
    NSArray *views = self.navigationController.viewControllers;
    UIViewController *popVC = [views objectAtIndex:views.count-2];
    if (habitId == 0) {
        HFAddHabitViewController * createNewVc = [[HFAddHabitViewController alloc] init];
        createNewVc.popViewController = popVC;
        createNewVc.mHabitName = habitName;
        [self.navigationController pushViewController:createNewVc animated:YES];
    }else{
        HFHabitRecordViewController *vc = [[HFHabitRecordViewController alloc]initWithNibName:@"HFHabitRecordViewController" bundle:nil];
        vc.habitId = habitId;
        vc.habitName = habitName;
        vc.habitIconUrl = habitIconUrl;
        vc.popViewController = popVC;
        vc.habitNote = note;
        [self.navigationController pushViewController: vc animated:YES];
    }
}

#pragma WebViwController -Delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [self addNavigationTitle:title];
}

-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if (error.code == NSURLErrorCancelled) {
        [webView stopLoading];
        
    }
}

@end
