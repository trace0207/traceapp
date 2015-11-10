//
//  TKMainNavigateController.m
//  tracedemo
//
//  Created by cmcc on 15/9/20.
//  Copyright (c) 2015年 trace. All rights reserved.
//

#import "TKMainNavigateController.h"
#import "TKHomePageViewController.h"
#import "UIColor+TK_Color.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"
#import "UIViewController+TKNavigationBarSetting.h"
#import "HFNewMainViewController.h"
#import "HFMomentsViewController.h"
#import "UserInfoViewController.h"


@interface TKMainNavigateController()<HomePageEventProtocol>
{

}

@end


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
    TKHomePageViewController * subTabVC1  = [[TKHomePageViewController alloc] init];
    subTabVC1.tabBarItem.image=IMG(@"new_mainPageUnselected");
    subTabVC1.tabBarItem.selectedImage = IMG(@"new_mainPageSelected");
    subTabVC1.tabBarItem.title=@"首页";
    [self setupLeftMenuButton:subTabVC1];
//    [self setupNavigationRightButton:subTabVC1];
    
    HFNewMainViewController * newMain = [[HFNewMainViewController alloc] init];
    newMain.tabBarItem.title=@"搜索";
    newMain.tabBarItem.image=IMG(@"new_mainPageUnselected");
    newMain.tabBarItem.selectedImage = IMG(@"new_mainPageSelected");
    
    HFMomentsViewController * newChat = [[HFMomentsViewController alloc] init];
    newChat.tabBarItem.title = @"晒单";
    newChat.tabBarItem.image = IMG(@"new_hiMomentUnselected");
    newChat.tabBarItem.selectedImage = IMG(@"new_hiMomentSelected");
    
    UserInfoViewController * newUser = [[UserInfoViewController alloc] init];
    newUser.tabBarItem.title = @"消息";
    newUser.tabBarItem.image = IMG(@"new_myUnselected");
    newUser.tabBarItem.selectedImage = IMG(@"new_mySelected");
    
//    TKSubTabBarViewController * subTabVC5  = [[TKSubTabBarViewController alloc] init];
    UINavigationController * navc5 = [[UINavigationController alloc]init];
    navc5.title = @"我";
    navc5.navigationItem.title = @"我的个人中心";
    navc5.tabBarItem.image = [UIImage imageNamed:@"tk_icon_user_3_b"];
    
    self.selectedIndex =0;
    self.viewControllers = @[subTabVC1,newMain,newChat,newUser,navc5];
    
    [self addChildViewController:navc5];
}

//
//-(TKMainNavigateController*)getMainViewController{
//    
//    
//    //        UIViewController *vc = [self.window rootViewController];
//    TKMainNavigateController * tabBar = [[TKMainNavigateController alloc] init];
//    tabBar.selectedIndex = 0;
//    BaseNavViewController *nav = [[BaseNavViewController alloc]initWithRootViewController:tabBar];
//    nav.navigationBar.translucent = NO;
//    
//    HFNewMainViewController * newMain = [[HFNewMainViewController alloc] init];
//    newMain.tabBarItem.title=@"首页";
//    newMain.tabBarItem.image=IMG(@"new_mainPageUnselected");
//    newMain.tabBarItem.selectedImage = IMG(@"new_mainPageSelected");
//    
//    HFMomentsViewController * newChat = [[HFMomentsViewController alloc] init];
//    newChat.tabBarItem.title = @"嗨圈";
//    newChat.tabBarItem.image = IMG(@"new_hiMomentUnselected");
//    newChat.tabBarItem.selectedImage = IMG(@"new_hiMomentSelected");
//    
//    UserInfoViewController * newUser = [[UserInfoViewController alloc] init];
//    newUser.tabBarItem.title = @"我的";
//    newUser.tabBarItem.image = IMG(@"new_myUnselected");
//    newUser.tabBarItem.selectedImage = IMG(@"new_mySelected");
//    
//    [[UITabBar appearance]setTintColor:[UIColor HFColorStyle_5]];
//    //[[UITabBar appearance]setBarTintColor:[UIColor HFColorStyle_6]];
//    
//    tabBar.viewControllers=@[newMain,newChat,newUser];
//    return tabBar;
//    
//}



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

#pragma mark - Bar delegate
-(void)leftBarIconDidClick{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

@end
