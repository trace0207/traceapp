//
//  TKWebViewController.m
//  tracedemo
//
//  Created by cmcc on 16/3/16.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TKWebViewController.h"
#import "UIColor+TK_Color.h"
#import "Masonry.h"
#import "TKProxy.h"
#import "WebViewJavascriptBridge.h"
#import "TKPayProxy.h"
#import "TKAlertView.h"
#import "GlobNotifyDefine.h"
#import "TKUserCenter.h"
#import "GoodsDetailViewController.h"
#import "TKAfterSalesViewController.h"
#import "TKChatViewController.h"
//#import "TK_LoginAck.h"


//@interface UserAddress : JSONModel
//
//
////    address = "\U6c34\U7535\U8d39\U6492\U6253\U53d1\U65af\U8482\U82ac\U68b5\U8482\U5188\U548c";
////    city = "\U5357\U5f00\U533a";
////    id = 33;
////    isDefault = 0;
////    postcode = 344343;
////    province = "\U5929\U6d25";
////    receiver = "\U6c34\U7535\U8d39";
////    receiverMobile = 13000000000;
////    userId = 1;
//
//@property (nonatomic,copy) NSString * address;
//@property (nonatomic,copy) NSString * city;
//@property (nonatomic,copy) NSString * id;
//@property (nonatomic,copy) NSString * postcode;
//@property (nonatomic,copy) NSString * province;
//@property (nonatomic,copy) NSString * receiver;
//@property (nonatomic,copy) NSString * receiverMobile;
//@property (nonatomic,copy) NSString * userId;
//
//@end
//
//
//@implementation UserAddress
//
//
//@end



@interface TKWebViewController ()<UIWebViewDelegate>
{
    WebViewJavascriptBridge * bridge;
    bool load;

}



@end


@implementation TKWebViewController



+(void)showWebView:(NSString *)title url:(NSString *) url
{
    TKWebViewController *vc = [[TKWebViewController alloc] init];
    vc.hidDefaultBackBtn = NO;
    if(![url containsString:@"http"])
    {
        url = [[TKProxy proxy].tkBaseUrl stringByAppendingString:url];
        
    }
    vc.defaultURL = url;
    vc.navTitle = title;
    [[AppDelegate getMainNavigation] pushViewController:vc animated:YES];
}


+(void)showWebView:(NSString *)title url:(NSString *) url withDelegate:(id<TKWebViewDelegate>)delegate
{
    TKWebViewController *vc = [[TKWebViewController alloc] init];
    vc.hidDefaultBackBtn = NO;
    if(![url containsString:@"http"])
    {
        url = [[TKProxy proxy].tkBaseUrl stringByAppendingString:url];
        
    }
    vc.defaultURL = url;
    vc.navTitle = title;
    vc.delegate = delegate;
    [[AppDelegate getMainNavigation] pushViewController:vc animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self initView];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    if(load)
    {
        [self.webView reload];
        
    }
    else
    {
        load = YES;
    }
}


-(void)onPayBack:(NSNotification *)notify
{
    NSString * result = notify.object;
    if([result isEqualToString:@"success"])
    {
        [TKAlertView showSuccessWithTitle:@"尾款支付成功" withMessage:@"请等待买手购买发货" commpleteBlock:nil cancelTitle:nil determineTitle:@"确定"];
    }
    else
    {
        [TKAlertView showFailedWithTitle:@"尾款支付失败" withMessage:@"支付异常或者是支付被取消" commpleteBlock:nil cancelTitle:nil determineTitle:@"取消"];
    }
}



-(void)initView
{
    self.webView.backgroundColor = [UIColor tkThemeColor1];
    [self.view addSubview:self.webView];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        
    }];
    
    bridge = [WebViewJavascriptBridge bridgeForWebView:_webView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"ObjC received message from JS: %@", data);
        responseCallback(@"Response for message from ObjC");
    }];
    WS(weakSelf)
    [bridge registerHandler:@"hiifitFunction" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSDictionary * dic = (NSDictionary *)data;
        NSString * actionString = [dic objectForKey:@"action"];
        [weakSelf handleJSONString:actionString withData:[dic objectForKey:@"data"]];
        
    }];
    
    NSURL * url = [NSURL URLWithString:_defaultURL];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    self.webView.scalesPageToFit = YES;
    [self.webView loadRequest:request];
}

-(UIWebView *)webView
{
    if(!_webView)
    {
        _webView = [[UIWebView alloc] init];
    }
    return _webView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    bridge = nil;
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
    DDLogInfo(@"webcallBack %@  action %@",dataDic, actionString);
    if([@"pay" isEqualToString:actionString])// 支付
    {
        NSString * str = [dataDic objectForKey:@"fundType"];
        NSInteger fundType = [str integerValue];
        [TKPayProxy selectPayWay:[dataDic objectForKey:@"payAmount"] rewardId:[dataDic objectForKey:@"postrewardId"] fundType:fundType withBlock:^(PayResult result) {
            if(result == PaySuccess)
            {
                [TKAlertView showSuccessWithTitle:@"尾款支付成功" withMessage:@"请等待买手购买发货" commpleteBlock:nil cancelTitle:nil determineTitle:@"确定"];
            }
            else
            {
                [TKAlertView showFailedWithTitle:@"尾款支付失败" withMessage:@"支付异常或者是支付被取消" commpleteBlock:nil cancelTitle:nil determineTitle:@"取消"];
            }
        }];

    }
    else if([@"linkToNewWindow" isEqualToString:actionString]) // 打开新窗口
    {
        NSString * relativeUrl = [dataDic objectForKey:@"url"];
        [TKWebViewController showWebView:@"订单详情" url:relativeUrl];
        
    }
    else if([@"telservice" isEqualToString:actionString]) //联系客服
    {
        [UIKitTool callPhone:SERVER];
    }
    else if([@"addressId" isEqualToString:actionString] || [@"addressDefault" isEqualToString:actionString])
    {
        [self onAddressChange:actionString data:dataDic];
    }else if([@"postrewardDetail" isEqualToString:actionString])
    {
        NSString * rewardId = [dataDic objectForKey:@"postrewardId"];
        [GoodsDetailViewController showDetailById:rewardId];
    }else if([@"service" isEqualToString:actionString])
    {
//        NSString * rewardId = [dataDic objectForKey:@"postrewardId"];
        NSString * orderId = [dataDic objectForKey:@"orderId"];
        [TKAfterSalesViewController showAfterSalesView:orderId];
    }
    else if([@"talk" isEqualToString:actionString])
    {
        // 联系买手
        NSString * purchaserId = [dataDic objectForKey:@"purchaserId"];
        [TKChatViewController showChatView:purchaserId isBuyer:YES];
    }
}


-(void)onAddressChange:(NSString *)action data:(NSDictionary *)data
{
    
    Address * address = [[Address alloc] initWithDictionary:data error:nil];
    
    if([@"addressDefault" isEqualToString:action])
    {
        [TKUserCenter instance].getUser.ackData.defaultReceiver = address;
    }else
    {
     if(self.delegate)
     {
         [self.delegate onAddressChange:address];
         [self.navigationController popViewControllerAnimated:YES];
     }
    }
    
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onPayBack:) name:TKPayNotify object:nil];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TKPayNotify object:nil];
}


//2016-04-12 21:34:14:914 [5749:1540879][TKWebViewController.m:158][-[TKWebViewController handleJSONString:withData:]] webcallBack {
//    address = "\U6c34\U7535\U8d39\U6492\U6253\U53d1\U65af\U8482\U82ac\U68b5\U8482\U5188\U548c";
//    city = "\U5357\U5f00\U533a";
//    id = 33;
//    isDefault = 0;
//    postcode = 344343;
//    province = "\U5929\U6d25";
//    receiver = "\U6c34\U7535\U8d39";
//    receiverMobile = 13000000000;
//    userId = 1;
//}  action addressDefault
//2016-04-12 21:34:22:151 [5749:1540879][TKWebViewController.m:158][-[TKWebViewController handleJSONString:withData:]] webcallBack {
//    address = "Did xi lu. 550  ha0";
//    city = "\U676d\U5dde";
//    id = 35;
//    isDefault = 0;
//    postcode = 111110;
//    province = "\U6d59\U6c5f";
//    receiver = "Luo tian jia";
//    receiverMobile = 18867101952;
//    userId = 1;
//} action addressId


@end
