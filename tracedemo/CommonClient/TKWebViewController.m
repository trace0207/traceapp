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

@interface TKWebViewController ()


@end

@implementation TKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hidDefaultBackBtn = YES;
    [self initView];
    
}


-(void)initView
{
    self.webView.backgroundColor = [UIColor tkThemeColor1];
    [self.view addSubview:self.webView];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        
    }];
    
#if B_Client
    _defaultURL = [[TKProxy proxy].tkBaseUrl  stringByAppendingString:@"/web/apollo/order/orderlist.html?role=0"];
#else
    _defaultURL = [[TKProxy proxy].tkBaseUrl  stringByAppendingString:@"/web/apollo/order/orderlist.html?role=1"];
#endif
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
