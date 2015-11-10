//
//  LoginViewController.m
//  GuanHealth
//
//  Created by hermit on 15/2/27.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "LoginViewController.h"
#import "SignOneViewController.h"
#import "DataRes.h"
#import "ForgetViewController.h"
#import "SetHeadViewController.h"
#import "HFThirdPartyCenter.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![[HFThirdPartyCenter shareInstance] QQInstall])
    {
        self.qqLoginBtn.hidden = YES;
    }
    
    if (![[HFThirdPartyCenter shareInstance] WXInstall])
    {
        self.wxLoginBtn.hidden = YES;
    }
    
    [self setViewStyle];
    self.view.backgroundColor = [UIColor HFColorStyle_5];
    HIUserType type = (HIUserType)[[GlobInfo shareInstance] userType];
    if (type == HIUserTypeMobile) {
        if ([GlobInfo shareInstance].account.length>0 && [GlobInfo shareInstance].password.length>0) {
            self.mobileTextField.text = [GlobInfo shareInstance].account;
            self.passwordTextField.text = [GlobInfo shareInstance].password;
        }
    }
    UIImage *image = [[UIImage imageNamed:@"bg_login"]resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [self.loginBtn setBackgroundImage:image forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor HFColorStyle_5] forState:UIControlStateNormal];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidesKeyBoard:)];
    [self.view addGestureRecognizer:tap];
    
    if (IS_SCREEN_35_INCH) {
        self.line1.hidden = YES;
        self.line2.hidden = YES;
        self.quickLabel.hidden = YES;
    }
}

// 设置 View 的 样式
- (void)setViewStyle{

    [self.mobileTextField setTintColor:[UIColor whiteColor]];
    [self.passwordTextField setTintColor:[UIColor whiteColor]];
    
    UIColor *borderColor = [UIColor HFColorStyle_6];
    [self.loginBoderView.layer setBorderColor:borderColor.CGColor];
    [self.loginBoderView.layer setBorderWidth:1];
    [self.loginBoderView.layer setCornerRadius:3];
    
    [self.loginBtn.layer setCornerRadius:3];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)hidesKeyBoard:(UITapGestureRecognizer*)tap
{
    if (self.mobileTextField.editing) {
        [self.mobileTextField endEditing:YES];
    }
    if (self.passwordTextField.editing) {
        [self.passwordTextField endEditing:YES];
    }
}

- (BOOL)checkNumber
{
    if (self.mobileTextField.text.length == 11 && self.passwordTextField.text.length>=6 && self.passwordTextField.text.length<=20) {
        return YES;
    }
    NSString *message = nil;
    NSInteger flag = 0;
    if (self.mobileTextField.text.length == 0) {
        message = _T(@"HF_Common_Phone_Null");
    }
    else if (self.mobileTextField.text.length!=11){
        message = _T(@"HF_Common_Input_Right_Phone");
    }
    else if (self.passwordTextField.text.length == 0){
        message = _T(@"HF_Common_Password_Null");
        flag = 1;
    }
    else if (self.passwordTextField.text.length<6 || self.passwordTextField.text.length>20){
        message = _T(@"HF_Common_Password_Error");
        flag = 1;
    }
    WS(weakSelf)
    HFAlertView *alter = [HFAlertView initWithTitle:_T(@"HF_Common_Tips") withMessage:message commpleteBlock:^(NSInteger buttonIndex) {
        if (flag == 0) {
            [weakSelf.mobileTextField becomeFirstResponder];
        }else{
            [weakSelf.passwordTextField becomeFirstResponder];
        }
    } cancelTitle:nil determineTitle:_T(@"HF_Common_OK")];
    [alter show];
    
    return NO;
}

- (IBAction)loginAction:(id)sender
{
    [self hidesKeyBoard:nil];
    if ([self checkNumber])
    {
        [self loginWithAccount:self.mobileTextField.text password:self.passwordTextField.text nickname:nil photo:nil sex:-1 userType:HIUserTypeMobile];
    }
}

- (void)loginWithAccount:(NSString *)account
                password:(NSString *)password
                nickname:(NSString *)nickname
                   photo:(NSString *)photo
                     sex:(NSInteger)sex
                userType:(NSInteger)userType
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HFUserInfoModel * model = [[HFUserInfoModel alloc] init];
    model.account = account;
    model.password = password;
    model.nickname = nickname;
    model.photo = photo;
    model.sex = sex;
    model.userType = userType;
    [[[HIIProxy shareProxy] userProxy] loginWithModel:model complete:^(BOOL finish) {
        if (finish)
        {
            [[UIKitTool getAppdelegate] goMainViewController];
        }
        [hud removeFromSuperview];
    }];
}

- (IBAction)registerAction:(id)sender {
    SignOneViewController *regVC = [[SignOneViewController alloc]initWithNibName:@"SignOneViewController" bundle:nil];
    [self.navigationController pushViewController:regVC animated:YES];
}

- (IBAction)forgetAction:(id)sender
{
    ForgetViewController *vc = [[ForgetViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)thirdpatyLoginAction:(UIButton*)sender
{
    ShareType type = ShareTypeSinaWeibo;
    switch (sender.tag) {
        case 1:
            type = ShareTypeQQSpace;
            break;
            
        case 3:
            type = ShareTypeSinaWeibo;
            break;
            
        case 2:
            type = ShareTypeWeixiTimeline;
            break;
            
        default:
            break;
    }
    
    [[[HIIProxy shareProxy] userProxy] thirdPartLoginWithType:type complete:^(BOOL finish) {
        if (finish)
        {
            [[UIKitTool getAppdelegate] goMainViewController];
        }
    }];
}

#pragma text field delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.mobileTextField.isEditing) {
        if (textField.text.length==0) {
            if (![string isEqualToString:@"1"]) {
                return NO;
            }
        }else if(self.mobileTextField.text.length>=11 && string.length>0){
            return NO;
        }
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (IS_SCREEN_35_INCH) {
        [UIView animateWithDuration:0.2f animations:^{
            self.view.center = CGPointMake(self.view.center.x, self.view.center.y-60);
        }];
    }
//    if (textField == self.mobileTextField) {
//        self.line1.backgroundColor = [UIColor hexChangeFloat:@"ffffff" withAlpha:1.0f];
//        self.line2.backgroundColor = [UIColor hexChangeFloat:@"ffffff" withAlpha:0.54f];
//    }else if (textField == self.passwordTextField){
//        self.line1.backgroundColor = [UIColor hexChangeFloat:@"ffffff" withAlpha:0.54f];
//        self.line2.backgroundColor = [UIColor hexChangeFloat:@"ffffff" withAlpha:1.0f];
//    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (IS_SCREEN_35_INCH) {
        [UIView animateWithDuration:0.2f animations:^{
            self.view.center = CGPointMake(self.view.center.x, self.view.center.y+60);
        }];
    }
//    self.line1.backgroundColor = [UIColor hexChangeFloat:@"ffffff" withAlpha:0.54f];
//    self.line2.backgroundColor = [UIColor hexChangeFloat:@"ffffff" withAlpha:0.54f];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //[textField resignFirstResponder];
    [textField endEditing:YES];
    return YES;
}



@end
