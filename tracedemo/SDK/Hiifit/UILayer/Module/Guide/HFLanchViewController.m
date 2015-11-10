//
//  HFLanchViewController.m
//  GuanHealth
//
//  Created by 栋栋 施 on 15/9/23.
//  Copyright © 2015年 ChinaMobile. All rights reserved.
//

#import "HFLanchViewController.h"
#import "GuideViewController.h"
#import "MainViewController.h"
#import "LoginViewController.h"
@interface HFLanchViewController ()
{
    UIImageView * mImageView;   //首页加载图片
    
    BOOL checkUpdate;
}
@end

@implementation HFLanchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    mImageView = [[UIImageView alloc]initWithFrame:kScreenBounds];
    if (IS_SCREEN_35_INCH)
    {
        [mImageView setImage:IMG(@"lacunch_iphone4")];
    }
    else  if(IS_SCREEN_4_INCH){
        [mImageView setImage:IMG(@"lacunch_iphone5")];
    }
    else if (IS_SCREEN_47_INCH)
    {
        [mImageView setImage:IMG(@"launch_iphone6")];
    }
    else
    {
        [mImageView setImage:IMG(@"launch_iphone6Plus")];
    }
    [self.view addSubview:mImageView];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self checkUpdate];
    
}


-(void)checkUpdate{
    [[HIIProxy shareProxy].commProxy checkUpdate:[[HFDeviceInfo shareInstance] getAppVersion] success:^(CheckUpdateRes * res){
        
        DDLogInfo(@"\n%@",res);
        if(res.strategyType == 2){
            //强制更新
            
            NSString * message = [NSString stringWithFormat:@"最新版本:%@\n\n更新内容\n\n%@",res.version,res.tips];
            
            WCAlertView *alter = [WCAlertView showAlertWithTitle:@"发现新版本" message:message customizationBlock:^(WCAlertView *alertView) {
                
            } completionBlock:^(NSUInteger buttonIndex, WCAlertView *alertView) {
                if (buttonIndex == 0)
                {
                    exit(0);
                }
                else
                {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:res.updateUrl]];
                    exit(0);
                }
            } cancelButtonTitle:@"退出应用" otherButtonTitles:@"立即更新", nil];
            [alter show];
        }else if(res.strategyType == 1){
            //选择更新
            
            NSString * message = [NSString stringWithFormat:@"最新版本:%@\n\n更新内容\n\n%@",res.version,res.tips];
            
            WCAlertView *alter = [WCAlertView showAlertWithTitle:@"发现新版本" message:message customizationBlock:^(WCAlertView *alertView) {
                
            } completionBlock:^(NSUInteger buttonIndex, WCAlertView *alertView) {
                if (buttonIndex == 0)
                {
                    [self doAftrCheckUpdate];
                }
                else
                {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:res.updateUrl]];
                    exit(0);
                }
            } cancelButtonTitle:@"以后再说" otherButtonTitles:@"立即更新", nil];
            [alter show];
        }
        else{
            
            [self doAftrCheckUpdate];
        }
        
    }];
}

-(void)doAftrCheckUpdate{
    
    if(checkUpdate)
    {
        return;
    }
    
    checkUpdate = true;
    
    [self configNavigationBar];
    
    
    if ([[GlobInfo shareInstance]isLatestVersion])
    {
        [[GlobInfo shareInstance]setDeviceid];
        [self goGuideViewController];
        //将新的界面作为该界面的子界面
    }
    else
    {
        [self loginAction];
    }
}

- (void)loginAction
{
    if (![[GlobInfo shareInstance]hasLogined]) {
        [self goLoginViewController];
    }else {
        WS(weakSelf)
        [[[HIIProxy shareProxy] userProxy] autoLoginWithComplete:^(BOOL finish) {
            if (finish)
            {
                [mImageView removeFromSuperview];
                [weakSelf goMainViewController];
                
            }
            else
            {
                WS(weakSelf)
                HFAlertView *altertView = [HFAlertView initWithTitle:@"提示" withMessage:@"网络出错登录失败！" commpleteBlock:^(NSInteger buttonIndex) {
                    if (buttonIndex) {
                        [weakSelf goLoginViewController];
                    }else {
                        [weakSelf loginAction];
                    }
                } cancelTitle:@"重试" determineTitle:@"去登录"];
                [altertView show];
            }
            
        }];
    }
}


- (void)goMainViewController
{
    [[UIKitTool getAppdelegate] goMainViewController];
}

- (void)goLoginViewController
{
    [[UIKitTool getAppdelegate] goLoginViewController];
}

- (void)goGuideViewController
{
    [[UIKitTool getAppdelegate] goGuideViewController];
}

- (void)configNavigationBar
{
    [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];
    
//    if ([UINavigationBar instancesRespondToSelector:@selector(setBarTintColor:)]) {
//        [[UINavigationBar appearance]setBarTintColor:[UIColor HFColorStyle_5]];
//    }
    [[UINavigationBar appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil]];
    
    [[UINavigationBar appearance]setBackgroundImage:[UIImage imageNamed:@"bg_color"] forBarMetrics:UIBarMetricsDefault];

    if ([UINavigationBar instancesRespondToSelector:@selector(setShadowImage:)])
    {
        [[UINavigationBar appearance] setShadowImage:[[UIImage alloc]init]];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
