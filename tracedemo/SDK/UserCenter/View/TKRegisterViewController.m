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

@interface TKRegisterViewController ()<TKClearViewDelegate>
@property (strong, nonatomic) IBOutlet TKClearView *clearInputText;

@end

@implementation TKRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _clearInputText.clearDelegate = self;
    if(self.isForgetPassword)
    {
        self.bottomBtn.hidden = YES;
        self.bottomLabel.hidden = YES;
    }
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
    
    if(!phone || phone.length !=11)
    {
        [[HFHUDView shareInstance] ShowTips:@"请输入正确的手机号码" delayTime:1.0 atView:NULL];
        return;
    }
    
    [TKUserCenter instance].tempUserData.mobile = phone;
    TKSetPasswordViewController * passwordVC =
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
@end
