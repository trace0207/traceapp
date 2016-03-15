//
//  TKLoginViewController.m
//  tracedemo
//
//  Created by cmcc on 15/11/11.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKLoginViewController.h"
#import "TKRegisterViewController.h"
#import "UIViewController+TKNavigationBarSetting.h"
#import "UIColor+TK_Color.h"
#import "TKProxy.h"
#import "TKUserCenter.h"
#import "TK_LoginAck.h"
#import "HFHUDView.h"
#import "GlobNotifyDefine.h"

@interface TKLoginViewController ()<TKClearViewDelegate>
{

    
}

@end

@implementation TKLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navTitle = @"登录";
    _clearInputView.clearDelegate = self;
    
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onLoginSuccess) name:TKUserLoginSuccess object:nil];
    
    _userNameText.text = @"18867102687";
    _passwordText.text = @"123456";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self TKsetRightBarItemText:@"注册"
                  withTextColor:[UIColor TKcolorWithHexString:TK_Color_nav_textDefault]
                      addTarget:self action:@selector(registerBtn:) forControlEvents:UIControlEventTouchUpInside];

}

-(void)TKI_leftBarAction{
    CATransition* transition = [CATransition animation];
    transition.type = kCATransitionPush;//可更改为其他方式
    transition.subtype = kCATransitionFromBottom;//可更改为其他方式 [self.navigationController.view.layeraddAnimation:transition forKey:kCATransition];
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController popViewControllerAnimated:NO];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TKUserLoginSuccess object:nil];
}


- (void)registerBtn:(id)sender {
    TKRegisterViewController * regVC = [[TKRegisterViewController alloc]initWithNibName:@"TKRegisterViewController" bundle:nil];
    regVC.navTitle = @"注册";
    [self.navigationController pushViewController:regVC animated:YES];
    
}
- (IBAction)loginBtn:(id)sender {
    
    [[TKUserCenter instance] doLogin:_userNameText.text password:_passwordText.text];
}

-(void)onLoginSuccess
{
    [self TKI_leftBarAction];
    [[NSNotificationCenter defaultCenter] postNotificationName:TKUserLoginBackEvent object:nil];
}

- (IBAction)forgetPassword:(id)sender {
    
    TKRegisterViewController * regVC = [[TKRegisterViewController alloc]initWithNibName:@"TKRegisterViewController" bundle:nil];
    regVC.navTitle = @"忘记密码";
    regVC.isForgetPassword = YES;
    [self.navigationController pushViewController:regVC animated:YES];
}


-(void)onClearViewEvent
{

    [_userNameText resignFirstResponder];
    [_passwordText resignFirstResponder];
}

@end
