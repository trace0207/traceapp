//
//  HFBindPhoneNumViewController.m
//  GuanHealth
//
//  Created by 栋栋 施 on 15/6/17.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFBindPhoneNumViewController.h"
#import "AgreementViewController.h"
@interface HFBindPhoneNumViewController ()<UITextFieldDelegate>
{
    UITextField * mCurrentTextField;
    
    MBProgressHUD * HUD;
    
    NSTimer * mTimer;
    
    NSInteger  timeSec;
    
    BOOL  bEntry;
}
@property(nonatomic,strong)UITextField * mCurrentTextField;
@end

@implementation HFBindPhoneNumViewController
@synthesize mCurrentTextField;
- (void)viewDidLoad {
    [super viewDidLoad];
    timeSec = 60;
    [self addNavigationTitle:_T(@"HF_Common_Bind_Phone")];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.mPhoneTextField becomeFirstResponder];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)checkProctolStatus:(UIButton *)sender {
    self.agreeBtn.selected = !self.agreeBtn.selected;
}

- (IBAction)viewProctolAction:(UIButton *)sender {
    AgreementViewController *vc = [[AgreementViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)entryPwdAction:(UIButton *)sender {
    bEntry = !bEntry;
    
    if (bEntry)
    {
        self.mPwdTextField.secureTextEntry = NO;
        [self.mEntryBtn setBackgroundImage:IMG(@"eye_bright") forState:UIControlStateNormal];
    }
    else
    {
        self.mPwdTextField.secureTextEntry = YES;
        [self.mEntryBtn setBackgroundImage:IMG(@"eye_dark") forState:UIControlStateNormal];
    }
}

- (IBAction)sendCodeAction:(UIButton *)sender {
    [mCurrentTextField endEditing:YES];
    if (![self checkPhoneNum])
    {
        return;
    }
    
    
    WS(weakSelf)
    NSString *message = [NSString stringWithFormat:@"我们将发送验证码短信到这个号码，请注意查收:+86 %@",self.mPhoneTextField.text];
    HFAlertView *view = [HFAlertView initWithTitle:@"确认手机号码" withMessage:message commpleteBlock:^(NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            
            [weakSelf updateSendCode];
            
            [[[HIIProxy shareProxy]userProxy]PreRegisterWihtMobile:self.mPhoneTextField.text success:^(BOOL finished) {
                if (!finished) {
                    [weakSelf stopTimeWait];
                }
            }];
        }
    } cancelTitle:@"取消" determineTitle:_T(@"HF_Common_OK")];
    [view show];
    
}

- (IBAction)bindPhoneAction:(UIButton *)sender {
    
    [mCurrentTextField resignFirstResponder];
    
    if (self.agreeBtn.selected) {
        HFAlertView *alert = [HFAlertView initWithTitle:_T(@"HF_Common_Tips") withMessage:@"用户必须服从《嗨健康服务协议》！" commpleteBlock:^(NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                self.agreeBtn.selected = NO;
            }
        } cancelTitle:@"不同意" determineTitle:@"同意"];
        [alert show];
        return;
    }
    
    if (![self checkPhoneNum])
    {
        return;
    }
    
    if (![self checkCode])
    {
        return;
    }
    
    if (![self checkPwd])
    {
        return;
    }
    
    if (!HUD)
    {
        HUD = [MBProgressHUD showHUDAddedTo:[UIKitTool getAppdelegate].window animated:YES];
    }
    
//    [[[HIIProxy shareProxy] userProxy] verifySMSCode:self.mPhoneTextField.text codeType:1 smsCode:self.mCodeTextField.text complete:^(BOOL finish) {
//        if (finish)
//        {
//            [self resetUserInfo];
//        }
//        else
//        {
//            [HUD hide:YES];
//            HUD = nil;
//        }
//    }];
    
    HFCheckVercodeReq *req = [[HFCheckVercodeReq alloc]init];
    req.phoneNumber = self.mPhoneTextField.text;
    req.code = self.mCodeTextField.text;
    req.codeType = HICheckVercodeTypeRegister;
    [[[HIIProxy shareProxy]userProxy]checkVercode:req success:^(BOOL finished) {
        if (finished) {
            [self resetUserInfo];
        }else{
            [HUD hide:YES];
            HUD = nil;
        }
    }];
}

#pragma mark -
#pragma mark private
- (void)resetUserInfo
{
    [[[HIIProxy shareProxy] userProxy] bindPhoneNum:self.mPhoneTextField.text password:self.mPwdTextField.text complete:^(BOOL finish) {
        [HUD hide:YES];
        HUD = nil;
        if (finish)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [[HFHUDView shareInstance] ShowTips:_T(@"HF_Bind_Phone_Fail") delayTime:1.0 atView:nil];
        }
    }];
}

- (void)updateSendCode
{
    if (self.mSendBtn.enabled) {
        self.mSendBtn.enabled = NO;
        self.mWaitLabel.hidden = NO;
    }
    
    NSString * title = [NSString stringWithFormat:@"%ld秒后重试",(long)timeSec];
    self.mWaitLabel.text = title;
    
    timeSec--;
    
    if (timeSec <= 0) {
        [self stopTimeWait];
        return;
    }
    
    if (!mTimer) {
        mTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateSendCode) userInfo:nil repeats:YES];
    }
}

- (void)stopTimeWait
{
    self.mWaitLabel.hidden = YES;
    self.mSendBtn.enabled = YES;
    timeSec = 60;
    [mTimer invalidate];
    mTimer = nil;
}

- (BOOL)checkPhoneNum
{
    if (self.mPhoneTextField.text.length == 11) {
        return YES;
    }
    
    NSString *message = nil;
    if (self.mPhoneTextField.text.length == 0) {
        message = _T(@"HF_Common_Phone_Null");
    }
    else if (self.mPhoneTextField.text.length!=11){
        message = _T(@"HF_Common_Input_Right_Phone");
    }
    [self showError:message];
    return NO;
}

- (BOOL)checkCode
{
    if (self.mCodeTextField.text.length == 4)
    {
        return YES;
    }
    
    NSString *message = nil;
    if (self.mCodeTextField.text.length == 0)
    {
        message = _T(@"HF_Common_Code_Null");
    }
    else
    {
        message = _T(@"HF_Common_Code_Error");
    }
    
    [self showError:message];
    
    return NO;
    
}

- (BOOL)checkPwd
{
    if (self.mPwdTextField.text.length>=6 && self.mPwdTextField.text.length<=20)
    {
        return YES;
    }
    
    NSString *message = nil;
    if (self.mPwdTextField.text.length == 0){
        message = _T(@"HF_Common_Password_Null");
    }
    else if (self.mPwdTextField.text.length<6 || self.mPwdTextField.text.length>20){
        message = _T(@"HF_Common_Password_Error");
    }
    
    [self showError:message];
    
    return NO;
}

- (void)showError:(NSString *)message
{
    HFAlertView *alter = [HFAlertView initWithTitle:_T(@"HF_Common_Tips") withMessage:message commpleteBlock:^(NSInteger buttonIndex) {
    } cancelTitle:nil determineTitle:_T(@"HF_Common_OK")];
    [alter show];
}

#pragma mark -
#pragma mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.mPhoneTextField.isEditing) {
        if (textField.text.length==0)
        {
            if (![string isEqualToString:@"1"])
            {
                return NO;
            }
        }
        else if(self.mPhoneTextField.text.length>=11 && string.length>0)
        {
            return NO;
        }
    }
    else if (self.mPwdTextField.isEditing)
    {
        if(self.mPwdTextField.text.length>=20 && string.length>0)
        {
            return NO;
        }
    }
    else
    {
        if(self.mCodeTextField.text.length >= 4 && string.length>0)
        {
            return NO;
        }
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.mCurrentTextField = textField;
    
    self.line1.backgroundColor = [UIColor HFColorStyle_6];
    self.line2.backgroundColor = [UIColor HFColorStyle_6];
    self.line3.backgroundColor = [UIColor HFColorStyle_6];
    
    UIView * line = [self.view viewWithTag:textField.tag + 1];
    line.backgroundColor = [UIColor HFColorStyle_5];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    UIView * line = [self.view viewWithTag:textField.tag + 1];
    line.backgroundColor = [UIColor HFColorStyle_6];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:YES];
    return YES;
}


- (void)dealloc
{
    if (mTimer)
    {
        [mTimer invalidate];
        mTimer = nil;
    }
    
}

@end
