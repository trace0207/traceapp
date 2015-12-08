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

@end

@implementation TKSetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _registerPhoneNumber.text = [TKUserCenter instance].tempUserData.mobile;
    _phoneNumberbottomText.text = [TKUserCenter instance].tempUserData.mobile;
    // Do any additional setup after loading the view.
    
//    [TKUserCenter instance].
    
    [[TKProxy proxy].userProxy getVerifyCode:[TKUserCenter instance].tempUserData.mobile type:0 whtiBlock:^(HF_BaseAck * ack){
    
        DDLogInfo(@"--------- %@  ",ack);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSString *)TK_getBarTitle{

    return @"设置密码";
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
    
    NSString * verifyCode = @"111111";
    NSString * inviteCode = @"222222";
    NSString * password = @"aaaaaa";
    
    [[TKProxy proxy].userProxy registerNewUser:verifyCode
                                    inviteCode:inviteCode
                                     userValue:password
                                        mobile:[TKUserCenter instance].tempUserData.mobile
                                     whtiBlock:^(HF_BaseAck * ack){
        
        DDLogInfo(@"--------- %@  ",ack);
    }];
    
    
}
- (IBAction)sortwareProtocol:(id)sender {
}
@end
