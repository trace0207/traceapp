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
#import "UIColor+TK_Color.h"
#import "TKUserCenter.h"
#import "TKLoginViewController.h"
#import "Pingpp.h"
#import "GlobNotifyDefine.h"

@interface AppDelegate ()<LoginDelegate>{
    
    
}

@property (nonatomic,strong) MMDrawerController * drawerController;

@end

static BaseNavViewController * rootNavVC;
static AppDelegate * appDelegate;

@implementation AppDelegate



-(void)onLoginSuccess
{
    [self showMainViewController];
}

-(BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    return YES;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [super application:application didFinishLaunchingWithOptions:launchOptions];
    if([launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey]!= nil)
    {
        application.applicationIconBadgeNumber = 0;
    }
    appDelegate = self;
    [self initAppData];

#if B_Client == 1

    if(![[TKUserCenter instance] isLogin])
    {
        TKLoginViewController * vc = [[TKLoginViewController alloc] init];
        vc.delegate = self;
        [self.window setRootViewController:vc];
    }
#else
    [self showMainViewController];
#endif
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
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



-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    BOOL canHandleURL = [Pingpp handleOpenURL:url withCompletion:^(NSString *result, PingppError *error) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:TKPayNotify object:result];
        DDLogInfo(@"pingpp pay result = %@",result);
    } ];
    return canHandleURL;
}



#pragma mark -----Show  Controller detail -------



+(BaseNavViewController *)getMainNavigation{
    
    if(self){
        
        return rootNavVC;
    }
    return nil;
}

+(AppDelegate *)getAppDelegate
{
    return appDelegate;
}

/**
 *  Description : 显示 侧滑菜单UI
 */
-(void)showSlideMenuController{
    // left Menu Controller
    UIViewController * leftVC = [[TKLeftMenuController alloc] initWithMaxWidth:TK_C_slideWidth * TKScreenScale];
    // main center controller
    UIViewController * centerViewController = [[TKMainNavigateController alloc] init];
    BaseNavViewController *nav = [[BaseNavViewController alloc]initWithRootViewController:centerViewController];
    rootNavVC = nav;
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



-(void)showMainViewController
{
    
    UIViewController * centerViewController = [[TKMainNavigateController alloc] init];
    BaseNavViewController *nav = [[BaseNavViewController alloc]initWithRootViewController:centerViewController];
    rootNavVC = nav;
    nav.navigationBar.translucent = NO;
    
    [self.window setRootViewController:nav];
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
    UIColor * navColor = [UIColor tkThemeColor2];
    [[UINavigationBar appearance] setBackgroundImage:[UIColor TKcreateImageWithColor:navColor] forBarMetrics:UIBarMetricsDefault];
    //[[UINavigationBar appearance] setBarTintColor:navColor];
   
    [[UINavigationBar appearance] setTintColor:[UIColor tkThemeColor1]];
    [[UINavigationBar appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor TKcolorWithHexString:TK_Color_nav_textDefault], NSForegroundColorAttributeName, nil]];
    
    //    [[UINavigationBar appearance] setBackgroundColor:[UIColor TKcolorWithHexString:TK_Color_nav_background]];
    //    [[UINavigationBar appearance]setBackgroundImage:[UIImage imageNamed:@"bg_color"] forBarMetrics:UIBarMetricsDefault];
    
    if ([UINavigationBar instancesRespondToSelector:@selector(setShadowImage:)])
    {
        [[UINavigationBar appearance] setShadowImage:[[UIImage alloc]init]];
    }
    
    [[UIApplication sharedApplication]setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
}




-(void)initAppData
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self configNavigationBar];
    [[TKUserCenter instance] initAppData];
    NSString * deviceId = [GlobInfo shareInstance].deviceid;
    [kUserDefaults registerDefaults:@{@"UserAgent":deviceId}];
    DDLogInfo(@"userAgent set to %@",deviceId);
    [kUserDefaults synchronize];

   
    
    if (IOS8VERSION)
    {
        
        DDLogInfo(@"IOS 8.0  registerUserNotificationSettings  begin ");
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings
                                                                             settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
                                                                             categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        DDLogInfo(@"IOS < 8.0  registerUserNotificationSettings  begin ");
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
    

}


+(UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

#pragma  mark   UIApplicationDelegate

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(nonnull NSData *)deviceToken
{
    
    application.applicationIconBadgeNumber = 0;
    //注册，回调deviceToken
    NSString * pushToken = [[[deviceToken description]
                             stringByReplacingOccurrencesOfString:@"<" withString:@""]
                            stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    DDLogInfo(@"recevie devicetoken %@",pushToken);
    [[TKUserCenter instance].userNormalVM setToken:pushToken];
    
//    [[GlobInfo shareInstance] saveDeviceToken:pushToken];
}


#pragma mark  local notification

-(void)logouToLoginView
{
    rootNavVC = nil;
    TKLoginViewController * vc = [[TKLoginViewController alloc] init];
    vc.delegate = self;
    [self.window setRootViewController:vc];
}



#pragma mark  Notification

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    application.applicationIconBadgeNumber = 0;
}


@end
