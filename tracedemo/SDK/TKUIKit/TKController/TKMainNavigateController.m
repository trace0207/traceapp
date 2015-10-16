//
//  TKMainNavigateController.m
//  tracedemo
//
//  Created by cmcc on 15/9/20.
//  Copyright (c) 2015年 trace. All rights reserved.
//

#import "TKMainNavigateController.h"
#import "TKSubTabBarViewController.h"
#import "UIColor+TK_Color.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"
#import "UIViewController+TKNavigationBarSetting.h"


@implementation TKMainNavigateController

+(TKMainNavigateController *)showNavigateControllerInWindow:(UIWindow *) window{

    TKMainNavigateController * vc = [[TKMainNavigateController alloc]init];
    window.rootViewController = vc;
    [window makeKeyAndVisible];
    return vc;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    // 设置导航背景颜色
    [[UINavigationBar appearance] setBarTintColor:[UIColor TKcolorWithHexString:TK_Color_white_background]];
    // 添加控制器
    // 首页
    TKSubTabBarViewController * subTabVC1  = [[TKSubTabBarViewController alloc] init];
    subTabVC1.navigationItem.title = @"晒单";
    
//    
//    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName,[UIColor redColor],UITextAttributeTextShadowColor,[UIFont boldSystemFontOfSize:20.0],NSFontAttributeName,CGSizeMake(0, -1.0),UITextAttributeTextShadowOffset, nil];
//    subTabVC1.navigationController.navigationBar.titleTextAttributes = dict;
//    
    UINavigationController * navc1 = [[UINavigationController alloc]initWithRootViewController:subTabVC1];
    navc1.title = @"首页";
    navc1.tabBarItem.image = [UIImage imageNamed:@"tk_icon_user_3_b"];
    [self addChildViewController:navc1];
    
    
    [self setupLeftMenuButton:subTabVC1];
    [self setupNavigationRightButton:subTabVC1];
    
    
    TKSubTabBarViewController * subTabVC2  = [[TKSubTabBarViewController alloc] init];
    subTabVC2.navigationItem.title = @"搜索";
    UINavigationController * navc2 = [[UINavigationController alloc]initWithRootViewController:subTabVC2];
    navc2.title = @"搜索";
    navc2.tabBarItem.image = [UIImage imageNamed:@"tk_icon_user_3_b"];
    [self addChildViewController:navc2];
    
    TKSubTabBarViewController * subTabVC3  = [[TKSubTabBarViewController alloc] init];
    UINavigationController * navc3 = [[UINavigationController alloc]initWithRootViewController:subTabVC3];
    subTabVC3.title = @"晒单";
    navc3.tabBarItem.image = [UIImage imageNamed:@"tk_icon_user_3_b"];
    [self addChildViewController:navc3];
    
    TKSubTabBarViewController * subTabVC4  = [[TKSubTabBarViewController alloc] init];
    UINavigationController * navc4 = [[UINavigationController alloc]initWithRootViewController:subTabVC4];
    subTabVC4.title = @"消息";
    navc4.tabBarItem.image = [UIImage imageNamed:@"tk_icon_user_3_b"];
    [self addChildViewController:navc4];
    
//    TKSubTabBarViewController * subTabVC5  = [[TKSubTabBarViewController alloc] init];
    UINavigationController * navc5 = [[UINavigationController alloc]init];
    navc5.title = @"我";
    navc5.navigationItem.title = @"我的个人中心";
    navc5.tabBarItem.image = [UIImage imageNamed:@"tk_icon_user_3_b"];
    [self addChildViewController:navc5];
}



#pragma mark - setting  Button Handlers

/**
 设置 导航左边按钮
 **/
-(void)setupLeftMenuButton:(UIViewController *)nv{
    
    [nv TKaddLeftBarItemImage:[UIImage imageNamed:@"tk_icon_setting_b"] addTarget:self action:@selector(leftDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    
}
/**
 设置 导航左边按钮  相机
 **/
-(void)setupNavigationRightButton:(UIViewController * )nv{
    [nv TKaddRightBarItemImage:[UIImage imageNamed:@"tk_icon_camera_b"] addTarget:self action:@selector(rightNavigationBarIconPress:) forControlEvents:UIControlEventTouchUpInside];
    
}


#pragma mark - Button Handlers
-(void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

-(void)rightNavigationBarIconPress:(id)sender{
//    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
    DDLogInfo(@"RightBar icon click ");
}

@end
