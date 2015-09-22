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
@interface AppDelegate ()

@property (nonatomic,strong) MMDrawerController * drawerController;

@end



@implementation AppDelegate


-(BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    [self showSlideMenuController];
    //    [self showNavigateView];
    return YES;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [super application:application didFinishLaunchingWithOptions:launchOptions];
    // Override point for customization after application launch.
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
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


/**
 *  Description : 显示 侧滑菜单
 */
-(void)showSlideMenuController{
    // left Menu Controller
    UIViewController * leftVC = [[TKLeftMenuController alloc] initWithMaxWidth:265 * TKScreenScale];
    
    // App Main View controller
    UIViewController * centerViewController = [[TKMainNavigateController alloc] init];
    _drawerController = [[MMDrawerController alloc] initWithCenterViewController:centerViewController leftDrawerViewController:leftVC];
    leftVC.mm_drawerController.maximumLeftDrawerWidth = 260 * TKScreenScale;
    [self.drawerController
     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
         MMDrawerControllerDrawerVisualStateBlock block;
         block = [MMDrawerVisualState slideVisualStateBlock];
         if(block){
             block(drawerController, drawerSide, percentVisible);
         }
     }];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.drawerController setRestorationIdentifier:@"MMDrawer"];
    [self.drawerController setMaximumRightDrawerWidth:200.0];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    self.drawerController.showsShadow = NO;
    
    
    [self.window setRootViewController:self.drawerController];
    
}

/**
 *  <#Description#>: 显示主流导航试图
 */
-(void)showNavigateView{
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [TKMainNavigateController showNavigateControllerInWindow:self.window];
}


@end
