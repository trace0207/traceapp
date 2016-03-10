//
//  HiiBeanWebViewController.m
//  GuanHealth
//
//  Created by 朱伟特 on 16/1/7.
//  Copyright © 2016年 ChinaMobile. All rights reserved.
//

#import "HiiBeanWebViewController.h"
#import "WebViewJavascriptBridge.h"
#import "SentPostViewController.h"
#import "HFAdvanceSchemeContainerViewController.h"
#import "HFThirdPartyCenter.h"
#import "UserCenterViewController.h"
#import "HFAddHabitViewController.h"
#import "HFHabitRecordViewController.h"
#import "NSString+HFStrUtil.h"
//#import "HFFlashView.h"
#import "HFPostBarController.h"
#import "HFSchemeListViewController.h"

#define kHowToMake @"howToMake"
#define kColor @"color"
#define kTitle @"title"
#define kShareBtn @"shareBtn"
#define kBackToWhere @"backToWhere"
#define kClickToWhere @"clickToWhere"
#define kShare @"share"
#define kUmeng @"umengEvent"
#define kNewWeb @"clickToWhereInNew"
#define kCloseWeb @"closeWebview"

@interface HiiBeanWebViewController ()<UIWebViewDelegate>
{
    BOOL goBackVC;//为在web界面内跳转设定的布尔值，回退进入新的url。再回退的时候会回到原生界面
    NSString * backUrlString;//回退的时候跳转的url
}
//@property (nonatomic, strong) HFFlashView *flashView;
@property (nonatomic, strong) WebViewJavascriptBridge * bridge;
@property (nonatomic, strong) NSDictionary * activityDic;
@property (nonatomic ,strong) NSString * mNavColorStr;
@property (nonatomic, strong) NSDictionary * dataDic;

@end

@implementation HiiBeanWebViewController




- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //self.title = @"加载中...";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hidDefaultBackBtn = YES;
    self.navTitle = @"我的购买";
    
//    [self setNavigationTitleView:self.flashView];
    
    WS(weakSelf)
    NSString *urlString = [self.param valueForKey:kParamURL];
    NSURL * url = [NSURL URLWithString:urlString];
    if (url) {
        NSURLRequest* request = [NSURLRequest requestWithURL:url];
        _webView.scalesPageToFit = YES;
        [_webView loadRequest:request];
    }
//    if (_moduleType != 0 && _moduleType != HIModuleTypeBanner && _moduleType != HIModuleTypeGame && _moduleType != HIModuleTypeActivity && _moduleType != HIModuleTypeShareInvite) {
//        [self addRightBarItemWithImageName:@"share_friend"];
//    }

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
        [weakSelf goUserCenterView:[userID intValue]];
    }];
    
    [_bridge registerHandler:@"gotoHabitHomeActivity" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSDictionary * dict = (NSDictionary *)data;
        
        NSInteger habitId = [[dict objectForKey:@"habitId"] integerValue];
        NSString * habitName = [[dict objectForKey:@"habitName"] URLDecodedForString];
        NSString * habitUrl = [dict objectForKey:@"habitUrl"];
        NSString * habitNote = [dict objectForKey:@"note"];
        [weakSelf goHabitRecordVC:habitId habitName:habitName habitIconUrl:habitUrl habitNote:habitNote];
        
    }];
    
    [_bridge registerHandler:@"gotoHabitSettingsActivity" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSDictionary * dict = (NSDictionary *)data;
        
        NSInteger habitId = [[dict objectForKey:@"habitId"] integerValue];
        NSString * habitName = [[dict objectForKey:@"habitName"] URLDecodedForString];
        NSString * habitUrl = [dict objectForKey:@"habitUrl"];
        
        [weakSelf goHabitRecordVC:habitId habitName:habitName habitIconUrl:habitUrl habitNote:nil];
        
    }];
    [_bridge registerHandler:@"updateTitle" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSDictionary * dic = (NSDictionary *)data;
        NSString * navigationTitle = [dic objectForKey:@"title"];
        //[weakSelf addNavigationTitle:navigationTitle];
//        [weakSelf.title];
    }];
    
    [_bridge registerHandler:@"setShareBtn" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSDictionary * dic = (NSDictionary *)data;
        if ([[dic objectForKey:@"hidden"] isEqual:@0]) {
            if (weakSelf.navigationItem.rightBarButtonItems.count == 0) {
                [weakSelf addRightBarItemWithImageName:@"share_friend"];
                weakSelf.activityDic = dic;
            }
        }
        if ([[dic objectForKey:@"hidden"] isEqual:@1]) {
            weakSelf.navigationItem.rightBarButtonItem = nil;
        }
    }];

    [_bridge registerHandler:@"hiifitFunction" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSDictionary * dic = (NSDictionary *)data;
        NSString * actionString = [dic objectForKey:@"action"];
        [weakSelf handleJSONString:actionString withData:[dic objectForKey:@"data"]];

    }];
    [_bridge registerHandler:@"share" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSDictionary * dic = [(NSDictionary *)data objectForKey:@"shareText"];
//        [[HFThirdPartyCenter shareInstance] webViewShareSDKShare:self HiifitType:HIModuleTypeActivity dataDic:dic withDelegate:self];
    }];
    [_bridge registerHandler:@"close" handler:^(id data, WVJBResponseCallback responseCallback) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    
    // Do any additional setup after loading the view from its nib.
}

//- (HFFlashView *)flashView
//{
//    if (!_flashView) {
//        _flashView = [[HFFlashView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-120, 44)];
//        _flashView.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
//    }
//    return  _flashView;
//}
//-(void)handlerJSEvent:(NSString *)action withJsonData:(NSString *)jsonStr
//{
//    NSObject * obj = jsonStr;
//    
//    if(true)
//        else
//        {
//            
//        }
//    
//    
//    
//}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
//    NSString * url = [self.param objectForKey:kParamURL];
//    
//    if ([url isEqualToString:KHiBeanShopURL])
//    {
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromColor:[UIColor NewYearColor]] forBarMetrics:UIBarMetricsDefault];
//    }
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
//    if (self.mNavColorStr)
//    {
//         [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromColor:[UIColor hexChangeFloat:self.mNavColorStr]] forBarMetrics:UIBarMetricsDefault];
//    }
    
    if (![[BaseHFHttpClient shareInstance] bNetReachable]) {
        [self.webView stopLoading];
    }
    if ([[self.param objectForKey:kParamURL] isEqualToString:kURLFoodSearch]) {
        self.fd_interactivePopDisabled = YES;
    }
//    if (comeFrom == HF_FromAfter) {
//        [self.webView stringByEvaluatingJavaScriptFromString:@"gobackFun()"];
//    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if ([[self.param objectForKey:kParamURL] isEqualToString:kURLFoodSearch]) {
        self.fd_interactivePopDisabled = NO;
    }
}

- (void)leftBarItemAction:(id)sender
{
   
    
//    if ([[self.param objectForKey:kParamURL] isEqualToString:kURLHabitList]) {
//        [MobClick event:EVENT22];
//    }
    
    //如果要返回的连接为空或者不存在，走webview系统的返回
    if (backUrlString == nil || backUrlString.length == 0) {
        //如果需要干掉当前的webview，则走系统的干掉当前webview方法
        if (goBackVC) {
            [super leftBarItemAction:sender];
            return;
        }
        //如果webview已经返回到了栈顶，则走系统方法干掉当前webview
        if(![_webView canGoBack])
        {
            [super leftBarItemAction:sender];
        }
        //否则直接往后退
        else
        {
             [_webView goBack];
        }
        
    }else
    {
        //如果连接为closewebview就干掉当前的webview
        if ([backUrlString isEqualToString:kCloseWeb]) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        //如果链接含有http打头的字串，则加载此链接
        else if ([backUrlString hasPrefix:@"http"]){
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:backUrlString]]];
            //加载完成之后将链接置空
            backUrlString = nil;
            //这个时候将干掉webview设置为YES，如果这个链接加载完成之后没有新的backUrlString传过来的话，goBackVC会一直为YES的，这样在第二次进入此方法的时候会直接干掉当前的webview。如果链接加载完成之后有新的backUrlString传过来。再点击的时候会再走这个方法。如果没有backURLString，那么就会判断字符串是否为空，如果为空，再判断gobackvc是不是yes，如果是yes的话直接干掉当前的webview，很显然goBackvc此时是yes
            goBackVC = YES;
        }
        //否则跳转到iOS原生的
        else{
            if (goBackVC) {
                [super leftBarItemAction:sender];
                return;
            }
            //跳转到原生iOS界面
            [self pushNaturalPage:backUrlString withData:self.dataDic];
        }
    }
}
- (void)rightBarItemAction:(id)sender
{
    //需要替换为第三方的分享
    if (self.moduleType == HIModuleTypeActivity || self.moduleType == HIModuleTypeBanner) {
//        [[HFThirdPartyCenter shareInstance] webViewShareSDKShare:self HiifitType:_moduleType dataDic:self.activityDic withDelegate:self];

    }else{
//        [[HFThirdPartyCenter shareInstance] webViewShareSDKShare:self HiifitType:_moduleType dataDic:nil withDelegate:self];

    }
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
//    //[self addNavigationTitle:title];
//    [self.flashView setText:title];
//    comeFrom = HF_FromAfter;

}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    if (error.code == NSURLErrorCancelled) {
        [webView stopLoading];
    }
    else
    {
        NSString* path = [[NSBundle mainBundle] pathForResource:@"404" ofType:@"html"];
        NSURL* url = [NSURL fileURLWithPath:path];
        NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
        [webView loadRequest:request];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - PrivateFunction
/*
hiifitJSBridge("hiifitFunction","howToMake",JSON.stringify({}));						//直达如何赚嗨豆
hiifitJSBridge("hiifitFunction","color",JSON.stringify({"color":"#FFF000"}));		//标题栏颜色
hiifitJSBridge("hiifitFunction","title",JSON.stringify({"title":"xxxxxxx"}));			//标题
hiifitJSBridge("hiifitFunction","shareBtn",JSON.stringify({"hidden":false, "title":"title", "desc":"desc", "pic":"pic", "link":"link"}));			//标题栏是否展示分享按钮及分享按钮内容

hiifitJSBridge("hiifitFunction","backToWhere",JSON.stringify({"url":"https://183.13.131.113:8080/CloudHealth/web/hiishop/index.html"}));
hiifitJSBridge("hiifitFunction","backToWhere",JSON.stringify({"url":"home","data":{"webview":"1","schemeId":2,"isTested":isSelect,"finish":1}}));
//为后退按钮添加事件，直达某页面或URL，page和url同时只会有一个值不为"",如果为url，清除webview历史记录，data中为原生页面相关参数，其中webview为必选项，=1时关闭当前webview，=0时保留当前webview
hiifitJSBridge("hiifitFunction","clickToWhere",JSON.stringify({"url":"https://183.13.131.113:8080/CloudHealth/web/hiishop/index.html"}));
hiifitJSBridge("hiifitFunction","clickToWhere",JSON.stringify({"url":"home","data":{"webview":1,"schemeId":2,"isTested":isSelect,"finish":1}}));
//直接触发页面变化，直达某页面或URL，page和url同时只会有一个值不为"",如果为url，清除webview历史记录,data中为原生页面相关参数，其中webview为必选项，=1时关闭当前webview，=0时保留当前webview
*/
/*以下两个接口废止，统一通过clickToWhere调用
 hiifitJSBridge("hiifitFunction","seniorPlan",JSON.stringify({"schemeId":2,"isTested":isSelect,"finish":1}));//跳转到id为2，订阅情况为isSelect的原生方案页面
 hiifitJSBridge("hiifitFunction","moment",JSON.stringify({"modelId ":10000,"type":2,"finish":1}));	//跳转到心情贴发帖
 */
- (void)handleJSONString:(NSString *)actionString withData:(NSDictionary *)dataDic
{
    //改变navigation的背景色
    if ([actionString isEqualToString:kColor]) {
        [self changeNavigationColor:[dataDic objectForKey:kColor]];
    }
    //改变navigation的title
    if ([actionString isEqualToString:kTitle]) {
        //[self addNavigationTitle:[dataDic objectForKey:kTitle]];
//        [self.flashView setText:[dataDic objectForKey:kTitle]];
    }
    //是否在webview右上角添加分享按钮
    if ([actionString isEqualToString:kShareBtn]) {
        [self showShareButton:dataDic];
    }
    //load如何赚嗨豆的界面
    if ([actionString isEqualToString:kHowToMake]) {
//        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:KGainHiBean]]];
    }
    //直接出发某个界面的更新
    if ([actionString isEqualToString:kBackToWhere]) {
        [self backToWhere:dataDic];
    }
    //点击按钮回退到某个新的url或进入iOS原生界面
    if ([actionString isEqualToString:kClickToWhere]) {
        [self clickButtonToWhere:dataDic];
    }
    //分享框弹出
    if ([actionString isEqualToString:kShare]) {
        [self showShareView:dataDic];
    }
    //友盟事件
    if ([actionString isEqualToString:kUmeng]) {
        [self doUmengEvent:[dataDic objectForKey:@"data"]];
    }
    //打开一个新的webview玩儿
    if ([actionString isEqualToString:kNewWeb]) {
        [self openNewWeb:dataDic];
    }
}
- (void)changeNavigationColor:(NSString *)colorStr
{
    if ([colorStr hasPrefix:@"#"])
    {
        colorStr = [colorStr substringFromIndex:1];
    }
    
    self.mNavColorStr = colorStr;
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromColor:[UIColor hexChangeFloat:colorStr]] forBarMetrics:UIBarMetricsDefault];
}
- (void)showShareButton:(NSDictionary *)shareDic
{
    if ([[shareDic objectForKey:@"hidden"] isEqual:@0]) {
        if (self.navigationItem.rightBarButtonItems.count == 0) {
            [self addRightBarItemWithImageName:@"share_friend"];
            self.activityDic = shareDic;
        }
    }else{
        self.navigationItem.rightBarButtonItem = nil;
    }
}
- (void)showShareView:(NSDictionary *)shareDic
{
//    [[HFThirdPartyCenter shareInstance] shareSDKShare:self HiifitType:HIModuleTypeActivity dataDic:shareDic];
//    [[HFThirdPartyCenter shareInstance] webViewShareSDKShare:self HiifitType:HIModuleTypeActivity dataDic:shareDic withDelegate:self];

}
- (void)doUmengEvent:(NSDictionary *)dataDic
{
    NSString * key = [dataDic objectForKey:@"key"];
    NSString * value = [dataDic objectForKey:@"value"];
    [MobClick event:[dataDic objectForKey:@"result"] attributes:@{key : value}];
}
- (void)openNewWeb:(NSDictionary *)dataDic
{
    NSString * urlString = [dataDic objectForKey:@"url"];
    HiiBeanWebViewController * vc = [[HiiBeanWebViewController alloc] init];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:urlString forKey:kParamURL];
    vc.param = dic;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)clickButtonToWhere:(NSDictionary *)dataDic
{
    NSString * urlStr = [dataDic objectForKey:@"url"];
    if ([urlStr hasPrefix:@"http"]) {
        //加载传过来的链接
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
        goBackVC = YES;
    }else if(urlStr == nil || urlStr.length == 0)
    {
        goBackVC = NO;//为防止传过来的urlstring为空的话直接干掉当前webview，所以置为NO。
    }else if ([urlStr isEqualToString:kCloseWeb]){
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        //跳转到原生界面
        [self pushNaturalPage:urlStr withData:dataDic];
    }
}
- (void)backToWhere:(NSDictionary *)dataDic
{
    NSString * urlStr = [dataDic objectForKey:@"url"];
    if ([urlStr hasPrefix:@"http"]) {
        //如果是链接的话，把链接存储为全局变量。方便按返回按钮跳转到新的链接
        backUrlString = urlStr;
    }else if(urlStr == nil || urlStr.length == 0)
    {
        backUrlString = @"";
        goBackVC = NO;//为防止传过来的urlstring为空的话直接干掉当前webview，所以置为NO。
    }else if ([urlStr isEqualToString:kCloseWeb]){
        backUrlString = kCloseWeb;
    }else{
        //将跳转的原生iOS字段和附加的数据存储下来方便返回按钮跳转到原生界面
        backUrlString = urlStr;
        self.dataDic = dataDic;
    }
}
- (void)pushNaturalPage:(NSString *)urlStr withData:(NSDictionary *)dataDic
{
    //跳转到调理方案首页
    if ([urlStr isEqualToString:@"seniorPlan"]) {
        [self goToSchemePage:[dataDic objectForKey:@"data"]];
    }
    //跳转到发帖界面
    if ([urlStr isEqualToString:@"moment"]) {
        [self goToSentPostPage:[dataDic objectForKey:@"data"]];
    }
    //跳转到调理贴吧
    if ([urlStr isEqualToString:@"seniorPlanBBS"]) {
        [self goToPostBarPage:[dataDic objectForKey:@"data"]];
    }
    //跳转到习惯主页
    if ([urlStr isEqualToString:@"habitHome"]) {
        [self goHabitRecordVC:[[[dataDic objectForKey:@"data"] objectForKey:@"id"] intValue] habitName:nil habitIconUrl:nil habitNote:nil];
    }
    //跳转到创建习惯
    if ([urlStr isEqualToString:@"habitSettings"]) {
        int userId = [[[dataDic objectForKey:@"data"] objectForKey:@"userId"] intValue];
        NSString * habitName = [[dataDic objectForKey:@"data"] objectForKey:@"name"];
        [self goHabitRecordVC:userId habitName:habitName habitIconUrl:nil habitNote:nil];
    }
    //跳转到个人主页
    if ([urlStr isEqualToString:@"PersonalHome"]) {
        [self goUserCenterView:[[[dataDic objectForKey:@"data"] objectForKey:@"userId"] intValue]];
    }
    //跳转到方案列表
    if ([urlStr isEqualToString:@"schemeList"]) {
        [self goSchemeListVC];
    }
}
- (void)goToSchemePage:(NSDictionary *)dataDic
{
    BOOL finished = [[dataDic objectForKey:@"webview"] boolValue];
    NSInteger schemeId = [[dataDic objectForKey:@"schemeId"] integerValue];
    BOOL test = [[dataDic objectForKey:@"isTested"] boolValue];
    HFAdvanceSchemeContainerViewController * advanceVC = [[HFAdvanceSchemeContainerViewController alloc] init];
    advanceVC.adSchemeID = schemeId;
    advanceVC.bBeginUse = !test;
//    if (!finished) {
//        advanceVC.bPopToRootVC = YES;
//    }
    [self.navigationController pushViewController:advanceVC animated:YES];
}
- (void)goToSentPostPage:(NSDictionary *)dataDic
{
    BOOL finished = [[dataDic objectForKey:@"webview"] boolValue];
    SentPostViewController * sentPostVC = [[SentPostViewController alloc] init];
    sentPostVC.sendPostType = HFSendPost;
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:FromPersonal forKey:kParamFrom];
    sentPostVC.param = dic;
    if (!finished) {
        sentPostVC.popViewController = [[self.navigationController viewControllers] firstObject];
    }
    [self.navigationController pushViewController:sentPostVC animated:YES];
}
- (void)goToPostBarPage:(NSDictionary *)dataDic
{
    BOOL finished = [[dataDic objectForKey:@"webview"] boolValue];
    NSInteger schemId = [[dataDic objectForKey:@"schemeId"] integerValue];
    HFPostBarController * postBarVC = [[HFPostBarController alloc] init];
    postBarVC.schemeId = schemId;
//    if (!finished) {
//        postBarVC.bPopToRootVC = YES;
//    }
    [self.navigationController pushViewController:postBarVC animated:YES];
}
//去个人中心
- (void)goUserCenterView:(int)userid
{
    UserCenterViewController *vc = [[UserCenterViewController alloc]init];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInt:userid] forKey:kParamUserId];
    vc.param = dic;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)goSchemeListVC
{
    HFSchemeListViewController * schemeListVC = [[HFSchemeListViewController alloc] init];
    [self.navigationController pushViewController:schemeListVC animated:YES];
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
//        createNewVc.state = Habit_Creat_New;
        [self.navigationController pushViewController:createNewVc animated:YES];
    }else{
        HFHabitRecordViewController *vc = [[HFHabitRecordViewController alloc]initWithNibName:@"HFHabitRecordViewController" bundle:nil];
        vc.habitId = habitId;
        [self.navigationController pushViewController: vc animated:YES];
    }
}
#pragma mark - ThirdPartCenterDelegate
//webview分享成功的代理方法，分享成功后调用当前webview里的shareBack代理方法。
- (void)finishShare
{
    [self.webView stringByEvaluatingJavaScriptFromString:@"shareBack()"];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
