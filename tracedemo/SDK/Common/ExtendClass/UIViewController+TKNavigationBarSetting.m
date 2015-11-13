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

/**
 *  设置 导航左侧的 image 菜单事件
 *  @param image         image
 *  @param target        sel target object
 *  @param action        selector event
 *  @param controlEvents UIControlEvent
 */
-(void)TKsetLeftBarItemImage:(nonnull UIImage * )image
                   addTarget:(nullable id)target
                      action:(nonnull SEL)action
            forControlEvents:(UIControlEvents)controlEvents{

    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, TK_NAV_BarIconWidth, TK_NAV_BarIconHeight)];
    [btn setImage:image forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:controlEvents];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    if(self.tabBarController){
        [self.tabBarController.navigationItem setLeftBarButtonItem:barItem];
    }else{
        [self.navigationItem setLeftBarButtonItem:barItem];
    }
}


-(void)TKsetLeftBarItemText:(nonnull NSString *)text
              withTextColor:(nullable UIColor*)color
                  addTarget:(nullable id)target
                     action:(nonnull SEL)action
           forControlEvents:(UIControlEvents)controlEvents{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, TK_NAV_BarIconHeight)];
    [btn setTitle:text forState:UIControlStateNormal];
    [[btn titleLabel] setFont:[UIFont systemFontOfSize:16]];
    [[btn titleLabel] setTextAlignment:NSTextAlignmentLeft];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:controlEvents];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    if(self.tabBarController){
        [self.tabBarController.navigationItem setLeftBarButtonItem:barItem];
    }else{
        [self.navigationItem setLeftBarButtonItem:barItem];
    }

    
}


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
             forControlEvents:(UIControlEvents)controlEvents{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, TK_NAV_BarIconWidth, TK_NAV_BarIconHeight - 5)];
    [btn setImage:image forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:controlEvents];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    if(self.tabBarController){
        [self.tabBarController.navigationItem setRightBarButtonItem:barItem];
    }else{
        [self.navigationItem setRightBarButtonItem:barItem];
    }
}


/**
 *  删除导航左边的 buttom
 */
-(void)TKremoveLeftBarButtonItem{
    
    if(self.tabBarController){
        [self.tabBarController.navigationItem setLeftBarButtonItems:nil];
        [self.tabBarController.navigationItem setLeftBarButtonItem:nil];

    }else{
        [self.navigationItem setLeftBarButtonItems:nil];
        [self.navigationItem setLeftBarButtonItem:nil];

    }
}

/**
 *  删除导航右边的 buttom
 */
-(void)TKremoveRightBarButtonItem{
    
    if(self.tabBarController){
        [self.tabBarController.navigationItem setRightBarButtonItem:nil];
        [self.tabBarController.navigationItem setRightBarButtonItems:nil];
    }else{
        [self.navigationItem setRightBarButtonItem:nil];
        [self.navigationItem setRightBarButtonItems:nil];

    }
}


/**
 * 设置导航的title
 **/
-(void)TKaddNavigationTitle:(NSString * )title{
    
    if (self.tabBarController)
    {
        [self.tabBarController.navigationItem setTitle:title];
        [self.tabBarController.navigationItem setTitle:title];

    }
    else
    {
        [self.navigationItem setTitle:title];
    }
    
}


/**
 * 删除导航title
 **/
-(void)TKremoveNavigationTitle{
    if (self.tabBarController)
    {
        [self.tabBarController.navigationItem setTitle:nil];
        [self.tabBarController.navigationItem setTitleView:nil];
    }
    else
    {
        [self.navigationItem setTitleView:nil];
        [self.navigationItem setTitle:nil];
    }
    
}


/**
  设置导航view
 **/
- (void)TKaddNavigationTitleView:(UIView *)titleView
{
    if (self.tabBarController)
    {
        [self.tabBarController.navigationItem setTitleView:titleView];
    }
    else
    {
        [self.navigationItem setTitleView:titleView];
    }
}

@end
