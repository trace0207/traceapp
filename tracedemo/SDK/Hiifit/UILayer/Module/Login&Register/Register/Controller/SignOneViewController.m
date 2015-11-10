//
//  SignOneViewController.m
//  GuanHealth
//
//  Created by hermit on 15/2/27.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "SignOneViewController.h"
#import "SignTwoViewController.h"
#import "VercodeRes.h"
#import "RequestParameters.h"
#import "HFAlertView.h"
#import "AgreementViewController.h"
#import "DataRes.h"
@interface SignOneViewController ()

@end

@implementation SignOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationTitle:@"用户注册"];
    // Do any additional setup after loading the view from its nib.
    UIImage *image = [[UIImage imageNamed:@"bg_login"]resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [self.getVercode setBackgroundImage:image forState:UIControlStateNormal];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidesKeyBoard:)];
    [self.view addGestureRecognizer:tap];
    self.agreeImage.highlighted = YES;
    self.passwordTextField.clearsOnBeginEditing = NO;
    self.getVercode.userInteractionEnabled = NO;
    [self.protocalBtn setTitleColor:[UIColor HFColorStyle_5] forState:UIControlStateNormal];
    self.lineView.backgroundColor = [UIColor HFColorStyle_5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)checkNumber
{
    if (self.mobileTextField.text.length == 11 && self.passwordTextField.text.length>=6 && self.passwordTextField.text.length<=20) {
        [self.getVercode setTitleColor:[UIColor HFColorStyle_1] forState:UIControlStateNormal];
        self.getVercode.userInteractionEnabled = YES;
    }else{
        [self.getVercode setTitleColor:[UIColor HFColorStyle_6] forState:UIControlStateNormal];
        self.getVercode.userInteractionEnabled = NO;
    }

}

- (IBAction)displayPasswordAction:(id)sender
{
    self.passwordTextField.secureTextEntry = self.eyeImage.highlighted;
    self.eyeImage.highlighted = !self.eyeImage.highlighted;
}

- (IBAction)getVercodeAction:(id)sender
{
    [self hidesKeyBoard:nil];
    if (!self.agreeImage.highlighted) {
        HFAlertView *alert = [HFAlertView initWithTitle:_T(@"HF_Common_Tips") withMessage:@"用户必须服从《嗨健康服务协议》！" commpleteBlock:^(NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                self.agreeImage.highlighted = YES;
            }
        } cancelTitle:@"不同意" determineTitle:@"同意"];
        [alert show];
        return;
    }
    NSString *message = [NSString stringWithFormat:@"我们将发送验证码短信到这个号码，请注意查收:+86 %@",self.mobileTextField.text];
    WS(weakSelf)
    HFAlertView *view = [HFAlertView initWithTitle:@"确认手机号码" withMessage:message commpleteBlock:^(NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            [[[HIIProxy shareProxy]userProxy]PreRegisterWihtMobile:self.mobileTextField.text success:^(BOOL finished) {
                if (finished) {
                    [weakSelf goSignTwoView];
                }
            }];
        }
    } cancelTitle:@"取消" determineTitle:_T(@"HF_Common_OK")];
    [view show];
}

- (IBAction)agreeAction:(id)sender
{
    self.agreeImage.highlighted = !self.agreeImage.highlighted;
}

- (IBAction)seeAgreementAction:(id)sender
{
    AgreementViewController *vc = [[AgreementViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)goSignTwoView
{
    SignTwoViewController *vc = [[SignTwoViewController alloc]initWithNibName:@"SignTwoViewController" bundle:nil];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.mobileTextField.text forKey:kParamPhoneNumber];
    [dic setValue:self.passwordTextField.text forKey:kParamPassword];
    vc.param = dic;
    
    [self.navigationController pushViewController:vc animated:YES];
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
    }else if (self.passwordTextField.isEditing) {
        if(self.passwordTextField.text.length>=20 && string.length>0){
            return NO;
        }
    }
    [self performSelector:@selector(checkNumber) withObject:nil afterDelay:0.12f];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.mobileTextField) {
        self.line1.backgroundColor = [UIColor HFColorStyle_5];
        self.line2.backgroundColor = [UIColor HFColorStyle_7];
    }else if (textField == self.passwordTextField){
        self.line1.backgroundColor = [UIColor HFColorStyle_7];
        self.line2.backgroundColor = [UIColor HFColorStyle_5];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.line1.backgroundColor = [UIColor HFColorStyle_7];
    self.line2.backgroundColor = [UIColor HFColorStyle_7];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //[textField resignFirstResponder];
    [textField endEditing:YES];
    return YES;
}

@end
