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
#import "HFMessageViewController.h"
#import "TKUserCenter.h"
#import "TKLoginViewController.h"
#import "TKRegisterViewController.h"
#import "SentPostViewController.h"
#import "TKPublishShowGoodsVC.h"
#import "TestViewController.h"
#import "GlobNotifyDefine.h"



@interface TKMainNavigateController()<HomePageEventProtocol,UITabBarControllerDelegate,LoginDelegate>
{

    TK_LoginEvent temploginEvent;
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
//    [[UINavigationBar appearance] setBarTintColor:[UIColor TKcolorWithHexString:TK_Color_BLUE]];
    // 添加控制器
    // 首页
    TKHomePageViewController * subTabVC1  = [[TKHomePageViewController alloc] init];
    subTabVC1.tabBarItem.image=IMG(@"new_mainPageUnselected");
    subTabVC1.tabBarItem.selectedImage = IMG(@"new_mainPageSelected");
    subTabVC1.tabBarItem.title=@"首页";
    subTabVC1.eventDelegate = self;
    
//    HFNewMainViewController * newMain = [[HFNewMainViewController alloc] init];
//    newMain.tabBarItem.title=@"搜索";
//    newMain.tabBarItem.image=IMG(@"My_foodSearch");
//    newMain.tabBarItem.selectedImage = IMG(@"My_foodSearch");
    
    TKPublishShowGoodsVC * newChat = [[TKPublishShowGoodsVC alloc] init];
    newChat.tabBarItem.title = @"晒单";
    newChat.tabBarItem.image = IMG(@"new_hiMomentUnselected");
    newChat.tabBarItem.selectedImage = IMG(@"new_hiMomentSelected");
    
    
    HFMessageViewController * newUser = [[HFMessageViewController alloc]init];
    newUser.tabBarItem.title = @"消息";
    newUser.tabBarItem.image = IMG(@"new_myUnselected");
    newUser.tabBarItem.selectedImage = IMG(@"new_mySelected");
    
//    TKSubTabBarViewController * subTabVC5  = [[TKSubTabBarViewController alloc] init];
    UserInfoViewController * navc5 = [[UserInfoViewController alloc] init];
    navc5.title = @"我";
    navc5.tabBarItem.image = [UIImage imageNamed:@"tk_icon_user_3_b"];
    
    self.selectedIndex =0;
    self.viewControllers = @[subTabVC1,/*newMain,*/newChat,newUser,navc5];
    
    [self addChildViewController:navc5];
    self.delegate = self;
    
    [self.tabBar setBackgroundColor:[UIColor TKcolorWithHexString:TK_Color_nav_background]];
    
    [self.tabBar setTintColor:[UIColor TKcolorWithHexString:TK_Color_nav_textActive]];
    
    [self loadEmojIcon];
    [self registerNotification];
    
}



#pragma mark - setting  Button Handlers

/**
 设置 导航左边按钮
 **/
-(void)setupLeftMenuButton:(UIViewController *)nv{
    
    [nv TKsetLeftBarItemImage:[UIImage imageNamed:@"tk_icon_camera_b"]
                    addTarget:self
                       action:@selector(rightNavigationBarIconPress:)
             forControlEvents:UIControlEventTouchUpInside];
    
}
/**
 设置 导航右边按钮  相机
 **/
-(void)setupNavigationRightButton:(UIViewController * )nv{
    [nv TKsetRightBarItemImage:[UIImage imageNamed:@"tk_icon_camera_b"]
                     addTarget:self
                        action:@selector(rightNavigationBarIconPress:)
              forControlEvents:UIControlEventTouchUpInside];
    
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


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController NS_AVAILABLE_IOS(3_0)
{
    if([viewController isKindOfClass:[UserInfoViewController class]] && ![[TKUserCenter instance] isLogin])
    {
        [self showLoginView];
        temploginEvent = TK_GoToUserCenter;
        return NO;
    }
    else if([viewController isKindOfClass:[TKPublishShowGoodsVC class]])
    {
    
        [self showGoodsPage];
        return NO;
    }
    else if([viewController isKindOfClass:[HFNewMainViewController class]])
    {

        [self showSearchVC];
        return NO;
    }
    else
    {
        return YES;
    }

}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    DDLogInfo(@" shouldSelectViewController %@ ",viewController);
}


/**
  弹出登录页
 **/
-(void)showLoginView{
    
    TKLoginViewController * loginVC = [[TKLoginViewController alloc] initWithNibName:@"TKLoginViewController" bundle:nil];
    loginVC.delegate = self;
//    [self.navigationController presentViewController:loginVC animated:YES completion:nil];
    
    CATransition* transition = [CATransition animation];
    
    transition.type = kCATransitionPush;//可更改为其他方式
    transition.subtype = kCATransitionFromTop;//可更改为其他方式 [self.navigationController.view.layeraddAnimation:transition forKey:kCATransition];
    
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:loginVC animated:NO];
}


-(void)showGoodsPage
{
    
    TKPublishShowGoodsVC * vc = [[TKPublishShowGoodsVC alloc] initWithNibName:@"TKPublishShowGoodsVC" bundle:nil];
//    CATransition* transition = [CATransition animation];
//
//    transition.type = kCATransitionPush;//可更改为其他方式
//    transition.subtype = kCATransitionFromTop;//可更改为其他方式 [self.navigationController.view.layeraddAnimation:transition forKey:kCATransition];
//
//    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)showSearchVC
{
    
    TestViewController * vc = [[TestViewController alloc]initWithNibName:@"TestViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark ------- loginDelegate

-(void)onRegisterClick{
    TKRegisterViewController * regVC = [[TKRegisterViewController alloc]initWithNibName:@"TKRegisterViewController" bundle:nil];
    [self.navigationController pushViewController:regVC animated:YES];
//    [self.navigationController presentViewController:regVC animated:YES completion:nil];
    
}
-(void)onLoginSuccess{
}
-(void)onForgetPassword{
}

#pragma mark  private Method

-(void)loadEmojIcon
{
    
    dispatch_queue_t queue = dispatch_queue_create("loadEmojIcon", nil);
    
    dispatch_async(queue, ^{
//        DDLogInfo(@"loading emoj begin at %@",[NSDate date]);
        for(NSInteger i=0;i<100;i++)
        {
            NSString *imageStr = [NSString stringWithFormat:@"emoji_%ld.png",i];
            [UIImage imageNamed:imageStr];
        }
        
//        DDLogInfo(@"loading emoj begin at %@",[NSDate date]);

    });
    
   
}


-(void)registerNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doLoginBack) name:TKUserLoginBackEvent object:nil];
}

-(void)doLoginBack
{
    if(temploginEvent == TK_GoToUserCenter)
    {
        self.selectedIndex = 3;
        temploginEvent = TK_Default;
    }
    
}

-(void)dealloc
{

    [[NSNotificationCenter defaultCenter]removeObserver:self forKeyPath:TKUserLoginBackEvent];
}




@end
