//
//  TK_BaseAppDelegate.m
//  tracedemo
//
//  Created by cmcc on 15/9/12.
//  Copyright (c) 2015年 trace. All rights reserved.
//

#import "TK_BaseAppDelegate.h"
#import "MWLogFormatter.h"
#import "DDTTYLogger.h"
#import "DDFileLogger.h"

@implementation TK_BaseAppDelegate



/**
 *  <#Description#>    the application fist responder event  .
 *  该方法已经过时 ， 在 IOS 3.0 以后  改成了  didFinishLaunchingWithOptions  
 *  @param application <#application description#>
 */
-(void)applicationDidFinishLaunching:(UIApplication *)application{
    
    
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self initLog];
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




-(void)initLog{
    
    MWLogFormatter* formatter = [[MWLogFormatter alloc] init];
    [DDTTYLogger sharedInstance].logFormatter = formatter;
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    DDFileLogger* fileLogger = [[DDFileLogger alloc] init];
    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    fileLogger.logFormatter = formatter;
    
    [DDLog addLogger:fileLogger];
    DDLogInfo(@"didFinishLaunchingWithOptions  log init ok ");
}



@end
