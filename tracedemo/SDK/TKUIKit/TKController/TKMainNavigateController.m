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
#import "TKUserCenterViewController.h"
#import "HFMessageViewController.h"
#import "TKUserCenter.h"
#import "TKLoginViewController.h"
#import "TKRegisterViewController.h"
#import "SentPostViewController.h"
#import "TKPublishShowGoodsVC.h"
#import "TestViewController.h"
#import "GlobNotifyDefine.h"
#import "TKIMessageCenterViewController.h"
#import "BHomePageViewController.h"
#import "CHomePageViewController.h"
#import "BMyShowGoodsViewController.h"
#import "CPublishRewardViewController.h"
#import "TKWebViewController.h"


/**
 for  B client  only
 **/
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
//    [[UINavigationBar appearance] setBarTintColor:[UIColor TKcolorWithHexString:TK_Main_Nav_bg]];
    // 添加控制器
    // 首页
    
#if B_Client == 1
    [self initBClientView];
    
#else
    [self initCClientView];
#endif
    
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
        self.selectedIndex = 4;
        temploginEvent = TK_Default;
    }
    else if(temploginEvent == TK_GoToPublishReward)
    {
        [self showPublishRewardView];
        temploginEvent = TK_Default;
    }else if(temploginEvent == TK_GoToOrderWebView)
    {
        self.selectedIndex = 3;
        temploginEvent = TK_Default;
    }
    
}

-(void)dealloc
{

    [[NSNotificationCenter defaultCenter]removeObserver:self];
}



#pragma mark   BClient
-(void)initBClientView
{
    
    
    BHomePageViewController * subTabVC1  = [[BHomePageViewController alloc] init];
    subTabVC1.tabBarItem.image=[IMG(@"icon_tab_reward") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    subTabVC1.tabBarItem.selectedImage = [IMG(@"icon_tab_reward_active") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    subTabVC1.tabBarItem.title=@"悬赏池";
    //    subTabVC1.eventDelegate = self;
    
    //    HFNewMainViewController * newMain = [[HFNewMainViewController alloc] init];
    //    newMain.tabBarItem.title=@"搜索";
    //    newMain.tabBarItem.image=IMG(@"My_foodSearch");
    //    newMain.tabBarItem.selectedImage = IMG(@"My_foodSearch");
    
    
    
    
    TKIMessageCenterViewController * messages = [[TKIMessageCenterViewController alloc]init];
    messages.navTitle = @"消息中心";
    messages.hidDefaultBackBtn = YES;
    messages.tabBarItem.title = @"消息";
    messages.tabBarItem.image = [IMG(@"icon_tab_message") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    messages.tabBarItem.selectedImage = [IMG(@"icon_tab_message_active") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    BMyShowGoodsViewController * newChat = [[BMyShowGoodsViewController alloc] init];
    newChat.tabBarItem.title = @"我要晒单";
    newChat.tabBarItem.image = [IMG(@"icon_tab_publish") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    newChat.tabBarItem.selectedImage = [IMG(@"icon_tab_publish_active") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //    TKSubTabBarViewController * subTabVC5  = [[TKSubTabBarViewController alloc] init];
    
    
    TKWebViewController * navc4 = [[TKWebViewController alloc] init];
    navc4.title = @"我的订单";
    navc4.tabBarItem.image = [[UIImage imageNamed:@"icon_tab_myorder"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navc4.tabBarItem.selectedImage = [IMG(@"icon_tab_myorder_active") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navc4.navTitle = @"我的订单";
     navc4.hidDefaultBackBtn = YES;
    navc4.defaultURL = [[TKProxy proxy].tkBaseUrl  stringByAppendingString:BMyOrders];
    
    
    TKUserCenterViewController * navc5 = [[TKUserCenterViewController alloc] init];
    navc5.title = @"我的";
    navc5.tabBarItem.image = [[UIImage imageNamed:@"icon_tab_my"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navc5.tabBarItem.selectedImage = [IMG(@"icon_tab_my_active") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.selectedIndex =0;
    self.viewControllers = @[subTabVC1,/*newMain,*/messages,newChat,navc4,navc5];
    
//    [self addChildViewController:navc5];
    self.delegate = self;
    
//    [self.tabBar setBackgroundColor:[UIColor clearColor]];
    
    [self.tabBar setTintColor:[UIColor tkThemeColor1]];
    
    [self loadEmojIcon];
    [self registerNotification];
    
    
}



#pragma mark   CClient


-(void)initCClientView
{
    
    CHomePageViewController * subTabVC1  = [[CHomePageViewController alloc] init];
    subTabVC1.tabBarItem.image=IMG(@"icon_tab_chome");
    subTabVC1.tabBarItem.selectedImage = [IMG(@"icon_tab_chome_active") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    subTabVC1.tabBarItem.title=@"首页";
    //    subTabVC1.eventDelegate = self;
    
    //    HFNewMainViewController * newMain = [[HFNewMainViewController alloc] init];
    //    newMain.tabBarItem.title=@"搜索";
    //    newMain.tabBarItem.image=IMG(@"My_foodSearch");
    //    newMain.tabBarItem.selectedImage = IMG(@"My_foodSearch");
    
    
    
    
    TKIMessageCenterViewController * messages = [[TKIMessageCenterViewController alloc]init];
    messages.navTitle = @"消息";
    messages.hidDefaultBackBtn = YES;
    messages.tabBarItem.title = @"消息";
    messages.tabBarItem.image = IMG(@"icon_tab_message");
    messages.tabBarItem.selectedImage = [IMG(@"icon_tab_message_active") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    CPublishRewardViewController * newChat = [[CPublishRewardViewController alloc] init];
    newChat.tabBarItem.title = @"发悬赏";
    newChat.tabBarItem.image = IMG(@"icon_tab_publish");
    newChat.tabBarItem.selectedImage = [IMG(@"icon_tab_publish_active") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //    TKSubTabBarViewController * subTabVC5  = [[TKSubTabBarViewController alloc] init];
    
    
    TKWebViewController * navc4 = [[TKWebViewController alloc] init];
    navc4.title = @"我的购买";
    navc4.navTitle = @"我的购买";
    navc4.hidDefaultBackBtn = YES;
    navc4.defaultURL = [[TKProxy proxy].tkBaseUrl  stringByAppendingString:CMyGoodsURL];
    navc4.tabBarItem.image = [UIImage imageNamed:@"icon_tab_mygoods"];
    navc4.tabBarItem.selectedImage = [IMG(@"icon_tab_mygoods_active_active") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    TKUserCenterViewController * navc5 = [[TKUserCenterViewController alloc] init];
    navc5.title = @"我的";
    navc5.tabBarItem.image = [UIImage imageNamed:@"icon_tab_my"];
    navc5.tabBarItem.selectedImage = [IMG(@"icon_tab_my_active") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.selectedIndex =0;
    self.viewControllers = @[subTabVC1,/*newMain,*/messages,newChat,navc4,navc5];
    
//    [self addChildViewController:navc5];
    self.delegate = self;
    
    [self.tabBar setBackgroundColor:[UIColor tkThemeColor2]];
    
    [self.tabBar setTintColor:[UIColor tkThemeColor1]];
    
    [self loadEmojIcon];
    [self registerNotification];
    
    
}

-(void)showPublishRewardView
{
    CPublishRewardViewController * vc = [[CPublishRewardViewController alloc] init];
    
    UINavigationController * nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    
    
    [[AppDelegate getMainNavigation] presentViewController:nvc animated:YES completion:^{
        
    }];
}




#pragma mark  B&C

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController NS_AVAILABLE_IOS(3_0)
{
    if([viewController isKindOfClass:[TKUserCenterViewController class]] && ![[TKUserCenter instance] isLogin])
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
    else if([viewController isKindOfClass:[CPublishRewardViewController class]])
    {
        if(![[TKUserCenter instance] isLogin])
        {
            temploginEvent = TK_GoToPublishReward;
            [self showLoginView];
            return NO;
        }
        [self showPublishRewardView];
        return NO;
    }
    else if([viewController isKindOfClass:[TKWebViewController class]])
    {
        if(![[TKUserCenter instance] isLogin])
        {
            temploginEvent = TK_GoToOrderWebView;
            [self showLoginView];
            return NO;
        }
        return YES;
    }
    else if([viewController isKindOfClass:[BMyShowGoodsViewController class]])
    {
        if(![[TKUserCenter instance] isLogin])
        {
            temploginEvent = TK_GoToMyShowGoodsView;
            [self showLoginView];
            return NO;
        }
        return  YES;
    }
    else
    {
        return YES;
    }
    
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    //    DDLogInfo(@" shouldSelectViewController %@ ",viewController);
}


@end
