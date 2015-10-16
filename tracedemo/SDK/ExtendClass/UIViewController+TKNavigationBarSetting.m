//
//  UIViewController+TKNavigationBarSetting.m
//  tracedemo
//
//  Created by 罗田佳 on 15/10/14.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "UIViewController+TKNavigationBarSetting.h"

@implementation UIViewController (TKNavigationBarSetting)

#define TK_NAV_BarIconWidth 28
#define TK_NAV_BarIconHeight 28

-(void)TKaddLeftBarItemImage:(nonnull UIImage * )image
                   addTarget:(nullable id)target
                      action:(nonnull SEL)action
            forControlEvents:(UIControlEvents)controlEvents{

    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, TK_NAV_BarIconWidth, TK_NAV_BarIconHeight)];
    [btn setImage:image forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:controlEvents];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    [self.navigationItem setLeftBarButtonItem:barItem];
    
}


/**
 *  设置 导航右侧的 image 菜单事件
 *  @param image         image
 *  @param target        sel target object
 *  @param action        selector event
 *  @param controlEvents UIControlEvent
 */
-(void)TKaddRightBarItemImage:(nonnull UIImage *)image
                    addTarget:(nullable id)target
                       action:(nonnull SEL)action
             forControlEvents:(UIControlEvents)controlEvents{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, TK_NAV_BarIconWidth, TK_NAV_BarIconHeight - 5)];
    [btn setImage:image forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:controlEvents];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    [self.navigationItem setRightBarButtonItem:barItem];
}

@end
