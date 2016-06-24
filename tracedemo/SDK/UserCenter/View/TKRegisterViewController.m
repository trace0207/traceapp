//
//  TKRegisterViewController.m
//  tracedemo
//
//  Created by cmcc on 15/11/11.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKRegisterViewController.h"
#import  "UIViewController+TKNavigationBarSetting.h"
#import "UIColor+TK_Color.h"
#import "TKSetPasswordViewController.h"
#import "TKUserCenter.h"
#import "TKClearView.h"
#import "HFHUDView.h"
#import "TKCountrySelectVC.h"

@interface TKRegisterViewController ()<TKClearViewDelegate,CountrySelectDelegate>

@end

@implementation TKRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(self.isForgetPassword)
    {
        self.bottomBtn.hidden = YES;
        self.bottomLabel.hidden = YES;
    }
    TKClearView * clearView = (TKClearView *)self.view;
    clearView.clearDelegate = self;
    // Do any additional setup after loading the view from its nib.
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

//-(void)cancelEvent{
//    [self.navigationController popViewControllerAnimated:YES];
//
//}


- (IBAction)countrySelectBtn:(id)sender {
}

- (IBAction)nextStepBtn:(id)sender {
    
    
    
    NSString * phone = _phoneNumberInputText.text;
    
    if(!phone || phone.length <7)
    {
        [[HFHUDView shareInstance] ShowTips:@"请输入正确的手机号码" delayTime:1.0 atView:NULL];
        return;
    }
    
    [TKUserCenter instance].tempUserData.mobile = phone; // phone;
    [TKUserCenter instance].tempUserData.countryCode = _countryCodeLabel.text;
    TKSetPasswordViewController * passwordVC =
//    [[NSBundle mainBundle] loadNibNamed:@"TKSetPasswordViewController" owner:nil options:nil].firstObject;
    [[TKSetPasswordViewController alloc] initWithNibName:@"TKSetPasswordViewController" bundle:nil];
    passwordVC.isForgetPassword = self.isForgetPassword;
    [self.navigationController pushViewController:passwordVC animated:YES];
    
}

- (IBAction)userProtocolBtn:(id)sender {
    
    TKIBaseNavWithDefaultBackVC *vc = [[TKIBaseNavWithDefaultBackVC alloc] init];
    vc.navTitle = @"软件许可及服务协议";
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)onClearViewEvent
{
    [_phoneNumberInputText resignFirstResponder];
}
- (IBAction)countryBtnAction:(id)sender {
    
    TKCountrySelectVC * vc = [[TKCountrySelectVC alloc] init];
    vc.delegate = self;
    [[AppDelegate getMainNavigation] pushViewController:vc animated:YES];
    
    
}

-(void)onCountrySelect:(NSString *)country countryCode:(NSString *)code
{
    self.countryLabel.text = country;
    self.countryCodeLabel.text = code;
}

-(NSArray *)hideKeyboardExcludeViews
{
    return @[_phoneNumberInputText];
}

@end
