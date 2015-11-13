//
//  AppDelegate.m
//  tracedemo
//
//  Created by cmcc on 15/9/7.
//  Copyright (c) 2015年 trace. All rights reserved.
//

#import "AppDelegate.h"
#import "MMDrawerController.h"
#import "MenuViewController.h"
#import "MMNavigationController.h"
#import "MMExampleLeftSideDrawerViewController.h"
#import "MMExampleCenterTableViewController.h"
#import "MMExampleRightSideDrawerViewController.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "TKMainNavigateController.h"
#import "TKLeftMenuController.h"
#import "MMDrawerController.h"
#import "TKConstants.h"
#import "BaseNavViewController.h"
#import "UIColor+TK_Color.h"

@interface AppDelegate ()

@property (nonatomic,strong) MMDrawerController * drawerController;

@end



@implementation AppDelegate


-(BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    
    //    [self showNavigateView];
    return YES;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [super application:application didFinishLaunchingWithOptions:launchOptions];
    // Override point for customization after application launch.
    [self showSlideMenuController];
     self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
//    [NSThread sleepForTimeInterval:1.5];//  启动页停留 3 秒钟
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



#pragma mark -----Show  Controller detail -------



/**
 *  Description : 显示 侧滑菜单UI
 */
-(void)showSlideMenuController{
    // left Menu Controller
    UIViewController * leftVC = [[TKLeftMenuController alloc] initWithMaxWidth:TK_C_slideWidth * TKScreenScale];
    // main center controller
    UIViewController * centerViewController = [[TKMainNavigateController alloc] init];
    BaseNavViewController *nav = [[BaseNavViewController alloc]initWithRootViewController:centerViewController];
    nav.navigationBar.translucent = NO;
    _drawerController = [[MMDrawerController alloc] initWithCenterViewController:nav leftDrawerViewController:leftVC];
    leftVC.mm_drawerController.maximumLeftDrawerWidth = (TK_C_slideWidth - 1) * TKScreenScale;
    [self.drawerController
     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
         MMDrawerControllerDrawerVisualStateBlock block;
         block = [MMDrawerVisualState parallaxVisualStateBlockWithParallaxFactor:5.0];// 选择一种 滑动效果。
         if(block){
             block(drawerController, drawerSide, percentVisible);
             
         }else{
             DDLogInfo(@"slideMenu Block is nil , you may get a error ");
         }
     }];
    
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.drawerController setMaximumLeftDrawerWidth:TK_C_slideWidth * TKScreenScale];
    [self.drawerController setAnimationVelocity:1100];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
     self.drawerController.showsShadow = YES;
    self.drawerController.shouldStretchDrawer = NO;
    [self.window setRootViewController:self.drawerController];
    [self configNavigationBar];
    
}

/**
 *  <#Description#>: 显示主流导航试图
 */
-(void)showNavigateView{
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [TKMainNavigateController showNavigateControllerInWindow:self.window];
    
}




- (void)goLoginViewController{
}
- (void)goGuideViewController{
}

- (void)goMainViewController{}

- (void)pushHabitDetailFromNotication:(UILocalNotification *)notification{
}
- (void)goModuleDetail:(NSInteger)moduleId{
}



/**
 
 设置全局的导航样式
 
 **/
- (void)configNavigationBar
{
    UIColor * navColor = [UIColor TKcolorWithHexString:TK_Color_nav_background];
    [[UINavigationBar appearance] setBackgroundColor:navColor];
    [[UINavigationBar appearance] setBarTintColor:navColor];
    [[UINavigationBar appearance] setTintColor:[UIColor TKcolorWithHexString:TK_Color_nav_textActive]];
    [[UINavigationBar appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor TKcolorWithHexString:TK_Color_nav_textDefault], NSForegroundColorAttributeName, nil]];
    
//    [[UINavigationBar appearance] setBackgroundColor:[UIColor TKcolorWithHexString:TK_Color_nav_background]];
//    [[UINavigationBar appearance]setBackgroundImage:[UIImage imageNamed:@"bg_color"] forBarMetrics:UIBarMetricsDefault];
    
    if ([UINavigationBar instancesRespondToSelector:@selector(setShadowImage:)])
    {
        [[UINavigationBar appearance] setShadowImage:[[UIImage alloc]init]];
    }
}


@end
