//
//  TKSetPasswordViewController.h
//  tracedemo
//
//  Created by cmcc on 15/11/13.
//  Copyright © 2015年 trace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "TKIBaseNavWithDefaultBackVC.h"

@interface TKSetPasswordViewController : TKIBaseNavWithDefaultBackVC
- (IBAction)nextBtnAction:(id)sender;
@property (assign,nonatomic) BOOL isForgetPassword;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberbottomText;
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeInput;
@property (weak, nonatomic) IBOutlet UITextField *inviteCodeInput;
@property (weak, nonatomic) IBOutlet UITextField *passwordInput;
@property (weak, nonatomic) IBOutlet UILabel *verifyWaitTimeTipsText;
@property (weak, nonatomic) IBOutlet UILabel *registerPhoneNumber;
- (IBAction)sortwareProtocol:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet UIButton *bottomBtn;

@property (strong, nonatomic) IBOutlet UILabel *keyKabel;
@property (strong, nonatomic) IBOutlet UIView *inviteCodeFiled;
@property (strong, nonatomic) IBOutlet UIView *setPasswordAllFiled;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *passwordMarginTop;

@end
