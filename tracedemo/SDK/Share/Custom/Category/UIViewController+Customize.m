//
//  UIViewController+Customize.m
//  GuanHealth
//
//  Created by hermit on 15/2/28.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "UIViewController+Customize.h"

@implementation UIViewController (Customize)

- (void)addDefaultLeftBarItem
{
    [self addLeftBarItemWithImageName:@"icon_back"];
}

- (void)addLeftBarItemWithTitle:(NSString*)title
{
    UINavigationItem *navItem = nil;
    
    if (self.tabBarController)
    {
        navItem = self.tabBarController.navigationItem;
    }else {
        navItem = self.navigationItem;
    }
    if (!title) {
        [navItem setLeftBarButtonItem:nil];
        [navItem setLeftBarButtonItems:nil];
    }else {
        UIButton *barButton = [self buttonWithTitle:title];
        [barButton addTarget:self action:@selector(leftBarItemAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:barButton];
        barButton.tag = navItem.leftBarButtonItems.count + 1;
        
        if (navItem.leftBarButtonItems.count>0) {
            NSMutableArray *items = [NSMutableArray arrayWithArray:navItem.leftBarButtonItems];
            [items addObject:barItem];
            [navItem setLeftBarButtonItems:items];
        }else {
            [navItem setLeftBarButtonItem:barItem];
        }
    }
}

- (void)addLeftBarItemWithImageName:(NSString *)imageName
{
    UINavigationItem *navItem = nil;
    
    if (self.tabBarController)
    {
        navItem = self.tabBarController.navigationItem;
    }else {
        navItem = self.navigationItem;
    }
    if (!imageName) {
        [navItem setLeftBarButtonItem:nil];
        [navItem setLeftBarButtonItems:nil];
    }else {
        UIButton *barButton = [self buttonWithImage:imageName];
        [barButton addTarget:self action:@selector(leftBarItemAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:barButton];
        barButton.tag = navItem.leftBarButtonItems.count + 1;
        
        if (navItem.leftBarButtonItems.count>0) {
            NSMutableArray *items = [NSMutableArray arrayWithArray:navItem.leftBarButtonItems];
            [items addObject:barItem];
            [navItem setLeftBarButtonItems:items];
        }else {
            [navItem setLeftBarButtonItem:barItem];
        }
    }
}

- (void)addLeftBarItemWithCustomView:(UIView *)view
{
    UINavigationItem *navItem = nil;
    
    if (self.tabBarController)
    {
        navItem = self.tabBarController.navigationItem;
    }else {
        navItem = self.navigationItem;
    }
    if (!view) {
        [navItem setLeftBarButtonItem:nil];
        [navItem setLeftBarButtonItems:nil];
    }else {
        view.tag = navItem.leftBarButtonItems.count + 1;
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:view];
        
        if (navItem.leftBarButtonItems.count>0) {
            NSMutableArray *items = [NSMutableArray arrayWithArray:navItem.leftBarButtonItems];
            [items addObject:item];
            [navItem setLeftBarButtonItems:items];
        }else {
            [navItem setLeftBarButtonItem:item];
        }
        
    }
}

- (void)leftBarItemAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addRightBarItemWithTitle:(NSString*)title
{
    UINavigationItem *navItem = nil;
    
    if (self.tabBarController)
    {
        navItem = self.tabBarController.navigationItem;
    }else {
        navItem = self.navigationItem;
    }
    
    if (!title) {
        [navItem setRightBarButtonItem:nil];
        [navItem setRightBarButtonItems:nil];
        
    }else{
        UIButton *btn = [self buttonWithTitle:title];
        btn.tag = navItem.rightBarButtonItems.count + 1;
        [btn addTarget:self action:@selector(rightBarItemAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
        
        if (navItem.rightBarButtonItems.count>0) {
            NSMutableArray *items = [NSMutableArray arrayWithArray:navItem.rightBarButtonItems];
            [items addObject:barItem];
            [navItem setRightBarButtonItems:items];
        }else {
            [navItem setRightBarButtonItem:barItem];
        }
    }
}

- (void)addRightBarItemWithImageName:(NSString *)imageName
{
    UINavigationItem *navItem = nil;
    
    if (self.tabBarController)
    {
        navItem = self.tabBarController.navigationItem;
    }else {
        navItem = self.navigationItem;
    }
    
    if (!imageName) {
        [navItem setRightBarButtonItem:nil];
        [navItem setRightBarButtonItems:nil];
        
    }else{
        UIButton *btn = [self buttonWithImage:imageName];
        btn.tag = navItem.rightBarButtonItems.count + 1;
        [btn addTarget:self action:@selector(rightBarItemAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
        
        if (navItem.rightBarButtonItems.count>0) {
            NSMutableArray *items = [NSMutableArray arrayWithArray:navItem.rightBarButtonItems];
            [items addObject:barItem];
            [navItem setRightBarButtonItems:items];
        }else {
            [navItem setRightBarButtonItem:barItem];
        }
    }
}

- (void)addRightBarItemWithCustomView:(UIView *)view
{
    UINavigationItem *navItem = nil;
    
    if (self.tabBarController)
    {
        navItem = self.tabBarController.navigationItem;
    }else {
        navItem = self.navigationItem;
    }
    if (!view) {
        [navItem setRightBarButtonItem:nil];
        [navItem setRightBarButtonItems:nil];
    }else {
        view.tag = navItem.rightBarButtonItems.count + 1;
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:view];
        
        if (navItem.rightBarButtonItems.count>0) {
            NSMutableArray *items = [NSMutableArray arrayWithArray:navItem.rightBarButtonItems];
            [items addObject:item];
            [navItem setRightBarButtonItems:items];
        }else {
            [navItem setRightBarButtonItem:item];
        }
        
    }
}

- (void)rightBarItemAction:(id)sender
{
    //从右到左 sender的tag值依次是1、2、3...
}

- (void)addNavigationTitle:(NSString*)title
{
    //if (!title) {
        if (self.tabBarController)
        {
            [self.tabBarController.navigationItem setTitleView:nil];
            [self.tabBarController.navigationItem setTitle:nil];
        }
        else
        {
            [self.navigationItem setTitleView:nil];
            [self.navigationItem setTitle:nil];
        }
        //return;
    //}

    if (self.tabBarController)
    {
        [self.tabBarController.navigationItem setTitle:title];
    }
    else
    {
        [self.navigationItem setTitle:title];
    }
}

- (void)setNavigationTitleView:(UIView *)titleView
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

- (UIButton *)buttonWithTitle:(NSString *)title
{
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16]};
    CGSize size = [title sizeWithAttributes:attributes];
    CGFloat width = size.width<44?44:size.width;
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, width, 44)];
    [btn setTitle:title forState:UIControlStateNormal];
    [[btn titleLabel]setFont:[UIFont systemFontOfSize:16]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return btn;
}

- (UIButton *)buttonWithImage:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 44)];
    [btn setImage:image forState:UIControlStateNormal];
    return btn;
}

@end
