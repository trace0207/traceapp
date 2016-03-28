//
//  HFHUDView.m
//  GuanHealth
//
//  Created by shi_dongdong on 15/5/26.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFHUDView.h"

@implementation HFHUDView

SYNTHESIZE_SINGLETON_FOR_CLASS_PROTOTYPE(HFHUDView, shareInstance);

- (void) ShowTips:(NSString*)strTips  delayTime:(NSTimeInterval)delay  atView:(UIView*)pView
{
    if (strTips == nil || strTips.length == 0) {
        return;
    }
    if (HUD != NULL &&  HUD.superview)
    {
        HUD.mode = MBProgressHUDModeText;
        HUD.detailsLabelText = strTips;
        
        sleep(delay);
    }
    else
    {
        
        if (pView == nil)
        {
            //pView = [[UIApplication sharedApplication] keyWindow];//这里可能为nil ？？
            pView = [[UIView alloc]initWithFrame:kScreenBounds];
        }
        MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:pView animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabelText = strTips;
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:delay];
    }
}


- (void) showWaiting:(NSString*)strTips WhileExecuting:(SEL)method onTarget:(id)target withObject:(id)object animated:(BOOL)animated   atView:(UIView*)pView
{
    if (pView == NULL)
    {
        //pView = [[UIApplication sharedApplication] keyWindow];
        pView = [[UIView alloc]initWithFrame:kScreenBounds];
    }
    
    HUD = [[MBProgressHUD alloc] initWithView:pView];
    HUD.delegate = self;
    
    [pView addSubview:HUD];
    
    HUD.detailsLabelText = strTips;
    
    [HUD showWhileExecuting:method onTarget:target withObject:object animated:animated];
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
    HUD = nil;
}
@end
