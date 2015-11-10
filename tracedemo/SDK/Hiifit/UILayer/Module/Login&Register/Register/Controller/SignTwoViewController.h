//
//  SignTwoViewController.h
//  GuanHealth
//
//  Created by hermit on 15/2/27.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseViewController.h"

@interface SignTwoViewController : BaseViewController<UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField     *vercodeTextField;

@property (nonatomic, weak) IBOutlet UILabel         *mobileLabel;
@property (nonatomic, weak) IBOutlet UILabel         *secondsLabel;

@property (nonatomic, weak) IBOutlet UIView          *line;

@property (nonatomic, weak) IBOutlet UIButton        *resendBtn;
@property (nonatomic, weak) IBOutlet UIButton        *nextBtn;

@property (nonatomic, weak)          NSTimer         *timer;
@property (nonatomic, assign)        NSInteger       seconds;

- (IBAction)resendAction:(id)sender;
- (IBAction)nextAction:(id)sender;

@end
