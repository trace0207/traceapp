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
- (IBAction)cancelBtn:(id)sender;
- (IBAction)countrySelectBtn:(id)sender;
- (IBAction)nextStepBtn:(id)sender;
- (IBAction)userProtocolBtn:(id)sender;




@property (strong, nonatomic) IBOutlet UIView *countryDisplayLabel;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumberInputText;

@end
