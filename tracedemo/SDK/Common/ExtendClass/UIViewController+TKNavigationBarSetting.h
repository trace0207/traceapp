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
-(void)TKsetLeftBarItemImage:(nonnull UIImage *)image
                   addTarget:(nullable id)target
                      action:(nonnull SEL)action
            forControlEvents:(UIControlEvents)controlEvents;


/**
 *  设置导航左侧的  title
 *
 *  @param NSString         text
 *  @param target        sel target object
 *  @param action        selector event
 *  @param controlEvents UIControlEvent
 */
-(void)TKsetLeftBarItemText:(nonnull NSString *)text
              withTextColor:(nullable UIColor*)color
                   addTarget:(nullable id)target
                      action:(nonnull SEL)action
            forControlEvents:(UIControlEvents)controlEvents;



-(void)TKaddMultipleLeftBarItem:(nonnull UIImage *)icon
                      withDescription:(nonnull NSString *)discrip
                   discripColor:(nonnull UIColor *)color
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
-(void)TKsetRightBarItemImage:(nonnull UIImage *)image
                    addTarget:(nullable id)target
                       action:(nonnull SEL)action
             forControlEvents:(UIControlEvents)controlEvents;


/**
 *  删除导航左边的 buttom
 */
-(void)TKremoveLeftBarButtonItem;

/**
 *  删除导航右边的 buttom
 */
-(void)TKremoveRightBarButtonItem;

/**
 *  设置 导航的title
 */
-(void)TKaddNavigationTitle:(nonnull NSString *)title;
/**
 *  删除导航的title
 */
-(void)TKremoveNavigationTitle;

/**
 设置导航view
 **/
- (void)TKaddNavigationTitleView:(nullable UIView *)titleView;

@end
