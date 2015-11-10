//
//  HFBindPhoneNumViewController.h
//  GuanHealth
//
//  Created by 栋栋 施 on 15/6/17.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseViewController.h"

@interface HFBindPhoneNumViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *mPhoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *mCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *mPwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (weak, nonatomic) IBOutlet UIButton *mSendBtn;
@property (weak, nonatomic) IBOutlet UILabel *mWaitLabel;
@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet UIView *line2;
@property (weak, nonatomic) IBOutlet UIView *line3;
@property (weak, nonatomic) IBOutlet UIButton *mEntryBtn;


- (IBAction)sendCodeAction:(UIButton *)sender;
- (IBAction)bindPhoneAction:(UIButton *)sender;
- (IBAction)checkProctolStatus:(UIButton *)sender;
- (IBAction)viewProctolAction:(UIButton *)sender;
- (IBAction)entryPwdAction:(UIButton *)sender;

@end
