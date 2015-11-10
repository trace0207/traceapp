//
//  UIWebView+JavaScriptAlert.h
//  GuanHealth
//
//  Created by 栋栋 施 on 15/10/14.
//  Copyright © 2015年 ChinaMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (JavaScriptAlert)

-(void)webView:(UIWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame;

//-(BOOL)webView:(UIWebView *)sender runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame;

@end
