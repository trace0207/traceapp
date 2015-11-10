//
//  HFHUDView.h
//  GuanHealth
//
//  Created by shi_dongdong on 15/5/26.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"



@interface HFHUDView : NSObject<MBProgressHUDDelegate>
{
    MBProgressHUD * HUD;
}

SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(HFHUDView, shareInstance);

- (void) ShowTips:(NSString*)strTips  delayTime:(NSTimeInterval)delay atView:(UIView*)pView;

- (void) showWaiting:(NSString*)strTips WhileExecuting:(SEL)method onTarget:(id)target withObject:(id)object animated:(BOOL)animated  atView:(UIView*)pView;

@end
