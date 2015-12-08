//
//  TKLoginViewController.h
//  tracedemo
//
//  Created by cmcc on 15/11/11.
//  Copyright © 2015年 trace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKIBaseNavWithDefaultBackVC.h"
#import "TKClearView.h"

@protocol LoginDelegate <NSObject>

@optional
-(void)onRegisterClick;
-(void)onLoginSuccess;
-(void)onForgetPassword;

@end

@interface TKLoginViewController : TKIBaseNavWithDefaultBackVC

@property (strong, nonatomic) IBOutlet UITextField *userNameText;
@property (strong, nonatomic) IBOutlet UITextField *passwordText;
@property (weak,nonatomic) id<LoginDelegate> delegate;
@property (strong, nonatomic) IBOutlet TKClearView *clearInputView;

- (IBAction)loginBtn:(id)sender;
- (IBAction)forgetPassword:(id)sender;
@end
