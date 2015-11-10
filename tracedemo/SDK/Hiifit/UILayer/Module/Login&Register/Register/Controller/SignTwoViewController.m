//
//  SignTwoViewController.m
//  GuanHealth
//
//  Created by hermit on 15/2/27.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "SignTwoViewController.h"
#import "SignThreeViewController.h"
#import "SetPasswordViewController.h"
#import "SetInfoViewController.h"
#import "DataRes.h"
const NSInteger vercodeLenth = 4;

@interface SignTwoViewController ()
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *password;
@end

@implementation SignTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _phone = [self.param valueForKey:kParamPhoneNumber];
    _password = [self.param valueForKey:kParamPassword];
    if (_phone) {
        self.mobileLabel.text = [NSString stringWithFormat:@"+86 %@",_phone];
    }
#if 0
    NSString *vercode = [self.param valueForKey:kParamVerCode];
    if (vercode) {
        self.vercodeTextField.text = vercode;
    }
#endif
    if (_password.length > 0) {
        [self addNavigationTitle:@"用户注册"];
    }else{
        [self addNavigationTitle:@"找回密码"];
    }
    
    UIImage *image = [[UIImage imageNamed:@"bg_login"]resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [self.resendBtn setBackgroundImage:image forState:UIControlStateNormal];
    [self.nextBtn setBackgroundImage:image forState:UIControlStateNormal];

    [self.resendBtn setTitleColor:[UIColor HFColorStyle_6] forState:UIControlStateNormal];
#if 1
    [self.nextBtn setTitleColor:[UIColor HFColorStyle_6] forState:UIControlStateNormal];
    self.nextBtn.userInteractionEnabled = NO;
    [self.vercodeTextField becomeFirstResponder];
#endif
    
    self.resendBtn.userInteractionEnabled = NO;
    self.seconds = 60;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidesKeyBoard:)];
    [self.view addGestureRecognizer:tap];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(cutdown:) userInfo:nil repeats:YES];
    [self.timer fire];
    self.mobileLabel.textColor = [UIColor HFColorStyle_5];
}

- (void)dealloc
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)hidesKeyBoard:(UITapGestureRecognizer*)tap
{
    if (self.vercodeTextField.editing) {
        [self.vercodeTextField endEditing:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)cutdown:(NSTimer*)time
{
    self.secondsLabel.text = [NSString stringWithFormat:@"%@秒",@(self.seconds--)];
    if (self.seconds < 0) {
        [self.timer invalidate];
        self.resendBtn.userInteractionEnabled = YES;
        [self.resendBtn setTitleColor:[UIColor HFColorStyle_1] forState:UIControlStateNormal];
        self.secondsLabel.hidden = YES;
    }else{
        self.resendBtn.userInteractionEnabled = NO;
        self.secondsLabel.hidden = NO;
        [self.resendBtn setTitleColor:[UIColor HFColorStyle_6] forState:UIControlStateNormal];
    }
}

- (void)checkNumber
{
    if (self.vercodeTextField.text.length != vercodeLenth) {
        self.nextBtn.userInteractionEnabled = NO;
        [self.nextBtn setTitleColor:[UIColor HFColorStyle_6] forState:UIControlStateNormal];
    }else{
        self.nextBtn.userInteractionEnabled = YES;
        [self.nextBtn setTitleColor:[UIColor HFColorStyle_1] forState:UIControlStateNormal];
    }
}

- (IBAction)resendAction:(id)sender
{
    
    WS(weakSelf)
    if (_password) {
        [[[HIIProxy shareProxy]userProxy]PreRegisterWihtMobile:_phone success:^(BOOL finished) {
            if (finished) {
                weakSelf.seconds = 60;
                weakSelf.resendBtn.userInteractionEnabled = NO;
                [weakSelf.vercodeTextField becomeFirstResponder];
                if (weakSelf.timer == nil) {
                    weakSelf.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:weakSelf selector:@selector(cutdown:) userInfo:nil repeats:YES];
                }
                [weakSelf.timer fire];
            }
        }];
        
    }else{
        [[[HIIProxy shareProxy]userProxy]sentVercodeWithMobile:_phone success:^(BOOL finished) {
            if (finished) {
                weakSelf.seconds = 60;
                weakSelf.resendBtn.userInteractionEnabled = NO;
                [weakSelf.vercodeTextField becomeFirstResponder];
                if (weakSelf.timer == nil) {
                    weakSelf.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:weakSelf selector:@selector(cutdown:) userInfo:nil repeats:YES];
                }
                [weakSelf.timer fire];
            }
        }];
    }
}

- (IBAction)nextAction:(id)sender
{
    if (_vercodeTextField.text.length != vercodeLenth) {
        return;
    }
    HICheckVercodeType type = HICheckVercodeTypeRegister;
    if (_password.length == 0) {
        type = HICheckVercodeTypeForgetPassword;
    }
    WS(weakSelf);
    
    HFCheckVercodeReq *req = [[HFCheckVercodeReq alloc]init];
    req.phoneNumber = _phone;
    req.code = self.vercodeTextField.text;
    req.codeType = type;
    [[[HIIProxy shareProxy]userProxy]checkVercode:req success:^(BOOL finished) {
        if (finished) {
            if (type == HICheckVercodeTypeForgetPassword) {
                [weakSelf goSetPassword];
            }else{
                [weakSelf registerAction];
            }
        }
    }];
}

- (void)goSetPassword
{
    SetPasswordViewController *vc = [[SetPasswordViewController alloc]init];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:_phone forKey:kParamPhoneNumber];
    vc.param = dic;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)registerAction
{
    WS(weakSelf)
    [[[HIIProxy shareProxy]userProxy]registerWithMobile:_phone andPassword:_password success:^(BOOL finished) {
        if (finished) {
            [weakSelf goSetInfo];
        }
    }];
}

- (void)goSetInfo
{
    SetInfoViewController *vc = [[SetInfoViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    [self performSelector:@selector(checkNumber) withObject:nil afterDelay:0.2f];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.line.backgroundColor = [UIColor HFColorStyle_5];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.line.backgroundColor = [UIColor HFColorStyle_6];
}

@end
