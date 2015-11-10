//
//  LoginViewController.h
//  GuanHealth
//
//  Created by hermit on 15/2/27.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginViewController : BaseViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField    *mobileTextField;
@property (weak, nonatomic) IBOutlet UITextField    *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton       *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton       *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton       *forgetBtn;
@property (weak, nonatomic) IBOutlet UILabel        *line1;
@property (weak, nonatomic) IBOutlet UILabel        *line2;
@property (weak, nonatomic) IBOutlet UILabel        *quickLabel;
@property (weak, nonatomic) IBOutlet UIButton *qqLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *wxLoginBtn;

@property (weak, nonatomic) IBOutlet UIView *loginBoderView;


- (IBAction)forgetAction:(id)sender;
- (IBAction)registerAction:(id)sender;
- (IBAction)loginAction:(id)sender;
- (IBAction)thirdpatyLoginAction:(UIButton*)sender;


@end
