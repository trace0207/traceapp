//
//  SignOneViewController.h
//  GuanHealth
//
//  Created by hermit on 15/2/27.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseViewController.h"

@interface SignOneViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIButton    *getVercode;
@property (weak, nonatomic) IBOutlet UIButton *protocalBtn;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@property (weak, nonatomic) IBOutlet UIView      *line1;
@property (weak, nonatomic) IBOutlet UIView      *line2;

@property (weak, nonatomic) IBOutlet UIImageView *eyeImage;
@property (weak, nonatomic) IBOutlet UIImageView *agreeImage;

- (IBAction)getVercodeAction:(id)sender;
- (IBAction)displayPasswordAction:(id)sender;
- (IBAction)agreeAction:(id)sender;
- (IBAction)seeAgreementAction:(id)sender;

@end
