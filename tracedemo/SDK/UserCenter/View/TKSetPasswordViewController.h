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
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberbottomText;
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeInput;
@property (weak, nonatomic) IBOutlet UITextField *inviteCodeInput;
@property (weak, nonatomic) IBOutlet UITextField *passwordInput;
@property (weak, nonatomic) IBOutlet UILabel *verifyWaitTimeTipsText;
@property (weak, nonatomic) IBOutlet UILabel *registerPhoneNumber;
- (IBAction)sortwareProtocol:(id)sender;


@end
