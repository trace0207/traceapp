//
//  TKRegisterViewController.h
//  tracedemo
//
//  Created by cmcc on 15/11/11.
//  Copyright © 2015年 trace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "TKIBaseNavWithDefaultBackVC.h"
@interface TKRegisterViewController : TKIBaseNavWithDefaultBackVC
- (IBAction)countrySelectBtn:(id)sender;
- (IBAction)nextStepBtn:(id)sender;
- (IBAction)userProtocolBtn:(id)sender;



@property (assign,nonatomic)BOOL isForgetPassword; // 是否是 找回密码
@property (strong, nonatomic) IBOutlet UIView *countryDisplayLabel;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumberInputText;
@property (strong, nonatomic) IBOutlet UILabel *bottomLabel;
@property (strong, nonatomic) IBOutlet UIButton *bottomBtn;
@property (strong, nonatomic) IBOutlet UILabel *countryLabel;
@property (strong, nonatomic) IBOutlet UILabel *countryCodeLabel;
- (IBAction)countryBtnAction:(id)sender;

@end
