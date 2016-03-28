//
//  TKSetPasswordViewController.m
//  tracedemo
//
//  Created by cmcc on 15/11/13.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKSetPasswordViewController.h"
#import "UIViewController+TKNavigationBarSetting.h"
#import "UIColor+TK_Color.h"
#import "AppDelegate.h"
#import "TKUserCenter.h"
#import "TKProxy.h"

@interface TKSetPasswordViewController ()
{

    
    NSInteger  seconds;
    NSTimer         *timer;
    BOOL  timeOut;
    
}

@end

@implementation TKSetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"设置密码";
    
    if(self.isForgetPassword)
    {
        self.bottomBtn.hidden = YES;
        self.bottomLabel.hidden = YES;
    }

    
    _registerPhoneNumber.text = [TKUserCenter instance].tempUserData.mobile;
    _phoneNumberbottomText.text = [TKUserCenter instance].tempUserData.mobile;
    // Do any additional setup after loading the view.

    timeOut = YES;
    [self getVerifyCode];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getVerifyCode)];
    self.verifyWaitTimeTipsText.userInteractionEnabled = YES;
    [self.verifyWaitTimeTipsText addGestureRecognizer:tap];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSString *)TK_getBarTitle{

    return @"设置密码";
}



#pragma mark  verifyCode

// 获取验证码
-(void)getVerifyCode
{
    if(!timeOut)
    {
        return;
    }
 //  codeType   17：消费者注册短信验证码，19：消费者找回密码短信验证码，18：买手注册短信，20：买手找回密码短信验证码
    NSInteger type = 17;
    
#if B_Client == 1
    type = 18;
#endif
    
    [[TKProxy proxy].userProxy getVerifyCode:[TKUserCenter instance].tempUserData.mobile type:type whtiBlock:^(HF_BaseAck * ack){
        [self startTimeCount];
    }];
    
}


-(void)startTimeCount
{
    if(timer)
    {
        [timer invalidate];
        timer = nil;
    }
    timeOut = false;
    seconds = 5;
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(cutdown:) userInfo:nil repeats:YES];
    [timer fire];
}


- (void)cutdown:(NSTimer*)time
{
    seconds = seconds -1;
    if (seconds <0) {
        timeOut = true;
        [timer invalidate];
        self.verifyWaitTimeTipsText.text = @"获取验证码";
    }
    else
    {
        self.verifyWaitTimeTipsText.text = [NSString stringWithFormat:@"%@",@(seconds)]; // "已发送(%@秒)"
    }
    
}


#pragma mark   private event


-(void)dealloc
{
    if(timer)
    {
        [timer invalidate];
        timer = nil;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)nextBtnAction:(id)sender {
    
//    [[AppDelegate getMainNavigation] popToRootViewControllerAnimated:YES];
    
    NSString * verifyCode = self.verifyCodeInput.text;
    NSString * inviteCode = self.inviteCodeInput.text;
    NSString * password = self.passwordInput.text;
    
    [[TKProxy proxy].userProxy registerNewUser:verifyCode
                                    inviteCode:inviteCode
                                     userValue:password
                                        mobile:[TKUserCenter instance].tempUserData.mobile
                                     whtiBlock:^(HF_BaseAck * ack){
        
        DDLogInfo(@"--------- %@  ",ack);
    }];
    
}
- (IBAction)sortwareProtocol:(id)sender {
    TKIBaseNavWithDefaultBackVC *vc = [[TKIBaseNavWithDefaultBackVC alloc] init];
    vc.navTitle = @"软件许可及服务协议";
    [self.navigationController pushViewController:vc animated:YES];
}
@end
