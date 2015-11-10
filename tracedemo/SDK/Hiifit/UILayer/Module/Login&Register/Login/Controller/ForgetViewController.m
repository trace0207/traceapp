//
//  ForgetViewController.m
//  GuanHealth
//
//  Created by hermit on 15/2/27.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ForgetViewController.h"
#import "SignTwoViewController.h"

@interface ForgetViewController ()<UITextFieldDelegate>

@end

@implementation ForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationTitle:_T(@"HF_Common_Find_Password")];
    UIImage *image = [[UIImage imageNamed:@"bg_login"]resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [self.nextBtn setTitleColor:[UIColor HFColorStyle_6] forState:UIControlStateDisabled];
    [self.nextBtn setTitleColor:[UIColor HFColorStyle_1] forState:UIControlStateNormal];
    [self.nextBtn setBackgroundImage:image forState:UIControlStateNormal];
    self.nextBtn.enabled = NO;
    [self.phoneTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)nextAction:(UIButton*)btn
{
    WS(weakSelf);
    [[[HIIProxy shareProxy]userProxy]sentVercodeWithMobile:self.phoneTextField.text success:^(BOOL finished) {
        if (finished) {
            [weakSelf goSignTwoVC];
        }
    }];
}

- (void)goSignTwoVC
{
    SignTwoViewController *vc = [[SignTwoViewController alloc]initWithNibName:@"SignTwoViewController" bundle:nil];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setValue:self.phoneTextField.text forKey:kParamPhoneNumber];
    
    vc.param = dic;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length == 11 && string.length>0) {
        self.nextBtn.enabled = YES;
        self.lineView.backgroundColor = [UIColor HFColorStyle_5];
        return NO;
    }
    
    if (textField.text.length == 10 && string.length>0) {
        self.lineView.backgroundColor = [UIColor HFColorStyle_5];
        self.nextBtn.enabled = YES;
    }else{
        self.lineView.backgroundColor = [UIColor HFColorStyle_7];
        self.nextBtn.enabled = NO;
    }
    
    
    return YES;
}

@end
