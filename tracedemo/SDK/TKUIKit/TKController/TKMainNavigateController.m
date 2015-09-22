//
//  TKMainNavigateController.m
//  tracedemo
//
//  Created by cmcc on 15/9/20.
//  Copyright (c) 2015年 trace. All rights reserved.
//

#import "TKMainNavigateController.h"
#import "TKSubTabBarViewController.h"

@implementation TKMainNavigateController

+(TKMainNavigateController *)showNavigateControllerInWindow:(UIWindow *) window{

    TKMainNavigateController * vc = [[TKMainNavigateController alloc]init];
    window.rootViewController = vc;
    [window makeKeyAndVisible];
    return vc;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    // 添加控制器
    
    TKSubTabBarViewController * subTabVC1  = [[TKSubTabBarViewController alloc] init];
    
    UINavigationController * navc1 = [[UINavigationController alloc]initWithRootViewController:subTabVC1];
    navc1.title = @"首页";
    
    
    subTabVC1.navigationItem.title = @"App主页";
    subTabVC1.navigationItem.leftBarButtonItem
    
    subTabVC1.view.backgroundColor = [UIColor greenColor];
    
    [self addChildViewController:navc1];
    
    
    TKSubTabBarViewController * subTabVC2  = [[TKSubTabBarViewController alloc] init];
    
    UINavigationController * navc2 = [[UINavigationController alloc]initWithRootViewController:subTabVC2];
    navc2.title = @"设置";
    subTabVC2.navigationItem.title = @"设置页";
    
    subTabVC2.view.backgroundColor = [UIColor cyanColor];
    
    [self addChildViewController:navc2];

    
}

@end
