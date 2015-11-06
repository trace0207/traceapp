//
//  UIViewController+TKNavigationBarSetting.h
//  tracedemo
//
//  Created by 罗田佳 on 15/10/14.
//  Copyright © 2015年 trace. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (TKNavigationBarSetting)

/**
 *  设置导航左侧的  image菜单
 *
 *  @param image         image
 *  @param target        sel target object
 *  @param action        selector event
 *  @param controlEvents UIControlEvent
 */
-(void)TKaddLeftBarItemImage:(nonnull UIImage *)image
                   addTarget:(nullable id)target
                      action:(nonnull SEL)action
            forControlEvents:(UIControlEvents)controlEvents;

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
             forControlEvents:(UIControlEvents)controlEvents;

@end
