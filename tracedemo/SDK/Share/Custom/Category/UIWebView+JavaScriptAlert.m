//
//  UIWebView+JavaScriptAlert.m
//  GuanHealth
//
//  Created by 栋栋 施 on 15/10/14.
//  Copyright © 2015年 ChinaMobile. All rights reserved.
//

#import "UIWebView+JavaScriptAlert.h"
#import "HFAlertView.h"
@implementation UIWebView (JavaScriptAlert)

static BOOL diagStat = NO;

-(void)webView:(UIWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame{
    HFAlertView * dialogue = [HFAlertView initWithTitle:@"提示" withMessage:message commpleteBlock:^(NSInteger buttonIndex) {
        if (buttonIndex==0) {
            diagStat=YES;
        }else if(buttonIndex==1){
            diagStat=NO;
        }
    } cancelTitle:nil determineTitle:@"好"];
    [dialogue show];
}

//-(BOOL)webView:(UIWebView *)sender runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame{
////    UIAlertView* dialogue = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:NSLocalizedString(@"ok", @"Ok") otherButtonTitles:NSLocalizedString(@"Cancel", @"Cancel"), nil];
//    
//    
//    HFAlertView * dialogue = [HFAlertView initWithTitle:@"提示" withMessage:message commpleteBlock:^(NSInteger buttonIndex) {
//        if (buttonIndex==0) {
//            diagStat=YES;
//        }else if(buttonIndex==1){
//            diagStat=NO;
//        }
//    } cancelTitle:nil determineTitle:@"好"];
//    [dialogue show];
//    while (dialogue.hidden==NO && dialogue.superview!=nil) {
//        [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01f]];
//    }
//    return diagStat;
//}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
}


@end
