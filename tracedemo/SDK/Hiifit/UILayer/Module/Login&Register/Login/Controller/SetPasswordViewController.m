//
//  SetPasswordViewController.m
//  GuanHealth
//
//  Created by hermit on 15/2/27.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "SetPasswordViewController.h"
#import "DataRes.h"
@interface SetPasswordViewController ()<UITextFieldDelegate>

@end

@implementation SetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationTitle:@"找回密码"];
    UIImage *image = [[UIImage imageNamed:@"bg_login"]resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [self.modifyBtn setTitleColor:[UIColor HFColorStyle_6] forState:UIControlStateDisabled];
    [self.modifyBtn setTitleColor:[UIColor HFColorStyle_1] forState:UIControlStateNormal];
    [self.modifyBtn setBackgroundImage:image forState:UIControlStateNormal];
    
    [self.pwdTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)modifyPassword:(id)sender
{
    NSString *phone = [self.param valueForKey:kParamPhoneNumber];
    [[[HIIProxy shareProxy]userProxy] setPassword:self.pwdTextField.text andMobile:phone success:^(BOOL finished) {
        if (finished) {
            [[UIKitTool getAppdelegate]goMainViewController];
        }
    }];
}

- (IBAction)displayPassword:(id)sender
{
    self.pwdTextField.secureTextEntry = self.eyeImage.highlighted;
    self.eyeImage.highlighted = !self.eyeImage.highlighted;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length >= 20 && string.length > 0) {
        return NO;
    }
    if (textField.text.length >= 5 && string.length > 0) {
        self.modifyBtn.enabled = YES;
    }
    
    if (textField.text.length == 6 && string.length == 0) {
        self.modifyBtn.enabled = NO;
    }
    
    
    return YES;
}

@end
